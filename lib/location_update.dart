
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class LocationUpdate extends StatefulWidget {
  const LocationUpdate({Key? key}) : super(key: key);

  @override
  State<LocationUpdate> createState() => _LocationUpdateState();
}

class _LocationUpdateState extends State<LocationUpdate> {
  LocationData? _locationData;
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(34.1682, 71.7504),
    zoom: 12,
  );
  List<Marker> markers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    markers.add(const Marker(
      markerId: const MarkerId('1'),
      position: const LatLng(34.1682, 71.7504),
      infoWindow: InfoWindow(title: 'initial locaiton',),
    ),);

    // getCurrentLocation();
  }

  getCurrentLocation() async{
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }


    setState(() async {
      _locationData = await location.getLocation();
      GoogleMapController newController = await _controller.future;
      newController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(_locationData!.latitude!, _locationData!.longitude!),
            zoom: 12,
        ),
      ));

      markers.add(
        Marker(
        markerId: const MarkerId('2'),
        position:  LatLng(_locationData!.latitude!, _locationData!.longitude!),
        infoWindow: InfoWindow(title: 'current locaiton',),
      ),);
      setState(() {

      });

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        onMapCreated: (GoogleMapController mapController){
          _controller.complete(mapController);
        },
        markers: Set.from(markers),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getCurrentLocation();
        },
        child: const Icon(Icons.local_airport), ),
    );
  }
}