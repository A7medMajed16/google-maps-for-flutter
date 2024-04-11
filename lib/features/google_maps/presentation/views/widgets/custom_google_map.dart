import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_with_google_maps/features/google_maps/presentation/manager/location_cubit/location_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatelessWidget {
  const CustomGoogleMap({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return Stack(
          children: [
            GoogleMap(
              style: BlocProvider.of<LocationCubit>(context).style,
              markers: BlocProvider.of<LocationCubit>(context).markers,
              zoomControlsEnabled: false,
              onMapCreated: (controller) {
                BlocProvider.of<LocationCubit>(context)
                    .onMapCreate(controller, context);
              },
              initialCameraPosition: BlocProvider.of<LocationCubit>(context)
                  .setInitialCameraPosition(),
            ),
            const Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: CustomTextField(),
            ),
          ],
        );
      },
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        fillColor: const Color(0xff27292E),
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        hintText: 'Search here....',
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.3),
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: Colors.white.withOpacity(0.3),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(
            Icons.person,
            color: Colors.white.withOpacity(0.5),
            size: 40,
          ),
        ),
      ),
    );
  }
}
