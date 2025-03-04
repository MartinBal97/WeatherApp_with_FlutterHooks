import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geocoding_platform_interface/src/models/location.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
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

    final AsyncValue<Position> getCurrentPosition = ref.watch(getCurrentCityProvider);
    final AsyncValue<Weather> weatherAsync = ref.watch(getWeatherProvider(lat: lat, lon: lon));

    return MaterialApp(
      theme: AppTheme(isDarkmode: isDarkMode).getTheme(),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Welcome to WeatherApp'),
        ),
        endDrawer: DrawerHomeScreen(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              weatherAsync.when(
                data: (data) => Text(data.main!.temp.toString()),
                error: (er, st) => Text(er.toString()),
                loading: () => CircularProgressIndicator(),
              ),
              getCurrentPosition.when(
                data: (data) => Text(data.toString()),
                error: (er, st) => Text(er.toString()),
                loading: () => CircularProgressIndicator(),
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
    final searchController = useTextEditingController();
    final input = useState('Madrid');
    final AsyncValue<Location> locationAsync = ref.watch(getLatLongFromAddressProvider(input.value));

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
                  onChanged: (value) => input.value = value,
                )
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
