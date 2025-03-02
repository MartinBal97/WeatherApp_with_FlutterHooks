import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weatherapp_with_flutterhooks/core/constants/sizes.dart';
import 'package:weatherapp_with_flutterhooks/core/theme/app_theme.dart';
import 'package:weatherapp_with_flutterhooks/core/theme/theme_manager.dart';
import 'package:weatherapp_with_flutterhooks/data/repositories/weather_repo.dart';
import 'package:weatherapp_with_flutterhooks/domain/models/weather_model.dart';

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
    const lat = 40.4168;
    const lon = -3.7038; // Madrid, por ejemplo

    final isDarkMode = ref.watch(darkModeProvider);

    final getCurrentPosition = ref.watch(getCurrentCityProvider);

    final AsyncValue<Weather> weatherAsync = ref.watch(getWeatherProvider(lat: lat, lon: lon));

    return MaterialApp(
      theme: AppTheme(isDarkmode: isDarkMode).getTheme(),
      home: Scaffold(
        drawer: DrawerHomeScreen(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              weatherAsync.when(
                data: (data) {
                  return Text(data.main!.temp.toString());
                },
                error: (error, stackTrace) {
                  return Text(error.toString());
                },
                loading: () {
                  return CircularProgressIndicator();
                },
              ),
              getCurrentPosition.when(
                data: (data) {
                  return Text(data.toString());
                },
                error: (error, stackTrace) {
                  return Text(error.toString());
                },
                loading: () {
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerHomeScreen extends HookConsumerWidget {
  const DrawerHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryContainer,
            ),
            child: Text('Hello User!', style: context.s20w6),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          gapH64,
          gapH64,
          gapH64,
          gapH64,
          gapH64,
          ListTile(
            title: Text('Change Theme'),
            onTap: () {
              log('message');
              ref.read(darkModeProvider.notifier).changeThemeMode();
            },
          ),
        ],
      ),
    );
  }
}
