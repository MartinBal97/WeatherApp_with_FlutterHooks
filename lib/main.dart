import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weatherapp_with_flutterhooks/core/constants/sizes.dart';
import 'package:weatherapp_with_flutterhooks/core/theme/app_theme.dart';
import 'package:weatherapp_with_flutterhooks/core/theme/theme_manager.dart';
import 'package:weatherapp_with_flutterhooks/data/repositories/weather_repo.dart';
import 'package:weatherapp_with_flutterhooks/presentation/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize dotenv
  await dotenv.load(fileName: ".env");

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(isDarkmode: isDarkMode).getTheme(),
      home: HomeScreen(),
    );
  }
}

class DrawerHomeScreen extends HookConsumerWidget {
  const DrawerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final input = useState('Madrid');

    void onEditingComplete() {
      input.value = searchController.text;
      FocusScope.of(context).unfocus();

      try {
        final AsyncValue<Location> locationAsync = ref.watch(
          getLatLongFromAddressProvider(input.value),
        );
      } catch (e) {
        log('Hubo un error $e');
      }

      log('Buscando: ${input.value}');
    }

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
                  onEditingComplete: onEditingComplete,
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () => Navigator.pop(context),
          ),
          gapH64,
          gapH64,
          gapH64,
          gapH64,
          gapH64,
          ListTile(
            title: Text('Change Theme'),
            onTap: () => ref.read(darkModeProvider.notifier).changeThemeMode(),
          ),
        ],
      ),
    );
  }
}
