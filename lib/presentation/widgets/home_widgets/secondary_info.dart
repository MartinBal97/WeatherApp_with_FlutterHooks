import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp_with_flutterhooks/core/constants/sizes.dart';
import 'package:weatherapp_with_flutterhooks/core/theme/app_theme.dart';
import 'package:weatherapp_with_flutterhooks/data/models/weather_model.dart';

class SecondaryWeatherInfo extends HookWidget {
  final Weather data;

  const SecondaryWeatherInfo({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double useFadeIn() {
      final animationController = useAnimationController(duration: const Duration(seconds: 2));
      useEffect(() {
        animationController.forward();
        return null;
      }, const []);
      useAnimation(animationController);
      return animationController.value;
    }

    final List<Map<String, dynamic>> weatherDetails = [
      {'label': 'Max Temp', 'icon': 'assets/icons/max_temp.svg', 'value': '${data.main?.tempMax}°C'},
      {'label': 'Min Temp', 'icon': 'assets/icons/min_temp.svg', 'value': '${data.main?.tempMin}°C'},
      {'label': 'Humidity', 'icon': 'assets/icons/humidity.svg', 'value': '${data.main?.humidity}%'},
      {'label': 'Pressure', 'icon': 'assets/icons/pressure.svg', 'value': '${data.main?.pressure} hPa'},
      {'label': 'Wind Speed', 'icon': 'assets/icons/wind.svg', 'value': '${data.wind?.speed} m/s'},
      {'label': 'Wind Direction', 'icon': 'assets/icons/wind_direction.svg', 'value': '${data.wind?.deg}°'},
      {'label': 'Cloudiness', 'icon': 'assets/icons/clouds.svg', 'value': '${data.clouds?.all}%'},
      {
        'label': 'Sunrise',
        'icon': 'assets/icons/sunrise.svg',
        'value': DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(data.sys!.sunrise! * 1000))
      },
      {
        'label': 'Sunset',
        'icon': 'assets/icons/sunset.svg',
        'value': DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(data.sys!.sunset! * 1000))
      },
    ];

    return Wrap(
      direction: Axis.horizontal,
      spacing: 5,
      runSpacing: 5,
      children: weatherDetails.map((detail) {
        return Opacity(
          opacity: useFadeIn(),
          child: Container(
            width: context.widthMq / 3 - 28,
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: context.onPrimaryContainer),
              color: context.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  detail['label']!,
                  overflow: TextOverflow.ellipsis,
                  style: context.s12w7.copyWith(color: context.primary),
                ),
                gapH10,
                SvgPicture.asset(
                  detail['icon'],
                  colorFilter: ColorFilter.mode(context.onPrimaryContainer, BlendMode.modulate),
                  height: 30,
                ),
                gapH10,
                Text(detail['value']!, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
