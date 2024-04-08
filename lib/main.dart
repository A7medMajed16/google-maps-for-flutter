import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_with_google_maps/features/google_maps/presentation/manager/cubit/location_cubit.dart';
import 'package:flutter_with_google_maps/features/google_maps/presentation/views/maps_view.dart';

void main() {
  runApp(const FlutterGoogleMaps());
}

class FlutterGoogleMaps extends StatelessWidget {
  const FlutterGoogleMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocationCubit(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MapView(),
      ),
    );
  }
}
