import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp_with_flutterhooks/core/constants/sizes.dart';
import 'package:weatherapp_with_flutterhooks/core/theme/app_theme.dart';
import 'package:weatherapp_with_flutterhooks/data/models/weather_model.dart';
import 'package:weatherapp_with_flutterhooks/presentation/controllers/favorites_controller.dart';
import 'package:weatherapp_with_flutterhooks/presentation/controllers/positions_controller.dart';
import 'package:weatherapp_with_flutterhooks/presentation/controllers/weather_controller.dart';
import 'package:weatherapp_with_flutterhooks/presentation/widgets/home_widgets/drawer_home.dart';
import 'package:weatherapp_with_flutterhooks/presentation/widgets/home_widgets/secondary_info.dart';
import 'package:weatherapp_with_flutterhooks/presentation/widgets/modals.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final lat = useState<double?>(null);
    final lon = useState<double?>(null);

    final currentLocation = ref.watch(positionsControllerProvider);
    final favoritesController = ref.watch(favoritesControllerProvider);
    final FavoritesController favoritesControllerNotifier = ref.read(favoritesControllerProvider.notifier);

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
        body: RefreshIndicator(
          onRefresh: () => ref.refresh(getWeatherProvider(lat: lat.value!, lon: lon.value!).future),
          child: SingleChildScrollView(
            child: Container(
              height: context.heightMq,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [context.primary, context.background],
                  stops: [0.01, 1.0],
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
                                favoritesController.when(
                                  data: (favs) {
                                    final isFavorite = favs.contains(data.name);

                                    return IconButton(
                                      onPressed: () {
                                        favoritesControllerNotifier.toggleFavoriteCity(data.name!, favs);
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                        color: isFavorite ? Colors.redAccent : null,
                                      ),
                                    );
                                  },
                                  error: (_, __) => const SizedBox(),
                                  loading: () => const CircularProgressIndicator(),
                                ),
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
          ),
        ));
  }
}
