import 'dart:math' as math;

import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart' show AppFailure;
import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/external_links.dart';
import '../../../core/location_type_labels.dart';
import '../../../core/origin_provider.dart';
import '../../boat/presentation/boat_fit.dart';
import '../../nearby/presentation/nearby_alternatives.dart';
import '../../route/domain/sea_route.dart';
import '../application/location_detail_controller.dart';

/// Lokasyon detay ekranı (S-09, docs/01-prd §6.6). Türe özel bölümleri,
/// olanakları, iletişimi ve boyut/kapasite verisini gösterir. Yazma eylemleri
/// (yorum, favori, talep) misafir modda kilitli — sonraki fazda bağlanacak.
class LocationDetailScreen extends ConsumerWidget {
  const LocationDetailScreen({required this.idOrSlug, super.key});

  final String idOrSlug;

  static const ValueKey<String> contentKey = ValueKey<String>('location-detail-content');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<LocationDetail> async = ref.watch(locationDetailProvider(idOrSlug));
    return Scaffold(
      appBar: AppBar(title: Text(async.valueOrNull?.name ?? 'Liman')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object err, _) => _DetailError(
          message: err is AppFailure ? err.message : 'Detay yüklenemedi.',
          onRetry: () => ref.invalidate(locationDetailProvider(idOrSlug)),
        ),
        data: (LocationDetail d) => _DetailContent(detail: d),
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.detail});

  final LocationDetail detail;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<_Fact> facts = _dimensionFacts(detail.dimensions)
      ..addAll(_typeFacts(detail.typeDetails));

    return ListView(
      key: LocationDetailScreen.contentKey,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: <Widget>[
        // Kapak fotoğrafı (varsa) — misafirin ilk gördüğü şey (P0).
        if (detail.media.cover != null) ...<Widget>[
          _CoverPhoto(url: detail.media.cover!.url),
          const SizedBox(height: 14),
        ],
        // Başlık bloğu
        Row(
          children: <Widget>[
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: DocklyMapColors.forType(detail.type),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(locationTypeLabelTr(detail.type), style: theme.textTheme.labelLarge),
            if (detail.verifiedAt != null) ...<Widget>[
              const SizedBox(width: 8),
              const Icon(Icons.verified, size: 16, color: DocklyColors.success),
            ],
          ],
        ),
        const SizedBox(height: 6),
        Text(detail.name, style: theme.textTheme.headlineSmall),
        if (_locationLine(detail.geo) != null) ...<Widget>[
          const SizedBox(height: 4),
          Text(_locationLine(detail.geo)!, style: theme.textTheme.bodyMedium),
        ],
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            const Icon(Icons.star, size: 18, color: DocklyColors.warning),
            const SizedBox(width: 4),
            Text(
              detail.rating.avg != null
                  ? '${detail.rating.avg!.toStringAsFixed(1)} (${detail.rating.count})'
                  : 'Henüz puan yok',
            ),
            const SizedBox(width: 12),
            if (priceTierLabelTr(detail.priceTier) != null)
              _Pill(label: priceTierLabelTr(detail.priceTier)!),
            if (detail.is24h) ...<Widget>[
              const SizedBox(width: 8),
              const _Pill(label: '7/24'),
            ],
          ],
        ),

        const SizedBox(height: 12),
        BoatFitRow(
          maxBoatLengthM: detail.dimensions.maxBoatLengthM,
          maxDraftM: detail.dimensions.maxDraftM,
        ),
        _SeaRouteRow(destination: detail.position),

        if (detail.description != null && detail.description!.trim().isNotEmpty) ...<Widget>[
          const SizedBox(height: 16),
          Text(detail.description!, style: theme.textTheme.bodyLarge),
        ],

        if (facts.isNotEmpty) ...<Widget>[
          const SizedBox(height: 20),
          const _SectionTitle('Bilgiler'),
          const SizedBox(height: 6),
          for (final _Fact f in facts) _FactRow(label: f.label, value: f.value),
        ],

        if (detail.amenities.isNotEmpty) ...<Widget>[
          const SizedBox(height: 20),
          const _SectionTitle('Olanaklar'),
          const SizedBox(height: 8),
          _Chips(labels: detail.amenities.map((AmenityLabeled a) => a.label).toList()),
        ],

        if (detail.services.isNotEmpty) ...<Widget>[
          const SizedBox(height: 20),
          const _SectionTitle('Hizmetler'),
          const SizedBox(height: 8),
          _Chips(labels: detail.services.map((ServiceLabeled s) => s.label).toList()),
        ],

        if (detail.contacts.isNotEmpty) ...<Widget>[
          const SizedBox(height: 20),
          const _SectionTitle('İletişim'),
          const SizedBox(height: 6),
          for (final Contact c in detail.contacts) _ContactRow(contact: c),
        ],

        NearbyAlternatives(locationId: detail.id, position: detail.position),
      ],
    );
  }

  static String? _locationLine(GeoInfo geo) {
    final List<String> parts = <String>[];
    final AdminAreaRef? area = geo.adminArea;
    if (area != null) {
      parts.add(area.name);
      if (area.province != null && area.province != area.name) parts.add(area.province!);
    }
    if (geo.waterBody != null) parts.add(geo.waterBody!.name);
    return parts.isEmpty ? null : parts.join(' · ');
  }

  static List<_Fact> _dimensionFacts(Dimensions d) {
    final List<_Fact> facts = <_Fact>[];
    if (d.maxBoatLengthM != null) facts.add(_Fact('Maks. tekne boyu', '${_num(d.maxBoatLengthM!)} m'));
    if (d.maxDraftM != null) facts.add(_Fact('Maks. su çekimi', '${_num(d.maxDraftM!)} m'));
    if (d.depthMinM != null || d.depthMaxM != null) {
      facts.add(_Fact('Derinlik', _range(d.depthMinM, d.depthMaxM)));
    }
    if (d.capacity != null) facts.add(_Fact('Kapasite', '${d.capacity} tekne'));
    return facts;
  }

  static List<_Fact> _typeFacts(TypeDetails? td) {
    if (td == null) return <_Fact>[];
    return switch (td) {
      MarinaTypeDetails m => <_Fact>[
          if (m.berthCount != null) _Fact('Bağlama kapasitesi', '${m.berthCount}'),
          if (m.vhfChannel != null) _Fact('VHF kanalı', m.vhfChannel!),
          if (m.hasBlueFlag == true) const _Fact('Mavi Bayrak', 'Var'),
          if (m.travelLiftCapacityTons != null)
            _Fact('Travel-lift', '${_num(m.travelLiftCapacityTons!)} ton'),
          if (m.winterStorage == true) const _Fact('Kışlama', 'Var'),
        ],
      FuelDockTypeDetails f => <_Fact>[
          if (f.hasDiesel == true) const _Fact('Dizel', 'Var'),
          if (f.hasGasoline == true) const _Fact('Benzin', 'Var'),
          if (f.hasAdblue == true) const _Fact('AdBlue', 'Var'),
          if (f.minDepthM != null) _Fact('Yanaşma derinliği', '${_num(f.minDepthM!)} m'),
          if (f.paymentNote != null) _Fact('Ödeme', f.paymentNote!),
        ],
      RestaurantDockTypeDetails r => <_Fact>[
          if (r.cuisine != null) _Fact('Mutfak', r.cuisine!),
          if (r.berthCountFree != null) _Fact('Ücretsiz bağlama', '${r.berthCountFree} tekne'),
          if (r.minSpendPolicy != null) _Fact('Politika', r.minSpendPolicy!),
          if (r.reservationRecommended == true) const _Fact('Rezervasyon', 'Önerilir'),
        ],
      AnchorageTypeDetails a => <_Fact>[
          if (a.holdingType != null) _Fact('Dip tutunma', holdingTypeLabelTr(a.holdingType!)),
          if (a.swellExposure != null) _Fact('Dalga maruziyeti', a.swellExposure!),
          _Fact('Ücret', a.isFree ? 'Ücretsiz' : 'Ücretli'),
        ],
      UnknownTypeDetails() => <_Fact>[],
    };
  }

  static String _range(double? min, double? max) {
    if (min != null && max != null) return '${_num(min)}–${_num(max)} m';
    return '${_num((min ?? max)!)} m';
  }

  static String _num(double v) =>
      v == v.roundToDouble() ? v.toInt().toString() : v.toString();
}

