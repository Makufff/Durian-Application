import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_1/models/geometry.dart';
import 'package:flutter_application_1_1/models/location.dart';
import 'package:flutter_application_1_1/models/place.dart';
import 'package:flutter_application_1_1/models/place_search.dart';
import 'package:flutter_application_1_1/services/geolocator_service.dart';
import 'package:flutter_application_1_1/services/place_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ApplicationBloc with ChangeNotifier {
  final geolocatorService = GeolocatorService();
  final placeService = PlaceService();
  late LatLng farmLocation;

  final Map<MarkerId, Marker> _markers = {};
  final Map<PolygonId, Polygon> _polygons = {};

  Set<Marker> get markers => _markers.values.toSet();
  Set<Polygon> get polygons => _polygons.values.toSet();

  final _markersController = StreamController<String>.broadcast();
  Stream<String> get onMarkerTap => _markersController.stream;

  Position? currentLocation;
  List<PlaceSearch>? searchResults;
  StreamController<Place> selectedLocation = StreamController<Place>();
  StreamController<LatLngBounds> bounds = StreamController<LatLngBounds>();
  Place? selectedLocationStatic;
  String? placeType;
  List<Place>? placeResults;

  ApplicationBloc() {
    setCurrentLocation();
  }

  void onMapCreated(GoogleMapController controller) {}

  setCurrentLocation() async {
    currentLocation = await geolocatorService.getCurrentLocation();
    selectedLocationStatic = Place(
      name: '',
      geometry: Geometry(
        location: Location(
            lat: currentLocation!.latitude, lng: currentLocation!.longitude),
      ),
      vicinity: '',
    );
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placeService.getAutocomplete(searchTerm);
    notifyListeners();
  }

  setSelectedLocation(String placeId) async {
    var sLocation = await placeService.getPlace(placeId);
    selectedLocation.add(sLocation);
    selectedLocationStatic = sLocation;
    searchResults = null;
    notifyListeners();
  }

  clearSelectedLocation() {
    //selectedLocation.add(null);
    selectedLocationStatic = null;
    searchResults = null;
    placeType = null;
    notifyListeners();
  }

  void createPolygon() {
    late Polygon polygon;
    var polygonCoords = <LatLng>[];
    for (var marker in markers) {
      polygonCoords.add(marker.position);
    }
    farmLocation = _markers.entries.first.value.position;
    _markers.clear();
    polygon = Polygon(
      polygonId: const PolygonId('farm'),
      points: polygonCoords,
      fillColor: const Color.fromRGBO(0, 0, 0, 0),
      strokeWidth: 5,
      strokeColor: Colors.red,
    );

    _polygons[const PolygonId('farm')] = polygon;
    notifyListeners();
  }

  void clearMarker() {
    _polygons.clear();
    polygons.clear();
    _markers.clear();
    notifyListeners();
  }

  void onTap(LatLng position) async {
    /* Marker */
    final id = _markers.length.toString();
    final markerId = MarkerId(_markers.length.toString());
    Marker marker = Marker(
        markerId: markerId,
        position: position,
        draggable: true,
        onTap: () {
          _markersController.sink.add(id);
        },
        onDragEnd: (position) {
          print("😐new position $position");
        });
    _markers[markerId] = marker;
    notifyListeners();
  }

  @override
  void dispose() {
    selectedLocation.close();
    _markersController.close();
    super.dispose();
  }
}
