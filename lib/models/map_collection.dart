import 'dart:convert';

class mapCollection {
  final String latitude;
  final String longitude;
  final String photo;

  mapCollection({
    required this.latitude,
    required this.longitude,
    required this.photo,
  });

  mapCollection copyWith({
    String? latitude,
    String? longitude,
    String? photo,
  }) {
    return mapCollection(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'photo': photo,
    };
  }

  factory mapCollection.fromMap(Map<String, dynamic> map) {
    return mapCollection(
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      photo: map['photo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory mapCollection.fromJson(String source) =>
      mapCollection.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'mapCollection(latitude: $latitude, longitude: $longitude, photo: $photo)';

  @override
  bool operator ==(covariant mapCollection other) {
    if (identical(this, other)) return true;

    return other.latitude == latitude &&
        other.longitude == longitude &&
        other.photo == photo;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode ^ photo.hashCode;
}
