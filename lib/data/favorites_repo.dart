import 'package:weatherapp_with_flutterhooks/services/local_storage_service.dart';

class FavoritesRepository {
  Future<List<String>> getFavorites() => LocalStorageService.loadFavorites();

  Future<void> toggleFavorite(String city, List<String> currentFavorites) async {
    final List<String> newFavorites = currentFavorites;

    if (newFavorites.contains(city)) {
      newFavorites.remove(city);
    } else {
      newFavorites.add(city);
    }

    await LocalStorageService.saveFavorites(newFavorites);
  }
}
