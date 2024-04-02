import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/custom_google_map.dart';

class Maps extends StatelessWidget {
  const Maps({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomGoogleMap(),
    );
  }
}
