import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Polylines_class extends StatefulWidget {
  @override
  State<Polylines_class> createState() => _PolylinesState();
}

class _PolylinesState extends State<Polylines_class> {
  //googlmapcontroller
  late GoogleMapController _mapController;
  //marker
  Set<Marker> markers = {};
  //polyllines
  Set<Polyline> polylines = {};
  //set camera postion
  final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(33.6844, 73.0479),
    zoom: 14,
  );

  List<LatLng> polylineCoords = [
    LatLng(33.6844, 73.0479), // Islamabad
    LatLng(34.0150, 71.5805), // Peshawar
    LatLng(32.1877, 74.1945), // Gujranwala
    LatLng(33.5848, 73.0658), //ravalpindi
  ];
  //function for markers
  void addmarkers() {
    for (int i = 0; i < polylineCoords.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: polylineCoords[i],
          infoWindow: InfoWindow(title: i.toString()),
        ),
      );
    }
  }

  //function for polylines
  void addpolyline() {
    polylines.add(
      Polyline(
        polylineId: PolylineId("1"),
        points: polylineCoords,
        color: Colors.red,
        width: 4,
        patterns: [PatternItem.dot, PatternItem.dash(3)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        markers: markers,
        polylines: polylines,
        onMapCreated: (controller) {
          _mapController = controller;
          setState(() {
            addmarkers();
            addpolyline();
          });
        },
      ),
    );
  }
}
