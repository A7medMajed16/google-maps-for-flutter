import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final LatLng latLng;
  final Marker? marker;

  PlaceModel({required this.latLng, this.marker});
}
