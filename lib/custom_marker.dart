

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkers extends StatefulWidget {
  const CustomMarkers({Key? key}) : super(key: key);

  @override
  State<CustomMarkers> createState() => _CustomMarkersState();
}

class _CustomMarkersState extends State<CustomMarkers> {

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(34.1682, 71.7504),
    zoom: 12,
  );

  Uint8List? markerIcon;

  List<Marker> listMarkers = [];
    // Marker(
    //     markerId: MarkerId('1'),
    //     position: LatLng(34.1682, 71.7504),
    //     infoWindow: InfoWindow(
    //         title: 'We are here',
    //         anchor: Offset(0.0, 0.9),
    //         onTap: (){
    //           print('marker clicked...');
    //         })
    // ),


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImage();

  }

  List<String> imagesPath = [
    'images/bicycle.png' , 'images/car.png' , 'images/car1.png',
    'images/car2.png', 'images/delivery-truck.png', 'images/hatchback.png',
    'images/motorcycle.png'
  ];

  List<LatLng> listCoordinates = [
    LatLng(33.7008, 72.9682),LatLng(33.6941, 72.9734),
    LatLng(33.6992, 72.9744), LatLng(33.6939, 72.9771),
    LatLng(33.7036, 72.9785), LatLng(33.7008, 72.9682),
    LatLng(34.0000, 71.4757),
  ];

  loadImage() async{

    for(int i = 0; i < imagesPath.length; i++){
      print('image path: ${imagesPath[i]}');
      markerIcon = await getBytesFromAsset(imagesPath[i], 50);
      listMarkers.add(
        Marker(
            markerId: MarkerId(imagesPath[i]),
             position: listCoordinates[i],
             icon: BitmapDescriptor.fromBytes(markerIcon!),
             infoWindow: InfoWindow(title: 'City $i',),

        ),
      );

    }

  }



  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    print('data \n ${data}');
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    print('Codec \n ${codec}');
    ui.FrameInfo fi = await codec.getNextFrame();
    print('Fi \n ${fi}');
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }


  @override
  Widget build(BuildContext context) {
    print('marker list: ${listMarkers.length}');
    return Scaffold(
      appBar: AppBar(
          title: Text('Markers'),
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        onMapCreated: (GoogleMapController mapController){
          _controller.complete(mapController);
        },
        markers: Set.from(listMarkers),
      ),
    );
  }
}