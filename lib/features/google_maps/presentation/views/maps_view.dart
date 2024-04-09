import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/features/google_maps/presentation/views/widgets/custom_google_map.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: CustomGoogleMap(),
      ),
    );
  }
}
