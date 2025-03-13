import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weatherapp_with_flutterhooks/core/services/local_storage_service.dart';
import 'package:weatherapp_with_flutterhooks/data/models/favorite_model.dart';

part 'favorites_repo.g.dart';

class FavoritesRepository {
  Future<List<Favorite>> getFavorites() async {
    return await LocalStorageService.loadFavorites();
  }

  Future<void> toggleFavorite(Favorite city, List<Favorite> currentFavorites) async {
    final List<Favorite> newFavorites = List.from(currentFavorites);

    if (newFavorites.any((fav) => fav.name == city.name)) {
      newFavorites.removeWhere((fav) => fav.name == city.name);
    } else {
      newFavorites.add(city);
    }

    await LocalStorageService.saveFavorites(newFavorites);
  }
}

@riverpod
FavoritesRepository favoritesRepository(_) => FavoritesRepository();
