import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_with_google_maps/features/google_maps/presentation/manager/cubit/location_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatelessWidget {
  const CustomGoogleMap({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return GoogleMap(
          style: BlocProvider.of<LocationCubit>(context).style,
          markers: BlocProvider.of<LocationCubit>(context).markers,
          zoomControlsEnabled: false,
          onMapCreated: (controller) {
            BlocProvider.of<LocationCubit>(context)
                .onMapCreate(controller, context);
          },
          initialCameraPosition: BlocProvider.of<LocationCubit>(context)
              .setInitialCameraPosition(),
        );
      },
    );
  }
}
