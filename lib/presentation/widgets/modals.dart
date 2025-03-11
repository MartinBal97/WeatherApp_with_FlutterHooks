import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weatherapp_with_flutterhooks/core/constants/sizes.dart';
import 'package:weatherapp_with_flutterhooks/core/theme/app_theme.dart';
import 'package:weatherapp_with_flutterhooks/core/utils/functions.dart';
import 'package:weatherapp_with_flutterhooks/presentation/controllers/favorites_controller.dart';

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

void showFavoritesDialog(
  BuildContext context,
  WidgetRef ref,
  ValueNotifier<double?> lat,
  ValueNotifier<double?> lon,
) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          final favoritesController = ref.watch(favoritesControllerProvider);
          final favoritesControllerNotifier = ref.read(favoritesControllerProvider.notifier);

          return favoritesController.when(
            data: (data) {
              if (data.isEmpty) {
                return Center(child: Text("You don't have favorite cities"));
              }

              return ListView(
                padding: EdgeInsets.all(24),
                children: data.map((fav) {
                  return ListTile(
                    title: Text(fav),
                    onTap: () {
                      searchLocation(context, ref, fav, lat, lon);
                      Navigator.pop(context);
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle_outline_rounded),
                      onPressed: () async {
                        await favoritesControllerNotifier.toggleFavoriteCity(fav, data);
                        Future.wait([
                          ref.refresh(favoritesControllerProvider.future),
                        ]);
                        setState(() {});
                      },
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) {
              log(error.toString());
              return Center(child: Text('We had an error getting the favorite list'));
            },
          );
        },
      );
    },
  );
}
