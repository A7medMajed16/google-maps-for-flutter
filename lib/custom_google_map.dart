import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/utils/location_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition _initialCameraPosition;
  late GoogleMapController? _googleMapController;
  late LocationServices locationService;
  // late Location location;
  bool isFirstCall = true;
  String? _style;
  Set<Marker> markers = {};

  @override
  void initState() {
    _initialCameraPosition = const CameraPosition(
      zoom: 16,
      target: LatLng(30.617629214719695, 31.393107059787376),
    );
    locationService = LocationServices();
    // location = Location();
    super.initState();
  }

  // void _initMarkers() {
  //   var myMarkers = places
  //       .map(
  //         (placeModel) => Marker(
  //           infoWindow: InfoWindow(
  //             title: placeModel.name,
  //           ),
  //           position: placeModel.latLng,
  //           markerId: MarkerId(
  //             placeModel.id.toString(),
  //           ),
  //         ),
  //       )
  //       .toSet();
  //   markers.addAll(myMarkers);
  // }

  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      style: _style,
      markers: markers,
      zoomControlsEnabled: false,
      onMapCreated: (controller) async {
        _googleMapController = controller;
        initStyle();
        _updateCurrentLocation();
      },
      initialCameraPosition: _initialCameraPosition,
    );
  }

  void initStyle() async {
    _style = await DefaultAssetBundle.of(context)
        .loadString('assets/maps_styles/dark.json');
  }

  Future<void> _updateCurrentLocation() async {
    Position position = await locationService.getCurrentLocation();
    LatLng positionLatLng = LatLng(position.latitude, position.longitude);
    _googleMapController?.animateCamera(
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
    setState(() {});
  }
}
