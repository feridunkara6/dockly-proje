/// Rüzgâr/hava tahmini DTO'ları (`GET /v1/weather`). Kaynak: MET Norway
/// (CC BY 4.0) — `attribution` alanı arayüzde GÖSTERİLMEK ZORUNDADIR.
class ForecastPoint {
  const ForecastPoint({
    required this.time,
    required this.windKn,
    required this.gustKn,
    required this.windDirDeg,
    required this.tempC,
    required this.symbol,
  });

  /// Tahminin geçerli olduğu an (UTC).
  final DateTime time;

  /// Rüzgâr hızı (knot).
  final double windKn;

  /// Hamle/gust (knot) — kaynakta yoksa null.
  final double? gustKn;

  /// Rüzgârın GELDİĞİ yön (derece, 0 = Kuzey).
  final int windDirDeg;

  final double tempC;

  /// MET sembol kodu (ör. 'clearsky_day') — ikon eşleme istemcide.
  final String? symbol;

  factory ForecastPoint.fromJson(Map<String, dynamic> json) => ForecastPoint(
        time: DateTime.parse(json['time'] as String),
        windKn: (json['windKn'] as num).toDouble(),
        gustKn: (json['gustKn'] as num?)?.toDouble(),
        windDirDeg: (json['windDirDeg'] as num).toInt(),
        tempC: (json['tempC'] as num).toDouble(),
        symbol: json['symbol'] as String?,
      );
}

class WeatherForecast {
  const WeatherForecast({
    required this.points,
    required this.fetchedAt,
    required this.attribution,
  });

  final List<ForecastPoint> points;

  /// Sunucunun veriyi kaynaktan aldığı an — arayüz damgayı gösterir (dürüstlük).
  final DateTime fetchedAt;

  /// Zorunlu atıf metni (CC BY 4.0).
  final String attribution;

  factory WeatherForecast.fromJson(Map<String, dynamic> json) => WeatherForecast(
        points: (json['points'] as List<dynamic>? ?? const <dynamic>[])
            .whereType<Map<String, dynamic>>()
            .map(ForecastPoint.fromJson)
            .toList(growable: false),
        fetchedAt: DateTime.parse(json['fetchedAt'] as String),
        attribution: json['attribution'] as String? ?? 'MET Norway (CC BY 4.0)',
      );
}
