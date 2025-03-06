import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp_with_flutterhooks/core/constants/sizes.dart';
import 'package:weatherapp_with_flutterhooks/core/theme/app_theme.dart';
import 'package:weatherapp_with_flutterhooks/domain/weather_model.dart';

class SecondaryWeatherInfo extends StatelessWidget {
  final Weather data;

  const SecondaryWeatherInfo({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> weatherDetails = [
      {'label': 'Max Temp', 'value': '${data.main?.tempMax}°C'},
      {'label': 'Min Temp', 'value': '${data.main?.tempMin}°C'},
      {'label': 'Humidity', 'value': '${data.main?.humidity}%'},
      {'label': 'Pressure', 'value': '${data.main?.pressure} hPa'},
      {'label': 'Wind Speed', 'value': '${data.wind?.speed} m/s'},
      {'label': 'Wind Direction', 'value': '${data.wind?.deg}°'},
      {'label': 'Cloudiness', 'value': '${data.clouds?.all}%'},
      {
        'label': 'Sunrise',
        'value': DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(data.sys!.sunrise! * 1000))
      },
      {
        'label': 'Sunset',
        'value': DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(data.sys!.sunset! * 1000))
      },
    ];

    return Center(
      child: Wrap(
        direction: Axis.horizontal,
        children: weatherDetails.map((detail) {
          return Container(
            width: context.widthMq / 3 - 28,
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: context.secondaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  detail['label']!,
                  overflow: TextOverflow.ellipsis,
                  style: context.s12w7,
                ),
                gapH2,
                Divider(color: context.onSecondaryContainer),
                gapH2,
                Text(detail['value']!, style: TextStyle(fontSize: 16)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
