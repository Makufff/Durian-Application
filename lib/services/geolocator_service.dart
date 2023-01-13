import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<Position> getCurrentLocation() async {
    // var geolocator = Geolocator();
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
