import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp_with_flutterhooks/core/constants/sizes.dart';
import 'package:weatherapp_with_flutterhooks/core/services/local_storage_service.dart';
import 'package:weatherapp_with_flutterhooks/core/theme/app_theme.dart';
import 'package:weatherapp_with_flutterhooks/core/utils/functions.dart';
import 'package:weatherapp_with_flutterhooks/data/models/favorite_model.dart';
import 'package:weatherapp_with_flutterhooks/data/models/weather_model.dart';
import 'package:weatherapp_with_flutterhooks/presentation/controllers/favorites_controller.dart';
import 'package:weatherapp_with_flutterhooks/presentation/controllers/positions_controller.dart';
import 'package:weatherapp_with_flutterhooks/presentation/controllers/weather_controller.dart';
import 'package:weatherapp_with_flutterhooks/presentation/widgets/home_widgets/animated_text.dart';
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
    /// Hooks
    final searchController = useTextEditingController();
    final lat = useState<double?>(null);
    final lon = useState<double?>(null);

    /// Controllers
    final AsyncValue<Position> positionController = ref.watch(positionsControllerProvider);
    final AsyncValue<List<Favorite>> favoritesController = ref.watch(favoritesControllerProvider);
    final FavoritesController favoritesControllerNotifier = ref.read(favoritesControllerProvider.notifier);

    Favorite? lastCity;

    /// Update lat & long if position data changes
    useEffect(() {
      Future(() async {
        if (positionController.hasValue && positionController.value != null) {
          lat.value = positionController.value!.latitude;
          lon.value = positionController.value!.longitude;
        } else if (positionController.hasError || positionController.value == null) {
          lastCity = await LocalStorageService.loadLastCity();
          if (lastCity != null) {
            lat.value = lastCity!.lat;
            lon.value = lastCity!.lon;
          }
        }
      });

      return null;
    }, [positionController]);

    /// If lat & long are null and position isn't available, show BottomSheet
    useEffect(() {
      if ((lat.value == null || lon.value == null) && positionController.hasError) {
        Future.microtask(() {
          if (context.mounted) {
            return showLocationInputDialog(context, ref, searchController, lat, lon);
          }
        });
      }
      return null;
    }, [lat.value, lon.value, positionController]);

    /// If lat & long are available, get the weather
    final AsyncValue<Weather> weatherData = (lat.value != null && lon.value != null)
        ? ref.watch(getWeatherProvider(lat: lat.value!, lon: lon.value!))
        : const AsyncValue.loading();

    return Scaffold(
      appBar: AppBar(),
      endDrawer: DrawerHomeScreen(lat: lat, lon: lon),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(getWeatherProvider(lat: lat.value!, lon: lon.value!).future),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            height: context.heightMq - MediaQuery.paddingOf(context).top - 20,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [context.primary, context.background],
                stops: [0.01, 1.0],
              ),
            ),
            child: weatherData.when(
              data: (data) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    spacing: 24,
                    children: [
                      _buildHeader(context, data, favoritesController, favoritesControllerNotifier),
                      _buildWeatherInfo(context, data),
                      SecondaryWeatherInfo(data: data),
                    ],
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
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    Weather data,
    AsyncValue<List<Favorite>> favoritesController,
    FavoritesController favoritesControllerNotifier,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: context.widthMq * 0.79,
          child: AnimatedText(
            text: data.name.toString(),
          ),
        ),
        if (data.name != null && data.coord?.lat != null && data.coord?.lon != null)
          favoritesController.when(
            data: (favs) {
              final isFavorite = favs.any((ele) => ele.name == data.name);

              return IconButton(
                onPressed: () async {
                  favoritesControllerNotifier.toggleFavoriteCity(
                    Favorite(lat: data.coord!.lat!, lon: data.coord!.lon!, name: data.name!),
                    favs,
                  );
                  setState(() {});
                },
                icon: Icon(
                  isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: isFavorite ? Colors.red.shade600 : null,
                ),
              );
            },
            error: (_, __) => const CircularProgressIndicator(),
            loading: () => const CircularProgressIndicator(),
          ),
      ],
    );
  }

  Widget _buildWeatherInfo(
    BuildContext context,
    Weather data,
  ) {
    return Container(
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
              gapH10,
              Text(capitalizeFirstLetter(data.weather![0].description.toString())),
            ],
          ),
          Image.network(
            'https://openweathermap.org/img/wn/${data.weather![0].icon}.png',
            scale: 0.4,
          ),
        ],
      ),
    );
  }
}
