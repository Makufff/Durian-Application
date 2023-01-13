import 'package:flutter_application_1_1/models/location.dart';

class Geometry {
  final Location location;

  Geometry({required this.location});

  // factory Geometry.fromJson(Map<dynamic, dynamic> parsedJson) {
  //   return Geometry(location: Location.formJson(parsedJson['location']));
  // }

  Geometry.fromJson(Map<dynamic, dynamic> parsedJson)
      : location = Location.formJson(parsedJson['location']);
}
