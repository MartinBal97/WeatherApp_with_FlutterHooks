import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weatherapp_with_flutterhooks/data/weather_repo.dart';

Future<void> searchLocation(BuildContext context, WidgetRef ref, TextEditingController searchController,
    ValueNotifier<double?> lat, ValueNotifier<double?> lon,
    {bool isDrawer = false}) async {
  final address = searchController.text;
  if (address.isNotEmpty) {
    try {
      final locations = await ref.read(getLatLongFromAddressProvider(address).future);
      lat.value = locations.latitude;
      lon.value = locations.longitude;

      if (isDrawer) {
        ref.watch(getCurrentCityProvider);
      }

      if (context.mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('There was an error getting your location')),
        );
      }
    }
  }
}
