

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:student_tuition_google_map/value_notifier.dart';

class GeoCodingConversion extends StatefulWidget {
  const GeoCodingConversion({Key? key}) : super(key: key);

  @override
  State<GeoCodingConversion> createState() => _GeoCodingConversionState();
}

class _GeoCodingConversionState extends State<GeoCodingConversion> {

  // String addressString = '';
  AddressConversion addressConversion = AddressConversion();
  @override
  Widget build(BuildContext context) {
    print('build called..');
    return Scaffold(
      appBar: AppBar(
        title: Text('GeoCoding'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ValueListenableBuilder(
            valueListenable: addressConversion.stringNotifier,
            builder: (context, builderNotifier, child) {
              return Text('Address: ${builderNotifier.toString()}');
            }
          ),

          SizedBox(height: 20,),

          ElevatedButton(
            onPressed: () async{
              /// Geocoding
              List<Placemark> placemarks = await placemarkFromCoordinates(34.1612, 71.8453);
              addressConversion.setNotifierValue(placemarks.first.toString());
              // addressString = placemarks.first.toString();
            },
            child: Text('Find Address'),
          ),

          SizedBox(height: 20,),

          ElevatedButton(
            onPressed: () async{
              /// Geocoding
              // List<Placemark> placemarks = await placemarkFromCoordinates(34.1612, 71.8453);
              // addressString = placemarks.first.toString();

              /// Reverse GeoCoding
              List<Location> locations = await locationFromAddress("Grand Trunk Rd, Rahat Abad, Peshawar, Khyber Pakhtunkhwa");
              addressConversion.setNotifierValue(locations.first.latitude.toString() + "  " + locations.first.longitude.toString());

            },
            child: Text('Find Coordinates'),
          ),
        ],
      ),
    );
  }
}