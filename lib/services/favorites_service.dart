import 'package:shared_preferences/shared_preferences.dart';

/// Manages persisted favorites using SharedPreferences.
///
/// Favorites are stored as a list of channel name strings.
class FavoritesService {
  static const _key = 'favorite_channels';

  /// Returns the set of currently favorited channel names.
  Future<Set<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    return list.toSet();
  }

  /// Adds or removes [channelName] from favorites.
  /// Returns the updated set.
  Future<Set<String>> toggleFavorite(String channelName) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    final favorites = list.toSet();

    if (favorites.contains(channelName)) {
      favorites.remove(channelName);
    } else {
      favorites.add(channelName);
    }

    await prefs.setStringList(_key, favorites.toList());
    return favorites;
  }

  /// Checks whether [channelName] is a favorite.
  Future<bool> isFavorite(String channelName) async {
    final favorites = await getFavorites();
    return favorites.contains(channelName);
  }
}
