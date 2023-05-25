import 'dart:convert';

class Collection {
  final String date;
  final String description;
  final String dronetime;
  Collection({
    required this.date,
    required this.description,
    required this.dronetime,
  });

  Collection copyWith({
    String? date,
    String? description,
    String? dronetime,
  }) {
    return Collection(
      date: date ?? this.date,
      description: description ?? this.description,
      dronetime: dronetime ?? this.dronetime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'description': description,
      'dronetime': dronetime,
    };
  }

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      date: map['date'] as String,
      description: map['description'] as String,
      dronetime: map['dronetime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Collection.fromJson(String source) =>
      Collection.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Collection(date: $date, description: $description, dronetime: $dronetime)';

  @override
  bool operator ==(covariant Collection other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.description == description &&
        other.dronetime == dronetime;
  }

  @override
  int get hashCode => date.hashCode ^ description.hashCode ^ dronetime.hashCode;
}
