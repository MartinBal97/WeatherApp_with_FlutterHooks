import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weatherapp_with_flutterhooks/data/models/favorite_model.dart';
import 'package:weatherapp_with_flutterhooks/data/repository/favorites_repo.dart';

part 'favorites_controller.g.dart';

@riverpod
class FavoritesController extends _$FavoritesController {
  @override
  Future<List<Favorite>> build() async {
    return await getFavorites();
  }

  Future<List<Favorite>> getFavorites() async {
    try {
      final favorites = await ref.read(favoritesRepositoryProvider).getFavorites();
      return favorites;
    } catch (e) {
      return Future.error(Exception('$e'));
    }
  }

  Future<void> toggleFavoriteCity(Favorite city, List<Favorite> currentFavorites) async {
    try {
      await ref.read(favoritesRepositoryProvider).toggleFavorite(city, currentFavorites);

      state = const AsyncValue.loading();
      final updatedFavorites = await getFavorites();
      state = AsyncValue.data(updatedFavorites);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
