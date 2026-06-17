import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../constants/channels.dart';
import '../models/channel.dart';
import '../services/favorites_service.dart';

/// Manages the state for the channel directory:
/// search query, selected category, favorites filter, and favorites set.
class ChannelProvider extends ChangeNotifier {
  final FavoritesService _favoritesService = FavoritesService();

  String _searchQuery = '';
  String _selectedCategory = 'All';
  bool _showFavoritesOnly = false;
  Set<String> _favorites = {};
  bool _isLoading = true;
  List<Channel> _allChannels = [];

  // ── Getters ──────────────────────────────────────────────────

  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  bool get showFavoritesOnly => _showFavoritesOnly;
  Set<String> get favorites => _favorites;
  bool get isLoading => _isLoading;

  /// Returns the filtered list of channels based on current filters.
  List<Channel> get filteredChannels {
    return _allChannels.where((channel) {
      // Category filter
      if (_selectedCategory != 'All' &&
          channel.category != _selectedCategory) {
        return false;
      }

      // Search filter
      if (_searchQuery.isNotEmpty &&
          !channel.name.toLowerCase().contains(_searchQuery.toLowerCase())) {
        return false;
      }

      // Favorites filter
      if (_showFavoritesOnly && !_favorites.contains(channel.name)) {
        return false;
      }

      return true;
    }).toList();
  }

  // ── Initialization ───────────────────────────────────────────

  ChannelProvider() {
    _loadFavoritesAndChannels();
  }

  Future<void> _loadFavoritesAndChannels() async {
    _favorites = await _favoritesService.getFavorites();
    await _loadM3uChannels();
  }

  Future<void> _loadM3uChannels() async {
    List<Channel> loaded = List.from(channels);
    try {
      final m3uContent = await rootBundle.loadString('assets/stream/world_cup_matches.m3u');
      final lines = m3uContent.split('\n');
      String currentName = '';

      for (var i = 0; i < lines.length; i++) {
        final line = lines[i].trim();
        if (line.isEmpty) continue;

        if (line.startsWith('#EXTINF:')) {
          final commaIndex = line.indexOf(',');
          if (commaIndex != -1) {
            currentName = line.substring(commaIndex + 1).trim();
          }
        } else if (!line.startsWith('#')) {
          if (currentName.isNotEmpty && (line.startsWith('http://') || line.startsWith('https://'))) {
            loaded.add(Channel(
              name: currentName,
              type: 'normal',
              url: line,
              imageLink: 'assets/icon/bein_sports.png',
              category: 'World Cup',
            ));
          }
          currentName = '';
        }
      }
    } catch (e) {
      debugPrint('Error loading/parsing M3U: $e');
    }
    _allChannels = loaded;
    _isLoading = false;
    notifyListeners();
  }

  // ── Actions ──────────────────────────────────────────────────

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void toggleFavoritesFilter() {
    _showFavoritesOnly = !_showFavoritesOnly;
    notifyListeners();
  }

  Future<void> toggleFavorite(String channelName) async {
    _favorites = await _favoritesService.toggleFavorite(channelName);
    notifyListeners();
  }

  bool isFavorite(String channelName) {
    return _favorites.contains(channelName);
  }
}
