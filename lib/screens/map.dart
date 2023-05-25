import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:durain_project_app/models/map_collection.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  final List<mapCollection> data;
  final List<String> id;
  final String date;

  const MapScreen(
      {Key? key, required this.data, required this.id, required this.date})
      : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  late GoogleMapController _controller;
  late LatLng CurrentLocation;
  BitmapDescriptor redmarker = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    setCustomMarkerIcon();
    readData();
    super.initState();
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  Set<Marker> MarkerSet = {};

  readData() {
    firstCamera(widget.data[0]);
    for (int i = 0; i < widget.data.length; i++) {
      addMarker(widget.data[i], widget.id[i]);
    }
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/marker/redcircle64.png")
        .then(
      (icon) {
        redmarker = icon;
      },
    );
  }

  void firstCamera(mapCollection model) {
    setState(() {
      CurrentLocation =
          LatLng(double.parse(model.latitude), double.parse(model.longitude));
    });
  }

  void addMarker(mapCollection model, String id) {
    LatLng Coor =
        LatLng(double.parse(model.latitude), double.parse(model.longitude));
    setState(() {
      MarkerSet.add(Marker(
          markerId: MarkerId(id),
          icon: redmarker,
          position: Coor,
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(model.photo),
                          fit: BoxFit.fitWidth,
                          filterQuality: FilterQuality.high),
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        const BoxShadow(
                            color: Color.fromARGB(255, 102, 100, 100),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(6, 6)),
                        const BoxShadow(
                            color: Color.fromARGB(255, 210, 211, 163),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: Offset(-4, -4))
                      ]),
                ),
                Coor);
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 243, 193, 5),
      appBar: AppBar(
        title: Text(widget.date),
        backgroundColor: const Color.fromRGBO(27, 94, 32, 1),
      ),
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: CurrentLocation,
            zoom: 24,
          ),
          markers: MarkerSet,
          onTap: (position) {
            _customInfoWindowController.hideInfoWindow!();
          },
          onCameraMove: (position) {
            _customInfoWindowController.onCameraMove!();
          },
          onMapCreated: (GoogleMapController controller) {
            _customInfoWindowController.googleMapController = controller;
            _controller = controller;
          },
        ),
        CustomInfoWindow(
          controller: _customInfoWindowController,
          height: 100,
          width: 75,
          offset: 50,
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 20),
        child: FloatingActionButton(
          onPressed: () {
            _getCurrentLocation();
          },
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }

  void _getCurrentLocation() async {
    final locationData = await Location.instance.getLocation();
    setState(() {
      // CurrentLocation = LatLng(locationData.latitude!, locationData.longitude!);
      CurrentLocation = LatLng(10.6377511, 99.1779821);
      MarkerSet.add(
        Marker(
            markerId: const MarkerId('CurrentLocation'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
            position: CurrentLocation,
            infoWindow:
                const InfoWindow(title: 'YOU', snippet: 'Current Location')),
      );
    });
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: CurrentLocation,
          zoom: 24,
        ),
      ),
    );
  }
}
