import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp_with_flutterhooks/core/constants/sizes.dart';
import 'package:weatherapp_with_flutterhooks/core/theme/app_theme.dart';
import 'package:weatherapp_with_flutterhooks/data/repositories/weather_repo.dart';
import 'package:weatherapp_with_flutterhooks/domain/models/weather_model.dart';
import 'package:weatherapp_with_flutterhooks/main.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lat = useState<double?>(null);
    final lon = useState<double?>(null);
    final searchController = useTextEditingController();

    final currentLocation = ref.watch(getCurrentCityProvider);

    // Hook para actualizar lat y lon cuando se obtenga la posición
    useEffect(() {
      currentLocation.whenData((location) {
        lat.value = location.latitude;
        lon.value = location.longitude;
      });
      return null;
    }, [currentLocation]);

    // Si lat y lon son null, mostrar el BottomSheet
    useEffect(() {
      if (lat.value == null || lon.value == null) {
        Future.microtask(() {
          if (context.mounted) {
            return _showLocationInputDialog(context, ref, searchController, lat, lon);
          }
        });
      }
      return null;
    }, [lat.value, lon.value]);

    // Si lat y lon están disponibles, obtener el clima
    final AsyncValue<Weather> weatherAsync = (lat.value != null && lon.value != null)
        ? ref.watch(getWeatherProvider(lat: lat.value!, lon: lon.value!))
        : const AsyncValue.loading();

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          // title: Text('Welcome to WeatherApp'),
        ),
        endDrawer: DrawerHomeScreen(),
        body: weatherAsync.when(
          data: (Weather data) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.name.toString(), style: context.s48w7),
                    gapH24,
                    Card(
                      borderOnForeground: false,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(DateFormat.yMMMEd().format(DateTime.now())),
                                Text(data.weather![0].main.toString()),
                                gapH10,
                                Text(
                                  '${data.main!.temp!.round()}º C',
                                  style: context.s30w7,
                                ),
                              ],
                            ),
                            Image.network(
                              'https://openweathermap.org/img/wn/${data.weather![0].icon}.png',
                              scale: 0.4,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Text(data.main!.temp.toString()),
                    // Text(data.name.toString()),
                  ],
                ),
              ),
            );
          },
          error: (er, st) => Center(
            child: Text(er.toString()),
          ),
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }

  void _showLocationInputDialog(
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
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
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
                onPressed: () async {
                  final address = searchController.text;
                  if (address.isNotEmpty) {
                    try {
                      final locations = await ref.read(getLatLongFromAddressProvider(address).future);
                      lat.value = locations.latitude;
                      lon.value = locations.longitude;
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error al obtener la ubicación')),
                        );
                      }
                    }
                  }
                },
                child: const Text('Confirmar'),
              ),
              gapH16,
            ],
          ),
        );
      },
    );
  }
}
