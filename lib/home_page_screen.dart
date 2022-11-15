
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(34.1682, 71.7504),
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Home'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,

        initialCameraPosition: initialCameraPosition,
        onMapCreated: (GoogleMapController mapController){
          _controller.complete(mapController);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async{
            GoogleMapController newController = await _controller.future;
            newController.animateCamera(CameraUpdate.newCameraPosition(_kLake));
          },
          label: Icon(Icons.gesture_outlined)),
    );
  }

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
}