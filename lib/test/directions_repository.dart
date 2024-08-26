import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:frontend/test/directions_model.dart';
import 'package:frontend/test/.env.dart'; // Asegúrate de que este archivo contenga tu API key

class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionsRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': 'AIzaSyCuN0YPOlCMmBQqiNxkYg681PotRLdpWRQ',
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      return Directions.fromMapNullable(response.data);
    }
    return null;
  }
}
