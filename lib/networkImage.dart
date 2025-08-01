import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'dart:ui' as ui;

class Networkimage extends StatefulWidget {
  const Networkimage({super.key});

  @override
  State<Networkimage> createState() => _NetworkimageState();
}

class _NetworkimageState extends State<Networkimage> {
  //places
  List<LatLng> places = [
    LatLng(34.1527, 71.7468), // Charsadda
    LatLng(34.1704, 71.7474), // Rajar
    LatLng(34.1435, 71.7474), // Charsadda Graveyar
    LatLng(34.2197, 71.4428), //Utmanzai
    LatLng(34.1490, 71.7285), // old bazar
  ];
  //images of persons
  List<String> images = [
    "https://cdn-icons-png.flaticon.com/512/149/149071.png",
    "https://cdn-icons-png.flaticon.com/512/2922/2922510.png",
    "https://cdn-icons-png.flaticon.com/512/236/236831.png",
    "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
    "https://cdn-icons-png.flaticon.com/512/847/847969.png",
  ];
  //camera postion
  final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(34.1527, 71.7468),
    zoom: 14,
  );
  //googlemap controller
  late GoogleMapController _mapController;
  //make a function to get the network image and convert the image into raw format
  Future<Uint8List> getBytesFromNetworkImage(String link, int width) async {
    final request = Uri.parse(link);
    final response = await http.get(request);
    final codec = await ui.instantiateImageCodec(
      response.bodyBytes,
      targetWidth: width,
    );
    final format = await codec.getNextFrame();
    final data = await format.image.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  //make a marker set
  Set<Marker> _marker = {};
  // method for getting the raw format and then use it as a marker
  Future<void> addNetworkMarker() async {
    for (int i = 0; i < places.length; i++) {
      final Uint8List customImage = await getBytesFromNetworkImage(
        images[i],
        100,
      );
      final marker = Marker(
        markerId: MarkerId(i.toString()),
        position: places[i],

        // ignore: deprecated_member_use
        icon: BitmapDescriptor.fromBytes(customImage),
        infoWindow: InfoWindow(title: "Network image ${i + 1}"),
      );
      setState(() {
        _marker.add(marker);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (controller) async {
          _mapController = controller;
          await addNetworkMarker();
        },
        initialCameraPosition: _cameraPosition,
        markers: _marker,
      ),
    );
  }
}
//1.first we will make a function , with two parameter with "link" and "width".
//2.we will request to the link using "Uri.parse(link)".
//3.after we will get the link in bytes "http.get(request)".
//4.after that we will convert the bytes into an image "ui.instantiateImageCodec(response,width)".
// * ui: it is a library. *instantiateImageCodec:it will decode bytes into image that flutter can read.(and simply we can call it decoded data)
//5.after that we will use frame to get actual iamge from the decoded data (codec) using getNextFrame().
//6.then convert the image into raw byte and set the format as a PNG.
//* .toByteData:raw data of image .* .format: ui.ImageByteFormat.png :set the format to PNG.
//7.and the last get the image and store in a list as a byte format to use as a marker .