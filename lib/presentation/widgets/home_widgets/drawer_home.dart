import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weatherapp_with_flutterhooks/core/constants/sizes.dart';
import 'package:weatherapp_with_flutterhooks/core/services/local_storage_service.dart';
import 'package:weatherapp_with_flutterhooks/core/theme/app_theme.dart';
import 'package:weatherapp_with_flutterhooks/core/theme/theme_manager.dart';
import 'package:weatherapp_with_flutterhooks/core/utils/functions.dart';
import 'package:weatherapp_with_flutterhooks/presentation/widgets/modals.dart';

class DrawerHomeScreen extends HookConsumerWidget {
  final ValueNotifier<double?> lat;
  final ValueNotifier<double?> lon;

  const DrawerHomeScreen({
    super.key,
    required this.lat,
    required this.lon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();

    final isDarkModeNotifier = ref.read(darkModeProvider.notifier);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryContainer,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Weather App',
                  style: context.s30w7,
                ),
                gapH24,
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Enter a location',
                    labelStyle: TextStyle(color: context.onSurface),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    fillColor: context.surface,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: context.primary, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: context.onSecondaryContainer, width: 2),
                    ),
                    prefixIcon: Icon(Icons.search, color: context.onSurface),
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  onEditingComplete: () {
                    searchLocation(context, ref, searchController.text, lat, lon, isDrawer: true);
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('See favorites'),
            onTap: () {
              showFavoritesDialog(context, ref, lat, lon);
            },
          ),
          gapH64,
          gapH64,
          gapH64,
          gapH64,
          gapH64,
          SwitchListTile(
            value: ref.watch(darkModeProvider),
            onChanged: (value) async {
              await LocalStorageService.saveIsDarkTheme(value);
              isDarkModeNotifier.changeThemeMode(value);
            },
            title: Text('Dark Theme'),
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
