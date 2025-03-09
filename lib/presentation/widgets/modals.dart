import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weatherapp_with_flutterhooks/core/constants/sizes.dart';
import 'package:weatherapp_with_flutterhooks/core/theme/app_theme.dart';
import 'package:weatherapp_with_flutterhooks/core/utils/functions.dart';

void showLocationInputDialog(
  BuildContext context,
  WidgetRef ref,
  TextEditingController searchController,
  ValueNotifier<double?> lat,
  ValueNotifier<double?> lon,
) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom, top: 30, left: 24, right: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 30,
          children: [
            Text("We couldn't get your location", style: context.s18w7),
            TextField(
              controller: searchController,
              decoration: const InputDecoration(labelText: 'Enter a city'),
            ),
            ElevatedButton(
              onPressed: () => searchLocation(context, ref, searchController.text, lat, lon),
              child: const Text('Confirm'),
            ),
            gapH16,
          ],
        ),
      );
    },
  );
}
