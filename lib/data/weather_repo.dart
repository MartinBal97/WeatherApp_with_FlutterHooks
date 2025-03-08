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
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }

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
