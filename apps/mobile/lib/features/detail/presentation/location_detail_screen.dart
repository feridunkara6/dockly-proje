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
import '../../favorites/domain/favorite_location.dart';
import '../../favorites/presentation/favorite_button.dart';
import '../../nearby/presentation/nearby_alternatives.dart';
import '../../reservation/presentation/reservation_sheet.dart';
import '../../reviews/presentation/reviews_section.dart';
import '../../route/domain/sea_route.dart';
import '../application/location_detail_controller.dart';
import '../domain/anchorage_notes.dart';
import 'cover_photo.dart';
import 'maritime_info_panel.dart';
import '../../weather/presentation/weather_card.dart';
import 'operating_info.dart';

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
    final LocationDetail? loaded = async.valueOrNull;
    return Scaffold(
      appBar: AppBar(
        title: Text(loaded?.name ?? 'Liman'),
        actions: <Widget>[
          if (loaded != null) FavoriteButton(favorite: _favoriteFrom(loaded)),
        ],
      ),
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

/// Detaydan favori anlık görüntüsü üretir (ad/tip/şehir) — Favoriler sekmesinde
/// gösterim için gereken az veri.
FavoriteLocation _favoriteFrom(LocationDetail d) {
  final AdminAreaRef? area = d.geo.adminArea;
  final String? city = area?.name ?? d.geo.waterBody?.name;
  return FavoriteLocation(id: d.id, name: d.name, type: d.type, city: city);
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.detail});

  final LocationDetail detail;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // Denizci bilgileri: boyut + türe özel veriden yalnız DOLU alanlar stat'a
    // çevrilir (uydurma veri yok). Tekne boyu/su çekimi zaten BoatFitRow'da
    // gösterildiği için burada tekrar edilmez.
    final List<MaritimeStat> stats = <MaritimeStat>[
      ..._dimensionStats(detail.dimensions),
      ..._typeStats(detail.typeDetails),
    ];

    // Demirleme tiplerinde açıklama cümle cümle ayrıştırılır: zemin/DİKKAT
    // cümleleri "Demirleme Notları" kartına taşınır, koyu anlatan metin
    // aşağıda açıklama olarak kalır (ürün kararı 2026-07, 0-uydurma).
    final AnchorageDescriptionSplit? split =
        _isAnchoringType(detail.type) ? splitAnchorageDescription(detail.description) : null;
    final String? descriptionBelow =
        split != null ? split.general : detail.description;

    return ListView(
      key: LocationDetailScreen.contentKey,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: <Widget>[
        // Kapak: fotoğraf varsa onu, yoksa tasarımlı tip-renkli yer tutucu
        // göster (misafirin ilk gördüğü şey — sayfa hiç boş görünmesin, P0).
        if (detail.media.cover != null) ...<Widget>[
          CoverPhoto(cover: detail.media.cover!),
          const SizedBox(height: 14),
        ] else ...<Widget>[
          // Etiket YOK: tip zaten hemen altta gösteriliyor (tekrar olmasın).
          DocklyCoverPlaceholder(type: detail.type, title: detail.name),
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
              const DocklyIcon(DocklyIcons.verified, size: 16, color: DocklyColors.success),
            ],
          ],
        ),
        const SizedBox(height: 6),
        // Fotoğraf varsa isim burada (H1); yer tutucu "hero" kullanılıyorsa isim
        // zaten kapağın üstünde, tekrar etmemek için gizlenir.
        if (detail.media.cover != null)
          Text(detail.name, style: theme.textTheme.headlineSmall),
        if (_locationLine(detail.geo) != null) ...<Widget>[
          const SizedBox(height: 4),
          Text(_locationLine(detail.geo)!, style: theme.textTheme.bodyMedium),
        ],
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            const DocklyIcon(DocklyIcons.star, size: 18, color: DocklyColors.warning),
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

        const SizedBox(height: 14),
        // ÜRÜN KARARI: demirleme yerlerinde (koy/şamandıra/tonoz) rezervasyon
        // OLMAZ — ilk gelen demirler. Bu tiplerde talep düğmesi yerine
        // "Demirleme Notları" gösterilir; diğer tiplerde düğme kalır.
        if (split != null)
          _AnchoringNotes(detail: detail, split: split)
        else
          SizedBox(
            width: double.infinity,
            child: DocklyButton(
              label: 'Rezervasyon Talebi',
              icon: DocklyIcons.eventNote,
              onPressed: () => showReservationSheet(
                context,
                locationName: detail.name,
                contacts: detail.contacts,
              ),
            ),
          ),

        if (descriptionBelow != null && descriptionBelow.trim().isNotEmpty) ...<Widget>[
          const SizedBox(height: 16),
          Text(descriptionBelow, style: theme.textTheme.bodyLarge),
        ],

        MaritimeInfoPanel(stats: stats),

        if (detail.amenities.isNotEmpty) ...<Widget>[
          const SizedBox(height: 20),
          const _SectionTitle('Olanaklar'),
          const SizedBox(height: 8),
          _IconChips(
            items: <(DocklyIconData, String)>[
              for (final AmenityLabeled a in detail.amenities)
                (DocklyIcons.forAmenity(a.code), a.label),
            ],
          ),
        ],

        if (detail.services.isNotEmpty) ...<Widget>[
          const SizedBox(height: 20),
          const _SectionTitle('Hizmetler'),
          const SizedBox(height: 8),
          _IconChips(
            items: <(DocklyIconData, String)>[
              for (final ServiceLabeled s in detail.services)
                (DocklyIcons.forAmenity(s.code), s.label),
            ],
          ),
        ],

        OperatingInfo(
          hours: detail.hours,
          seasons: detail.seasons,
          is24h: detail.is24h,
        ),

        // Rüzgâr & Hava — noktanın 48 saatlik tahmini (MET Norway, atıflı).
        WeatherCard(position: detail.position),

        if (detail.contacts.isNotEmpty) ...<Widget>[
          const SizedBox(height: 20),
          const _SectionTitle('İletişim'),
          const SizedBox(height: 6),
          for (final Contact c in detail.contacts) _ContactRow(contact: c),
        ],

        ReviewsSection(idOrSlug: detail.id),
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

  /// Boyut verisi → stat kartları. Tekne boyu & su çekimi bilerek DIŞARIDA:
  /// onları BoatFitRow zaten üstte gösteriyor (tekrar olmasın).
  static List<MaritimeStat> _dimensionStats(Dimensions d) {
    return <MaritimeStat>[
      if (d.depthMinM != null || d.depthMaxM != null)
        MaritimeStat(
          icon: DocklyIcons.straighten,
          value: _range(d.depthMinM, d.depthMaxM),
          label: 'Derinlik',
        ),
      if (d.capacity != null)
        MaritimeStat(icon: DocklyIcons.amMooring, value: '${d.capacity}', label: 'Kapasite'),
    ];
  }

  /// Türe özel detay → stat kartları (yalnız dolu alanlar; switch EXPRESSION ile
  /// enum'lar üzerinde tam kapsama).
  static List<MaritimeStat> _typeStats(TypeDetails? td) {
    if (td == null) return const <MaritimeStat>[];
    return switch (td) {
      MarinaTypeDetails m => <MaritimeStat>[
          if (m.berthCount != null)
            MaritimeStat(icon: DocklyIcons.amMooring, value: '${m.berthCount}', label: 'Bağlama'),
          if (m.vhfChannel != null)
            MaritimeStat(icon: DocklyIcons.radio, value: m.vhfChannel!, label: 'VHF kanalı'),
          if (m.hasBlueFlag == true)
            const MaritimeStat(icon: DocklyIcons.verified, value: 'Var', label: 'Mavi Bayrak'),
          if (m.travelLiftCapacityTons != null)
            MaritimeStat(
              icon: DocklyIcons.amCrane,
              value: '${_num(m.travelLiftCapacityTons!)} ton',
              label: 'Travel-lift',
            ),
          if (m.winterStorage == true)
            const MaritimeStat(icon: DocklyIcons.amTool, value: 'Var', label: 'Kışlama'),
        ],
      FuelDockTypeDetails f => <MaritimeStat>[
          if (f.hasDiesel == true)
            const MaritimeStat(icon: DocklyIcons.amFuel, value: 'Var', label: 'Dizel'),
          if (f.hasGasoline == true)
            const MaritimeStat(icon: DocklyIcons.amFuel, value: 'Var', label: 'Benzin'),
          if (f.hasAdblue == true)
            const MaritimeStat(icon: DocklyIcons.amFuel, value: 'Var', label: 'AdBlue'),
          if (f.minDepthM != null)
            MaritimeStat(
              icon: DocklyIcons.straighten,
              value: '${_num(f.minDepthM!)} m',
              label: 'Yanaşma derinliği',
            ),
          if (f.paymentNote != null)
            MaritimeStat(icon: DocklyIcons.infoOutline, value: f.paymentNote!, label: 'Ödeme'),
        ],
      RestaurantDockTypeDetails r => <MaritimeStat>[
          if (r.cuisine != null)
            MaritimeStat(icon: DocklyIcons.amRestaurant, value: r.cuisine!, label: 'Mutfak'),
          if (r.berthCountFree != null)
            MaritimeStat(
              icon: DocklyIcons.amMooring,
              value: '${r.berthCountFree}',
              label: 'Ücretsiz bağlama',
            ),
          if (r.minSpendPolicy != null)
            MaritimeStat(icon: DocklyIcons.infoOutline, value: r.minSpendPolicy!, label: 'Politika'),
          if (r.reservationRecommended == true)
            const MaritimeStat(
              icon: DocklyIcons.eventNote,
              value: 'Önerilir',
              label: 'Rezervasyon',
            ),
        ],
      AnchorageTypeDetails a => <MaritimeStat>[
          if (a.holdingType != null)
            MaritimeStat(
              icon: DocklyIcons.amMooring,
              value: holdingTypeLabelTr(a.holdingType!),
              label: 'Dip tutunma',
            ),
          if (a.swellExposure != null)
            MaritimeStat(
              icon: DocklyIcons.sailing,
              value: a.swellExposure!,
              label: 'Dalga maruziyeti',
            ),
          MaritimeStat(
            icon: DocklyIcons.infoOutline,
            value: a.isFree ? 'Ücretsiz' : 'Ücretli',
            label: 'Ücret',
          ),
        ],
      UnknownTypeDetails() => const <MaritimeStat>[],
    };
  }

  static String _range(double? min, double? max) {
    if (min != null && max != null) return '${_num(min)}–${_num(max)} m';
    return '${_num((min ?? max)!)} m';
  }

  static String _num(double v) =>
      v == v.roundToDouble() ? v.toInt().toString() : v.toString();
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
              child: const DocklyIcon(DocklyIcons.navigation, color: DocklyColors.brandPrimary),
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
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleMedium);
  }
}

