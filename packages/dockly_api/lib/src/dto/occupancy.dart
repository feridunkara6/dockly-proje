/// Koy doluluk özeti (2026-07 ayrıştırma paketi ①).
///
/// Son 6 saat penceresindeki bildirimlerden türetilir: `level` EN SON
/// bildirimdir, `reportCount` penceredeki bildirim sayısı, `reportedAt`
/// en son bildirim anı. Pencerede bildirim yoksa sunucu alanı null döner —
/// istemci hiçbir şey göstermez (tahmin YOK; 0 uydurma veri ilkesi).
class OccupancySummary {
  const OccupancySummary({
    required this.level,
    required this.reportedAt,
    required this.reportCount,
  });

  /// 'empty' | 'moderate' | 'full' — istemci etiketi kendi dilinde basar.
  final String level;
  final DateTime reportedAt;
  final int reportCount;

  factory OccupancySummary.fromJson(Map<String, dynamic> json) =>
      OccupancySummary(
        level: json['level'] as String,
        reportedAt: DateTime.parse(json['reportedAt'] as String),
        reportCount: (json['reportCount'] as num).toInt(),
      );

  /// Geriye uyumlu okuma: eski sunucu alanı hiç göndermez → null.
  static OccupancySummary? fromJsonNullable(Object? json) =>
      json is Map<String, dynamic> ? OccupancySummary.fromJson(json) : null;
}
