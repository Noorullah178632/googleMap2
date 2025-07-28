import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Custom_InfoWindow extends StatefulWidget {
  const Custom_InfoWindow({super.key});

  @override
  State<Custom_InfoWindow> createState() => _CustomInfoWindowState();
}

class _CustomInfoWindowState extends State<Custom_InfoWindow> {
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  GoogleMapController? googleMapController;
  //make a list of class Window
  List<Window> infoList = [
    Window(
      ImagePath: "assets/images/charsadda_graveyard.jpg",
      title: "Graveyard",
      description: "Famous graveyard in charsadda",
      location: LatLng(34.1435, 71.7474), //charsadda graveyard
    ),
    Window(
      ImagePath: "assets/images/charsadda.jpg",
      title: "Charsadda",
      description: "The place where i live",
      location: LatLng(34.1527, 71.7468), //charsadda
    ),
    Window(
      ImagePath: "assets/images/marchaky_kaly.jpg",
      title: "Marchaky Kaly",
      description: "Beautiful Place in charsadda",
      location: LatLng(34.1765, 71.7430), //marchaky kaly
    ),
    Window(
      ImagePath: "assets/images/nobahar_kalony.jpg",
      title: "Nobahar Kaly",
      description: "Village in charsadda",
      location: LatLng(34.1490, 71.7565), //Nobahar colony
    ),
    Window(
      ImagePath: "assets/images/charsadda_bazar.jpg",
      title: "Charsadda Bazar",
      description: "Old bazar in charsadda ",

      location: LatLng(34.1490, 71.7285), //charsadda zor bazar
    ),
  ];

  List<Marker> _markers = [];
  //list for the latitude and longtitude

  //function for adding the markers

  void addmarker() {
    for (int i = 0; i < infoList.length; i++) {
      final item = infoList[i];
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: item.location,
          onTap: () {
            customInfoWindowController.addInfoWindow!(
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 200,
                      height: 100,
                      child: Image.asset(item.ImagePath, fit: BoxFit.cover),
                    ),

                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      item.description,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              item.location,
            );
          },
        ),
      );
    }
  }

  //initial position of the googlemap
  static final CameraPosition cameraPosition = CameraPosition(
    target: LatLng(34.1527, 71.7468), //charsadda
    zoom: 14,
  );
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addmarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              googleMapController = controller;
              customInfoWindowController.googleMapController = controller;
              setState(() {
                addmarker();
              });
            },
            initialCameraPosition: cameraPosition,
            markers: _markers.toSet(),
            onTap: (_) {
              customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (_) {
              customInfoWindowController.onCameraMove!();
            },
          ),
          CustomInfoWindow(
            controller: customInfoWindowController,
            width: 200,
            height: 150,
            offset: 20,
          ),
        ],
      ),
    );
  }
}

class Window {
  final String ImagePath;
  final String title;
  final String description;
  final LatLng location;
  Window({
    required this.location,
    required this.ImagePath,
    required this.title,
    required this.description,
  });
}
