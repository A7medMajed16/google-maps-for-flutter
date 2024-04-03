import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel({
    required this.id,
    required this.name,
    required this.latLng,
  });
}

List<PlaceModel> places = [
  PlaceModel(
    id: 1,
    name: 'المسجد الشرقى',
    latLng: const LatLng(30.617409221853652, 31.392111076580452),
  ),
  PlaceModel(
    id: 2,
    name: 'المسجد الغربى',
    latLng: const LatLng(30.617490831664952, 31.390908626996804),
  ),
  PlaceModel(
    id: 3,
    name: 'المسجد ابو جاب الله',
    latLng: const LatLng(30.61648539399126, 31.39256626254383),
  ),
];
