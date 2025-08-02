import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleTheme extends StatefulWidget {
  const GoogleTheme({super.key});

  @override
  State<GoogleTheme> createState() => _GoogleThemeState();
}

class _GoogleThemeState extends State<GoogleTheme> {
  //list of google theme
  List<String> google_themes = [
    "assets/jsonfiles/Aubergine_theme.json",
    "assets/jsonfiles/dart_theme.json",
    "assets/jsonfiles/night_theme.json",
    "assets/jsonfiles/retro_theme.json",
    "assets/jsonfiles/silver_theme.json",
  ];
  //set camera postion
  final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(34.1527, 71.7468),
    zoom: 14,
  );
  //googlemap controller
  late GoogleMapController _mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Google Maps"),
        actions: [
          PopupMenuButton(
            onSelected: (index) async {
              //DefaultAssetBundle.of(context):load the file from the assets folder like json file or images
              //loadString : a method that load a text file (like json ) and return string
              String style = await DefaultAssetBundle.of(
                context,
              ).loadString(google_themes[index]);
              _mapController.setMapStyle(style);
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(value: 0, child: Text("Aubergine")),
              PopupMenuItem(value: 1, child: Text("Dark")),
              PopupMenuItem(value: 2, child: Text("Night")),
              PopupMenuItem(value: 3, child: Text("Ruto")),
              PopupMenuItem(value: 4, child: Text("Silver")),
            ],
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
        },
        initialCameraPosition: _cameraPosition,
      ),
    );
  }
}
