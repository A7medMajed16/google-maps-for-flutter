import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/core/utils/location_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  GoogleMapController? googleMapController;
  bool isFirstCall = true;
  Set<Marker> markers = {};
  LocationServices locationService = LocationServices();
  String? style;
  LocationCubit() : super(LocationInitial());

  CameraPosition setInitialCameraPosition() {
    return const CameraPosition(
      zoom: 0,
      target: LatLng(0, 0),
    );
  }

  void onMapCreate(GoogleMapController controller, BuildContext context) async {
    emit(LocationLoading());
    googleMapController = controller;
    style = await DefaultAssetBundle.of(context)
        .loadString('assets/maps_styles/dark.json');
    await updateCurrentLocation();
    emit(LocationSuccess());
  }

  Future<void> updateCurrentLocation() async {
    try {
      Position position = await locationService.getCurrentLocation();
      LatLng positionLatLng = LatLng(position.latitude, position.longitude);
      googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: positionLatLng,
            zoom: 16,
          ),
        ),
      );
      markers.add(
        Marker(
          markerId: const MarkerId('current position'),
          position: positionLatLng,
        ),
      );
    } on LocationServiceException catch (e) {
    } on LocationPermissionException catch (e) {
    } catch (e) {}
  }
}
