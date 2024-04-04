import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_with_google_maps/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition _initialCameraPosition;
  late GoogleMapController _googleMapController;
  String? _style;
  Set<Marker> markers = {};

  @override
  void initState() {
    _initialCameraPosition = const CameraPosition(
      zoom: 16,
      target: LatLng(30.617629214719695, 31.393107059787376),
    );
    _initMarkers();
    super.initState();
  }

  void _initMarkers() {
    var myMarkers = places
        .map(
          (placeModel) => Marker(
            infoWindow: InfoWindow(
              title: placeModel.name,
            ),
            position: placeModel.latLng,
            markerId: MarkerId(
              placeModel.id.toString(),
            ),
          ),
        )
        .toSet();
    markers.addAll(myMarkers);
  }

  Future<Uint8List> getImageFromRawData(String image, double width) async {
    ByteData imageData = await rootBundle.load(image);
    Codec imageCodec = await instantiateImageCodec(
      imageData.buffer.asUint8List(),
      targetWidth: width.round(),
    );
    FrameInfo imageFrame = await imageCodec.getNextFrame();
    ByteData? imageByteData =
        await imageFrame.image.toByteData(format: ImageByteFormat.png);
    return imageByteData!.buffer.asUint8List();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          style: _style,
          markers: markers,
          zoomControlsEnabled: false,
          onMapCreated: (controller) async {
            _googleMapController = controller;
            _style = await DefaultAssetBundle.of(context)
                .loadString('assets/maps_styles/dark.json');
            setState(() {});
          },
          initialCameraPosition: _initialCameraPosition,
        ),
        Positioned(
          bottom: 15,
          left: 16,
          right: 16,
          child: ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color?>(Colors.grey),
            ),
            onPressed: () {
              _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  const CameraPosition(
                    zoom: 18,
                    target: LatLng(30.58117048262103, 31.500452761380398),
                  ),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Change',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
