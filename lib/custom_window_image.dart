import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';

class CustomWindowImage extends StatefulWidget {
  const CustomWindowImage({super.key});

  @override
  State<CustomWindowImage> createState() => _CustomWindowImageState();
}

class _CustomWindowImageState extends State<CustomWindowImage> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  GoogleMapController? _googleMapController;

  static final LatLng _location = LatLng(
    34.1435,
    71.7474,
  ); // Charsadda Graveyard

  static final CameraPosition cameraPosition = CameraPosition(
    target: _location,
    zoom: 14,
  );

  final List<Marker> marker = [];

  @override
  void initState() {
    super.initState();
    marker.add(
      Marker(
        markerId: MarkerId("1"),
        position: _location,
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            Container(
              width: 250,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: const [
                  Text(
                    "Charsadda",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Charsadda Graveyard"),
                ],
              ),
            ),
            _location,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: cameraPosition,
            onMapCreated: (controller) {
              _googleMapController = controller;
              _customInfoWindowController.googleMapController = controller;
            },
            markers: marker.toSet(),
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 100,
            width: 250,
            offset: 50,
          ),
        ],
      ),
    );
  }
}
