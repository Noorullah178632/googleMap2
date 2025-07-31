import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Polygon_Class extends StatefulWidget {
  @override
  State<Polygon_Class> createState() => _PolygonState();
}

class _PolygonState extends State<Polygon_Class> {
  late GoogleMapController _mapController;
  final CameraPosition initialPostion = CameraPosition(
    target: LatLng(33.6844, 73.0479),
    zoom: 14,
  );
  List<Marker> markers = [];
  List<Polygon> polygons = [];
  // Define polygon coordinates
  List<LatLng> polygonCoords = [
    LatLng(33.6844, 73.0479), // Islamabad
    LatLng(34.0150, 71.5805), // Peshawar
    LatLng(32.1877, 74.1945), // Gujranwala
    LatLng(33.5848, 73.0658), //ravalpindi
    LatLng(33.6844, 73.0479), // Back to Islamabad to close polygon
  ];
  //method for markers
  void addmarkers() {
    for (int i = 0; i < polygonCoords.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: polygonCoords[i],
          infoWindow: InfoWindow(title: i.toString()),
        ),
      );
    }
  }

  //method for polygon
  void addpolygon() {
    polygons.add(
      Polygon(
        polygonId: PolygonId("area 1"),
        points: polygonCoords,
        fillColor: Colors.redAccent,
        strokeColor: Colors.blue, // color of edges
        strokeWidth: 3, // width of edges
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: initialPostion,
        markers: markers.toSet(),
        polygons: polygons.toSet(),
        onMapCreated: (controller) {
          _mapController = controller;
          setState(() {
            addmarkers();
            addpolygon();
          });
        },
      ),
    );
  }
}
