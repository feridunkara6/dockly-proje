/// Kullanıcının teknesi — hafif, oturum içi model (docs/01-prd §6.2 basitleştirilmiş).
/// Kalıcılık (cihazda hatırlama) bir sonraki küçük adımda eklenecek.
class MyBoat {
  const MyBoat({required this.lengthM, this.draftM});

  /// Tekne boyu (m) — zorunlu.
  final double lengthM;

  /// Su çekimi (m) — opsiyonel (bilinmiyorsa null).
  final double? draftM;
}

/// Bir lokasyona tekne uygunluğu (docs/01-prd §6.5 tekne uyumu).
enum BoatFit { fits, tooBig, unknown }

/// Tekne boy/su çekimini lokasyonun limitleriyle karşılaştırır.
/// - Tekne tanımsızsa ya da lokasyonun hiçbir limiti bilinmiyorsa → `unknown`.
/// - Bilinen bir limit aşılıyorsa → `tooBig`.
/// - Bilinen limitlerin hiçbiri aşılmıyorsa → `fits`.
BoatFit computeBoatFit({
  required MyBoat? boat,
  required double? maxBoatLengthM,
  required double? maxDraftM,
}) {
  if (boat == null) return BoatFit.unknown;
  if (maxBoatLengthM == null && maxDraftM == null) return BoatFit.unknown;
  if (maxBoatLengthM != null && boat.lengthM > maxBoatLengthM) return BoatFit.tooBig;
  if (maxDraftM != null && boat.draftM != null && boat.draftM! > maxDraftM) {
    return BoatFit.tooBig;
  }
  return BoatFit.fits;
}
