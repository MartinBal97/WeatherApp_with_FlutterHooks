import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp_with_flutterhooks/core/constants/sizes.dart';
import 'package:weatherapp_with_flutterhooks/core/theme/app_theme.dart';
import 'package:weatherapp_with_flutterhooks/data/repositories/weather_repo.dart';
import 'package:weatherapp_with_flutterhooks/domain/models/weather_model.dart';
import 'package:weatherapp_with_flutterhooks/presentation/common_widgets/drawer_home.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lat = useState<double?>(null);
    final lon = useState<double?>(null);
    final searchController = useTextEditingController();

    final AsyncValue<Position> currentLocation = ref.watch(getCurrentCityProvider);
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
      if ((lat.value == null || lon.value == null) && currentLocation.hasError) {
        Future.microtask(() {
          if (context.mounted) {
            return _showLocationInputDialog(context, ref, searchController, lat, lon);
          }
        });
      }
      return null;
    }, [lat.value, lon.value, currentLocation]);

    // Si lat y lon están disponibles, obtener el clima
    final AsyncValue<Weather> weatherAsync = (lat.value != null && lon.value != null)
        ? ref.watch(getWeatherProvider(lat: lat.value!, lon: lon.value!))
        : const AsyncValue.loading();

    return Scaffold(
        appBar: AppBar(),
        endDrawer: const DrawerHomeScreen(),
        body: weatherAsync.when(
          data: (Weather data) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data.name.toString(), style: context.s48w7.copyWith(fontSize: 40)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.favorite))
                      ],
                    ),
                    gapH20,
                    Container(
                      decoration: BoxDecoration(
                        color: context.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
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
                    gapH24,
                    ScrollableInformation(data: data),
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
                          SnackBar(content: Text('There was an error getting your location')),
                        );
                      }
                    }
                  }
                },
                child: const Text('Confirm'),
              ),
              gapH16,
            ],
          ),
        );
      },
    );
  }
}

class ScrollableInformation extends StatelessWidget {
  final Weather data;
  const ScrollableInformation({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> weatherDetails = [
      {'label': 'Temp Max', 'value': '${data.main?.tempMax}°C'},
      {'label': 'Temp Min', 'value': '${data.main?.tempMin}°C'},
      {'label': 'Humedad', 'value': '${data.main?.humidity}%'},
      {'label': 'Presión', 'value': '${data.main?.pressure} hPa'},
      {'label': 'Viento', 'value': '${data.wind?.speed} m/s'},
      {'label': 'Dirección', 'value': '${data.wind?.deg}°'},
      {'label': 'Nubosidad', 'value': '${data.clouds?.all}%'},
      {
        'label': 'Amanecer',
        'value': DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(data.sys!.sunrise! * 1000))
      },
      {
        'label': 'Atardecer',
        'value': DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(data.sys!.sunset! * 1000))
      },
    ];

    return Center(
      child: Wrap(
        direction: Axis.horizontal,
        children: weatherDetails.map((detail) {
          return Container(
            width: context.widthMq / 3 - 30,
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: context.secondaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(detail['label']!, style: context.s12w7),
                const SizedBox(height: 4),
                Text(detail['value']!, style: TextStyle(fontSize: 16)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
