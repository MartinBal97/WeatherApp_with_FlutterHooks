import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weatherapp_with_flutterhooks/presentation/controllers/positions_controller.dart';

Future<void> searchLocation(
  BuildContext context,
  WidgetRef ref,
  String city,
  ValueNotifier<double?> lat,
  ValueNotifier<double?> lon, {
  bool isDrawer = false,
}) async {
  if (city.isNotEmpty) {
    try {
      final locations = await ref.read(positionsControllerProvider.notifier).getLatLongFromAddress(city);
      lat.value = locations.latitude;
      lon.value = locations.longitude;

      if (context.mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred while retrieving your location.')),
        );
      }
    }
  }
}
