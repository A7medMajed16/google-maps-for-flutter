import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'google_map_state.dart';

class GoogleMapCubit extends Cubit<GoogleMapState> {
  GoogleMapCubit() : super(GoogleMapInitial());
}
