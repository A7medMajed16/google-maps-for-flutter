import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_with_google_maps/core/errors/failures.dart';
import 'package:flutter_with_google_maps/features/google_maps/data/models/places_autocomplete_model/places_autocomplete_model.dart';

class GoogleMapsPlacesServices {
  final String _baseUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete';
  final String _apiKey = 'AIzaSyDyngkkq5ANJpLffDAtm5CNEcHf9FFyVJ4';
  final Dio _dio;

  GoogleMapsPlacesServices({required Dio dio}) : _dio = dio;

  Future<Either<Failure, List<PlacesAutocompleteModel>>> getPredictions(
      {required String input}) async {
    try {
      var response = await _dio.get("$_baseUrl/json?input=$input&key=$_apiKey");
      var data = jsonDecode(response.data)['predictions'];
      List<PlacesAutocompleteModel> places = [];
      places.addAll(data);
      return right(places);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
