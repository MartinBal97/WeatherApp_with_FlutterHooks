import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp_with_flutterhooks/data/models/favorite_model.dart';

class LocalStorageService {
  //* Favorites Cities
  static Future<void> saveFavorites(List<Favorite> favorites) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> jsonList = favorites.map((fav) => jsonEncode(fav.toJson())).toList();

    await prefs.setStringList('favorites', jsonList);
  }

  static Future<List<Favorite>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String>? jsonList = prefs.getStringList('favorites');

    if (jsonList == null) return [];

    try {
      return jsonList.map((jsonStr) => Favorite.fromJson(jsonDecode(jsonStr))).toList();
    } catch (e) {
      return [];
    }
  }

  //* Last City
  static Future<void> saveLastCity(Favorite lastCity) async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(lastCity.toJson());

    await prefs.setString('lastCity', jsonString);
  }

  static Future<Favorite?> loadLastCity() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('lastCity');

    if (jsonString == null) return null;

    try {
      return Favorite.fromJson(jsonDecode(jsonString));
    } catch (e) {
      return null;
    }
  }

  //* App them
  static Future<void> saveIsDarkTheme(bool isDarkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDarkTheme);
  }

  static Future<bool> loadIsDarkTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkTheme') ?? false;
  }
}
