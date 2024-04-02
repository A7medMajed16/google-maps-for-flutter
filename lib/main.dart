import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/maps.dart';

void main() {
  runApp(const FlutterGoogleMaps());
}

class FlutterGoogleMaps extends StatelessWidget {
  const FlutterGoogleMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Maps(),
    );
  }
}
