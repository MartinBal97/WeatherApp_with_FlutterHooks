import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weatherapp_with_flutterhooks/core/services/local_storage_service.dart';
import 'package:weatherapp_with_flutterhooks/data/models/favorite_model.dart';
import 'package:weatherapp_with_flutterhooks/data/models/weather_model.dart';

part 'weather_repo.g.dart';

final dio = Dio();

class WeatherRepo {
  Future<Weather> getWeather(Ref ref, {required double lat, required double lon}) async {
    final apiKey = '${dotenv.env["API_KEY"]}';

    final url = 'https://api.openweathermap.org/data/2.5/weather?&units=metric&lat=$lat&lon=$lon&appid=$apiKey';

    try {
      final Response response = await dio.get(url);

      // log(response.data.toString());

      final weather = Weather.fromJson(response.data);

      if (weather.coord?.lat != null && weather.coord?.lon != null && weather.name != null) {
        await LocalStorageService.saveLastCity(
          Favorite(name: weather.name!, lat: weather.coord!.lat!, lon: weather.coord!.lon!),
        );
      }

      return weather;
    } catch (e) {
      throw Exception('Error getting the weather: $e');
    }
  }
}

@riverpod
WeatherRepo weatherRepository(_) => WeatherRepo();
