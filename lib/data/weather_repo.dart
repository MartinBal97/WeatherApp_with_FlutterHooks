import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weatherapp_with_flutterhooks/domain/weather_model.dart';

part 'weather_repo.g.dart';

final dio = Dio();

@riverpod
Future<Weather> getWeather(Ref ref, {required double lat, required double lon}) async {
  final apiKey = '${dotenv.env["API_KEY"]}';

  final url = 'https://api.openweathermap.org/data/2.5/weather?&units=metric&lat=$lat&lon=$lon&appid=$apiKey';

  try {
    final response = await dio.get(url);
    log(response.data.toString());
    return Weather.fromJson(response.data);
  } catch (e) {
    log(e.toString());
    throw Exception('Error al obtener el clima: $e');
  }
}

@riverpod
Future<Position> getCurrentCity(Ref ref) async {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.

  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

@riverpod
Future<Location> getLatLongFromAddress(Ref ref, String address) async {
  try {
    List<Location> locations = await locationFromAddress(address);

    if (locations.isEmpty) {
      throw Exception("No se encontraron coordenadas para la dirección proporcionada.");
    }

    return locations.first;
  } catch (e) {
    throw Exception("Error al obtener la ubicación. Verifica la dirección ingresada.");
  }
}
