import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weatherapp_with_flutterhooks/core/services/local_storage_service.dart';

part 'favorites_repo.g.dart';

class FavoritesRepository {
  Future<List<String>> getFavorites() async {
    return await LocalStorageService.loadFavorites();
  }

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

@riverpod
FavoritesRepository favoritesRepository(_) => FavoritesRepository();
