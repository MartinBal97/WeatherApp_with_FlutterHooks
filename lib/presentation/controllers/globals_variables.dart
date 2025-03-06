import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'globals_variables.g.dart';

@Riverpod(keepAlive: true)
class GlobalsVariables extends _$GlobalsVariables {
  @override
  build() {
    return CurrentLocation();
  }

  updateGlobals({double? lat, double? lon, String? city}) {
    state = CurrentLocation(
      lat: lat,
      lon: lon,
      city: city,
    );
  }
}

class CurrentLocation {
  final double? lat;
  final double? lon;
  final String? city;

  CurrentLocation({this.lat, this.lon, this.city});
}
