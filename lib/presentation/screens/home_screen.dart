import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp_with_flutterhooks/core/constants/sizes.dart';
import 'package:weatherapp_with_flutterhooks/core/theme/app_theme.dart';
import 'package:weatherapp_with_flutterhooks/data/weather_repo.dart';
import 'package:weatherapp_with_flutterhooks/domain/weather_model.dart';
import 'package:weatherapp_with_flutterhooks/presentation/widgets/home_widgets/drawer_home.dart';
import 'package:weatherapp_with_flutterhooks/presentation/widgets/home_widgets/secondary_info.dart';
import 'package:weatherapp_with_flutterhooks/presentation/widgets/modals.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final lat = useState<double?>(null);
    final lon = useState<double?>(null);

    final AsyncValue<Position> currentLocation = ref.watch(getCurrentCityProvider);

    //* Update lat & long if postion data change
    useEffect(() {
      currentLocation.whenData((location) {
        lat.value = location.latitude;
        lon.value = location.longitude;
      });
      return null;
    }, [currentLocation]);

    //* If lat & long are null, show BottomSheet
    useEffect(() {
      if ((lat.value == null || lon.value == null) && currentLocation.hasError) {
        Future.microtask(() {
          if (context.mounted) {
            return showLocationInputDialog(context, ref, searchController, lat, lon);
          }
        });
      }
      return null;
    }, [lat.value, lon.value, currentLocation]);

    //* If lat & long are available, get the weather
    final AsyncValue<Weather> weatherData = (lat.value != null && lon.value != null)
        ? ref.watch(getWeatherProvider(lat: lat.value!, lon: lon.value!))
        : const AsyncValue.loading();

    return Scaffold(
        appBar: AppBar(),
        endDrawer: DrawerHomeScreen(lat: lat, lon: lon),
        body: SingleChildScrollView(
          child: Container(
            height: context.heightMq,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [context.primary, context.background],
                stops: [0.0, 1.0],
              ),
            ),
            child: weatherData.when(
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
                            SizedBox(
                              width: context.widthMq * 0.79,
                              child: Text(
                                data.name.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: context.s48w7.copyWith(fontSize: 40),
                              ),
                            ),
                            if (data.name != null)
                              IconButton(
                                onPressed: () async {},
                                icon: Icon(Icons.favorite_border_rounded),
                              )
                          ],
                        ),
                        gapH20,
                        Container(
                          decoration: BoxDecoration(
                            color: context.primaryContainer,
                            borderRadius: BorderRadius.circular(8),
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
                        SecondaryWeatherInfo(data: data),
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
            ),
          ),
        ));
  }
}
