/// Favori bir lokasyonun hafif anlık görüntüsü (misafir/yerel favoriler).
///
/// Favoriler cihazda saklandığından, listede göstermek için gereken az veriyi
/// (ad, tip, şehir) favoriye eklerken kaydederiz — böylece Favoriler sekmesi her
/// öğe için ağdan tekrar detay çekmez.
class FavoriteLocation {
  const FavoriteLocation({
    required this.id,
    required this.name,
    required this.type,
    this.city,
  });

  final String id;
  final String name;
  final String type;
  final String? city;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'type': type,
        if (city != null) 'city': city,
      };

  factory FavoriteLocation.fromJson(Map<String, dynamic> json) => FavoriteLocation(
        id: json['id'] as String,
        name: json['name'] as String,
        type: json['type'] as String,
        city: json['city'] as String?,
      );
}
