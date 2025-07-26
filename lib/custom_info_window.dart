import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Custom_InfoWindow extends StatefulWidget {
  const Custom_InfoWindow({super.key});

  @override
  State<Custom_InfoWindow> createState() => _CustomInfoWindowState();
}

class _CustomInfoWindowState extends State<Custom_InfoWindow> {
  Window? selectedWindow;
  LatLng? selectedLatLng;
  //make a list of class Window
  List<Window> infoList = [
    Window(
      ImagePath: "assets/images/charsadda_graveyard.jpg",
      title: "Graveyard",
      description: "Famous graveyard in charsadda",
    ),
    Window(
      ImagePath: "assets/images/charsadda.jpg",
      title: "Charsadda",
      description: "The place where i live",
    ),
    Window(
      ImagePath: "assets/images/marchaky_kaly.jpg",
      title: "Marchaky Kaly",
      description: "Beautiful Place in charsadda",
    ),
    Window(
      ImagePath: "assets/images/nobahar_kalony.jpg",
      title: "Nobahar Kaly",
      description: "Village in charsadda",
    ),
    Window(
      ImagePath: "assets/images/charsadda_bazar.jpg",
      title: "Charsadda Bazar",
      description: "Old bazar in charsadda ",
    ),
  ];
  List<Marker> _markers = [];
  //list for the latitude and longtitude
  List<LatLng> markerPositions = <LatLng>[
    LatLng(34.1435, 71.7474), //charsadda graveyard
    LatLng(34.1527, 71.7468), //charsadda

    LatLng(34.1765, 71.7430), //marchaky kaly
    LatLng(34.1490, 71.7565), //Nobahar colony
    LatLng(34.1490, 71.7285), //charsadda zor bazar
  ];
  //function for adding the markers

  void _addMarkers() {
    for (int i = 0; i < markerPositions.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId("marker_$i"),
          position: markerPositions[i],
          onTap: () {
            setState(() {
              selectedLatLng = markerPositions[i];
              selectedWindow = infoList[i];
            });
          },
        ),
      );
    }
  }

  //googlemap controller
  late GoogleMapController _googleMapController;
  //initial position of the googlemap
  static final CameraPosition cameraPosition = CameraPosition(
    target: LatLng(34.1435, 71.7474),
    zoom: 14,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _googleMapController = controller;
            },
            initialCameraPosition: cameraPosition,
            markers: _markers.toSet(),
            onTap: (_) {
              setState(() {
                selectedWindow = null;
              });
            },
          ),

          if (selectedWindow != null)
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 75,
              top: MediaQuery.of(context).size.height / 2 - 150,
              child: selectedWindow!,
            ),
        ],
      ),
    );
  }
}

class Window extends StatelessWidget {
  String ImagePath, title, description;
  Window({
    super.key,
    required this.ImagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 150,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Image.asset(ImagePath),
            SizedBox(height: 5),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(description, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
