import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weatherapp_with_flutterhooks/data/models/weather_model.dart';
import 'package:weatherapp_with_flutterhooks/data/repository/weather_repo.dart';

part 'weather_controller.g.dart';

@riverpod
Future<Weather> getWeather(Ref ref, {required double lat, required double lon}) async {
  try {
    final weather = ref.read(weatherRepositoryProvider).getWeather(ref, lat: lat, lon: lon);

    return weather;
  } catch (e) {
    rethrow;
  }
}
