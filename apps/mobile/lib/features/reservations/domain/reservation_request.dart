/// Bir limana bırakılan rezervasyon/ilgi talebi (misafir/yerel).
///
/// Şimdilik cihazda saklanır ve "Taleplerim" sekmesinde listelenir; marinaya
/// gerçek iletim (backend + hesap) sonraki fazda bağlanacak. Tekne bilgisi talep
/// anındaki "Teknem" değerinden kopyalanır; tarih/adet gibi ayrıntılar serbest
/// "not" alanında tutulur (v1 sadelik).
class ReservationRequest {
  const ReservationRequest({
    required this.id,
    required this.locationId,
    required this.locationName,
    required this.locationType,
    required this.createdAt,
    this.boatLengthM,
    this.boatDraftM,
    this.contactPhone,
    this.note,
  });

  final String id;
  final String locationId;
  final String locationName;
  final String locationType;

  /// ISO-8601 oluşturulma zamanı.
  final String createdAt;

  final double? boatLengthM;
  final double? boatDraftM;
  final String? contactPhone;
  final String? note;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'locationId': locationId,
        'locationName': locationName,
        'locationType': locationType,
        'createdAt': createdAt,
        if (boatLengthM != null) 'boatLengthM': boatLengthM,
        if (boatDraftM != null) 'boatDraftM': boatDraftM,
        if (contactPhone != null) 'contactPhone': contactPhone,
        if (note != null) 'note': note,
      };

  factory ReservationRequest.fromJson(Map<String, dynamic> json) => ReservationRequest(
        id: json['id'] as String,
        locationId: json['locationId'] as String,
        locationName: json['locationName'] as String,
        locationType: json['locationType'] as String,
        createdAt: json['createdAt'] as String,
        boatLengthM: (json['boatLengthM'] as num?)?.toDouble(),
        boatDraftM: (json['boatDraftM'] as num?)?.toDouble(),
        contactPhone: json['contactPhone'] as String?,
        note: json['note'] as String?,
      );
}
