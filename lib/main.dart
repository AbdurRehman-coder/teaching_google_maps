import 'package:flutter/material.dart';
import 'package:student_tuition_google_map/custom_marker.dart';

import 'address_conversion_geocoding.dart';
import 'home_page_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: CustomMarkers(),
    );
  }
}