/// Olanak/hizmet çipleri — her biri tasarım sistemi denizcilik ikonuyla (docs/09,
/// design §03). İkon marka mavisi; çip kenarlığı temadan gelir.
class _IconChips extends StatelessWidget {
  const _IconChips({required this.items});
  final List<(DocklyIconData, String)> items;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: <Widget>[
        for (final (DocklyIconData icon, String label) in items)
          Chip(
            avatar: DocklyIcon(icon, size: 18, color: DocklyColors.brandPrimary),
            label: Text(label),
          ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.contact});
  final Contact contact;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String? label = contact.label;
    final Uri? uri = contactUri(contact.type, contact.value);
    final Widget valueWidget = label == null
        ? Text(contact.value)
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                label,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              Text(contact.value),
            ],
          );
    final Widget inner = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          DocklyIcon(_iconFor(contact.type), size: 18, color: DocklyColors.brandPrimary),
          const SizedBox(width: 10),
          Expanded(child: valueWidget),
          if (uri != null)
            DocklyIcon(DocklyIcons.openInNew,
                size: 16, color: theme.colorScheme.onSurfaceVariant),
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

  static DocklyIconData _iconFor(String type) {
    switch (type) {
      case 'phone':
      case 'emergency':
        return DocklyIcons.phone;
      case 'whatsapp':
        return DocklyIcons.chat;
      case 'email':
        return DocklyIcons.email;
      case 'website':
        return DocklyIcons.language;
      case 'reservation_link':
        return DocklyIcons.openInNew;
      case 'vhf':
        return DocklyIcons.radio;
      case 'instagram':
      case 'facebook':
        return DocklyIcons.social;
      default:
        return DocklyIcons.infoOutline;
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


/// Rezervasyonun ANLAMSIZ olduğu tipler: demirleme koyu, şamandıra, misafir
/// tonozu — buralarda ilk gelen demirler (ürün kararı, 2026-07).
bool _isAnchoringType(String type) =>
    type == 'mooring_point' || type == 'buoy' || type == 'guest_mooring';

/// "Demirleme Notları" — rezervasyon düğmesinin yerini alan bilgi kutusu.
/// Sabit metin yerine KOYA ÖZEL veri gösterir (ürün kararı 2026-07):
/// zemin (dip tutunması) + derinlik satırları ve açıklamadan ayrıştırılan
/// demirleme/DİKKAT cümleleri. UYDURMA VERİ YOK ilkesi: yalnız kayıtlı alanlar
/// ve açıklamada zaten var olan cümleler; koya özel veri hiç yoksa bunu
/// dürüstçe söyleyen tek satır kalır.
class _AnchoringNotes extends StatelessWidget {
  const _AnchoringNotes({required this.detail, required this.split});

  final LocationDetail detail;
  final AnchorageDescriptionSplit split;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AnchorageTypeDetails? a = switch (detail.typeDetails) {
      final AnchorageTypeDetails t => t,
      _ => null,
    };
    final String? zemin = a?.holdingType == null ? null : _capTr(holdingTypeLabelTr(a!.holdingType!));
    final String? depth = _depthText(detail.dimensions);
    final bool hasSpecific = zemin != null ||
        depth != null ||
        split.anchoring.isNotEmpty ||
        split.warnings.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              DocklyIcon(DocklyIcons.amMooring, size: 18, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text('Demirleme Notları',
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            detail.priceTier == 'free'
                ? 'Rezervasyon yapılmaz — ilk gelen demirler. Ücretsiz demirleme alanıdır.'
                : 'Rezervasyon yapılmaz — ilk gelen demirler.',
            style: theme.textTheme.bodyMedium,
          ),
          // Koya özel yapısal satırlar (yalnız kayıtlı alanlar).
          if (zemin != null)
            _NoteRow(icon: DocklyIcons.amMooring, text: 'Zemin: $zemin'),
          if (depth != null)
            _NoteRow(icon: DocklyIcons.straighten, text: 'Derinlik: $depth'),
          // Açıklamadan taşınan demirleme/zemin cümleleri.
          for (final String s in split.anchoring)
            _NoteRow(icon: DocklyIcons.infoOutline, text: s),
          // DİKKAT cümleleri — uyarı renginde, vurgulu.
          for (final String s in split.warnings)
            _NoteRow(
              icon: DocklyIcons.errorOutline,
              text: s,
              color: DocklyColors.warning,
              emphasize: true,
            ),
          if (!hasSpecific) ...<Widget>[
            const SizedBox(height: 6),
            Text(
              'Bu nokta için kayıtlı zemin ve uyarı bilgisi henüz yok — '
              'derinlik ve dip tutunmasını yerinde kontrol edin.',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }

  /// Derinlik metni: "7–8 m" / "7 m" / null (veri yoksa satır çıkmaz).
  static String? _depthText(Dimensions d) {
    final double? min = d.depthMinM;
    final double? max = d.depthMaxM;
    if (min == null && max == null) return null;
    String n(double v) => v == v.roundToDouble() ? v.toInt().toString() : v.toString();
    if (min != null && max != null && min != max) return '${n(min)}–${n(max)} m';
    return '${n((min ?? max)!)} m';
  }

  /// Türkçe baş harf büyütme ("çamur" → "Çamur"; i→İ, ı→I kuralına saygılı).
  static String _capTr(String s) {
    if (s.isEmpty) return s;
    final String first = switch (s[0]) {
      'i' => 'İ',
      'ı' => 'I',
      final String c => c.toUpperCase(),
    };
    return first + s.substring(1);
  }
}

/// Demirleme Notları içindeki tek satır: küçük ikon + metin.
class _NoteRow extends StatelessWidget {
  const _NoteRow({
    required this.icon,
    required this.text,
    this.color,
    this.emphasize = false,
  });

  final DocklyIconData icon;
  final String text;
  final Color? color;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DocklyIcon(icon, size: 16, color: color ?? theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: emphasize ? FontWeight.w600 : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
