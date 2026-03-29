import 'package:flutter/foundation.dart';
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

  // ── Getters ──────────────────────────────────────────────────

  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  bool get showFavoritesOnly => _showFavoritesOnly;
  Set<String> get favorites => _favorites;
  bool get isLoading => _isLoading;

  /// Returns the filtered list of channels based on current filters.
  List<Channel> get filteredChannels {
    return channels.where((channel) {
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
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    _favorites = await _favoritesService.getFavorites();
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