class _CoverPhoto extends StatelessWidget {
  const _CoverPhoto({required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? progress) {
            if (progress == null) return child;
            return const ColoredBox(
              color: Color(0x11000000),
              child: Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            );
          },
          errorBuilder: (BuildContext context, Object error, StackTrace? stack) {
            return const ColoredBox(
              color: Color(0x11000000),
              child: Center(
                child: Icon(Icons.image_not_supported_outlined, color: DocklyColors.brandDeep),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Deniz-rota önizlemesi (P2, docs vizyon — denizcilik-odaklı rota, karayolu YOK).
/// Başlangıç noktası (harita merkezi) biliniyorsa: yön (pusula + ok) + kuşuçuşu
/// deniz mili + kaba süre. Başlangıç yoksa gizlenir.
class _SeaRouteRow extends ConsumerWidget {
  const _SeaRouteRow({required this.destination});

  final GeoPoint destination;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GeoPoint? origin = ref.watch(originProvider);
    if (origin == null) return const SizedBox.shrink();
    final SeaRoutePreview route = computeSeaRoute(origin, destination);
    if (route.distanceNm < 0.05) return const SizedBox.shrink();
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: DocklyColors.brandPrimary),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: <Widget>[
            Transform.rotate(
              angle: route.bearingDeg * math.pi / 180.0,
              child: const Icon(Icons.navigation, color: DocklyColors.brandPrimary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Deniz yolu · ${route.compass}', style: theme.textTheme.titleSmall),
                  const SizedBox(height: 2),
                  Text(
                    '${_fmtNm(route.distanceNm)} deniz mili · ~${_fmtEta(route.etaHoursAtCruise)} (8 kn)',
                    style: theme.textTheme.bodyMedium,
                  ),
                  Text(
                    'Haritada baktığın konumdan · kuşuçuşu',
                    style: theme.textTheme.bodySmall?.copyWith(color: DocklyColors.brandDeep),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _fmtNm(double nm) => nm >= 10 ? nm.round().toString() : nm.toStringAsFixed(1);

String _fmtEta(double hours) {
  if (!hours.isFinite) return '—';
  if (hours < 1) return '${(hours * 60).round()} dk';
  int h = hours.floor();
  int m = ((hours - h) * 60).round();
  if (m == 60) {
    h += 1;
    m = 0;
  }
  return m == 0 ? '$h sa' : '$h sa $m dk';
}

class _Fact {
  const _Fact(this.label, this.value);
  final String label;
  final String value;
}

class _FactRow extends StatelessWidget {
  const _FactRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Text(label, style: const TextStyle(color: DocklyColors.brandDeep)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleMedium);
  }
}

class _Chips extends StatelessWidget {
  const _Chips({required this.labels});
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: <Widget>[
        for (final String label in labels) Chip(label: Text(label)),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.contact});
  final Contact contact;

  @override
  Widget build(BuildContext context) {
    final Uri? uri = contactUri(contact.type, contact.value);
    final Widget inner = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Icon(_iconFor(contact.type), size: 18, color: DocklyColors.brandPrimary),
          const SizedBox(width: 10),
          Expanded(child: Text(contact.value)),
          if (uri != null)
            const Icon(Icons.open_in_new, size: 16, color: DocklyColors.brandDeep),
        ],
      ),
    );
    // Açılabilen türler (telefon/WhatsApp/web/e-posta) tek dokunuşla çalışır;
    // VHF gibi açılamayanlar düz metin kalır.
    if (uri == null) return inner;
    return InkWell(
      onTap: () => launchContact(context, contact.type, contact.value),
      child: inner,
    );
  }

  static IconData _iconFor(String type) {
    switch (type) {
      case 'phone':
        return Icons.phone;
      case 'whatsapp':
        return Icons.chat;
      case 'email':
        return Icons.email;
      case 'website':
        return Icons.language;
      case 'vhf':
        return Icons.radio;
      case 'instagram':
      case 'facebook':
        return Icons.public;
      default:
        return Icons.info_outline;
    }
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: DocklyColors.brandPrimary),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, color: DocklyColors.brandPrimary),
      ),
    );
  }
}

class _DetailError extends StatelessWidget {
  const _DetailError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            DocklyButton(label: 'Tekrar dene', onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}
