import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  //* Favorites Cities
  static Future<void> saveFavorites(List<String> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', favorites);
  }

  static Future<List<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites') ?? [];
  }

  // //* Last City
  // static Future<void> saveLastCity(String lastCity) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('lastCity', lastCity);
  // }

  // static Future<String> loadLastCity() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('lastCity') ?? '';
  // }

  // //* App theme
  // static Future<void> saveIsDarkTheme(bool isDarkTheme) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('isDarkTheme', isDarkTheme);
  // }

  // static Future<bool> loadIsDarkTheme() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool('isDarkTheme') ?? false;
  // }
}
