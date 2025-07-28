import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';

class CustomWindowImage extends StatefulWidget {
  const CustomWindowImage({super.key});

  @override
  State<CustomWindowImage> createState() => _CustomWindowImageState();
}

class _CustomWindowImageState extends State<CustomWindowImage> {
  CustomInfoWindowController _customInfoWindowController =
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
  void addmarker(String image, String title, String description) {
    marker.add(
      Marker(
        markerId: MarkerId("1"),
        position: _location,
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(image, fit: BoxFit.cover),

                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _customInfoWindowController.dispose();
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
              setState(() {
                addmarker(
                  "assets/images/charsadda_graveyard.jpg",
                  "Charsadda",
                  "The city where i live",
                );
              });
            },
            //if i tap on the google Map the custominfowindow will disappear
            onTap: (_) {
              _customInfoWindowController.hideInfoWindow!();
            },
            //move the widget with the marker
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            markers: marker.toSet(),
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            width: 200,
            height: 200,

            offset: 50,
          ),
        ],
      ),
    );
  }

  //custom widget
}

//dispose() is a lifecycle method in Flutter.
//It is called when your widget is removed from the screen (destroyed).
//tomorrow i will write this for both single custom widow and multiple custom window
