import 'package:dockly_api/dockly_api.dart' show LocationPin;
import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';

import '../../../core/location_type_labels.dart';

/// Harita alt detay kartı (S-06, docs/01-prd §6.3). Pine dokununca alttan belirir:
/// tip (renk noktası + etiket), ad, puan ve fiyat rozeti. "Detay"/"Yol tarifi"
/// aksiyonları B.4'te (navigasyon + harici harita) eklenir.
class LocationBottomCard extends StatelessWidget {
  const LocationBottomCard({required this.pin, required this.onClose, super.key});

  final LocationPin pin;
  final VoidCallback onClose;

  static const ValueKey<String> cardKey = ValueKey<String>('location-bottom-card');

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String? priceLabel = priceTierLabelTr(pin.priceTier);
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Material(
          key: cardKey,
          elevation: 8,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 6, 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: DocklyMapColors.forType(pin.type),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        locationTypeLabelTr(pin.type),
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: onClose,
                      tooltip: 'Kapat',
                    ),
                  ],
                ),
                Text(
                  pin.name,
                  style: theme.textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    const Icon(Icons.star, size: 18, color: DocklyColors.warning),
                    const SizedBox(width: 4),
                    Text(pin.ratingAvg != null ? pin.ratingAvg!.toStringAsFixed(1) : 'Puan yok'),
                    if (priceLabel != null) ...<Widget>[
                      const SizedBox(width: 12),
                      _PriceBadge(label: priceLabel),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PriceBadge extends StatelessWidget {
  const _PriceBadge({required this.label});

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
