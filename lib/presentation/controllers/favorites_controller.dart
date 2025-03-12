import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weatherapp_with_flutterhooks/data/repository/favorites_repo.dart';

part 'favorites_controller.g.dart';

@riverpod
class FavoritesController extends _$FavoritesController {
  @override
  Future<List<String>> build() async {
    return await getFavorites();
  }

  Future<List<String>> getFavorites() async {
    try {
      final favorites = await ref.read(favoritesRepositoryProvider).getFavorites();
      return favorites;
    } catch (e) {
      return Future.error(Exception('$e'));
    }
  }

  Future<void> toggleFavoriteCity(String city, List<String> currentFavorites) async {
    try {
      await ref.read(favoritesRepositoryProvider).toggleFavorite(city, currentFavorites);
    } catch (e) {
      rethrow;
    }
  }
}
