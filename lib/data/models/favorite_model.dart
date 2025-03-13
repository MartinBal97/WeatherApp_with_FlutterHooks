import 'dart:convert';

class Favorite {
  final double lat;
  final double lon;
  final String name;

  Favorite({
    required this.lat,
    required this.lon,
    required this.name,
  });

  String toJson() => jsonEncode({
        'lat': lat,
        'lon': lon,
        'name': name,
      });

  factory Favorite.fromJson(String jsonStr) {
    final Map<String, dynamic> data = jsonDecode(jsonStr);
    return Favorite(
      lat: (data['lat'] as num).toDouble(),
      lon: (data['lon'] as num).toDouble(),
      name: data['name'] as String,
    );
  }
}
