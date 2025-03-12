import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weatherapp_with_flutterhooks/data/repository/positions_repo.dart';

part 'positions_controller.g.dart';

@riverpod
class PositionsController extends _$PositionsController {
  @override
  Future<Position> build() async {
    return await getCurrentCity();
  }

  Future<Position> getCurrentCity() async {
    try {
      return await ref.read(positionsRepositoryProvider).getCurrentCity();
    } catch (e) {
      rethrow;
    }
  }

  Future<Location> getLatLongFromAddress(String address) async {
    try {
      Location locations = await ref.read(positionsRepositoryProvider).getLatLongFromAddress(address);

      return locations;
    } catch (e) {
      rethrow;
    }
  }
}
