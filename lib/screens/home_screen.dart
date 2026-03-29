import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_theme.dart';
import '../models/channel.dart';
import '../providers/channel_provider.dart';
import '../widgets/category_chips.dart';
import '../widgets/channel_card.dart';
import '../widgets/search_bar_widget.dart';
import 'player_screen.dart';

/// The main directory screen showing all channels in a filterable grid.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ─────────────────────────────────────────
            _buildHeader(context),
            const SizedBox(height: 16),

            // ── Search Bar ─────────────────────────────────────
            Consumer<ChannelProvider>(
              builder: (context, provider, _) =>
                  SearchBarWidget(onChanged: provider.setSearchQuery),
            ),
            const SizedBox(height: 16),

            // ── Category Chips ─────────────────────────────────
            Consumer<ChannelProvider>(
              builder: (context, provider, _) => CategoryChips(
                selectedCategory: provider.selectedCategory,
                onCategorySelected: provider.setCategory,
              ),
            ),
            const SizedBox(height: 16),

            // ── Channel Grid ───────────────────────────────────
            Expanded(child: _buildChannelGrid()),
          ],
        ),
      ),
    );
  }

  /// App header with title, subtitle, and favorites filter toggle.
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title & subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColors.primary, Color(0xFF60B5FF)],
                  ).createShader(bounds),
                  child: const Text(
                    'Maroc Live',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                const Text(
                  'Made By Abdellah El idrissi',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ],
            ),
          ),

          // Favorites filter toggle
          Consumer<ChannelProvider>(
            builder: (context, provider, _) {
              final isActive = provider.showFavoritesOnly;
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: provider.toggleFavoritesFilter,
                  borderRadius: BorderRadius.circular(12),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.favorite.withValues(alpha: 0.15)
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isActive
                            ? AppColors.favorite.withValues(alpha: 0.4)
                            : AppColors.cardBorder,
                      ),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, anim) =>
                          ScaleTransition(scale: anim, child: child),
                      child: Icon(
                        isActive ? Icons.favorite : Icons.favorite_border,
                        key: ValueKey(isActive),
                        color: isActive
                            ? AppColors.favorite
                            : AppColors.textSecondary,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Responsive channel grid using LayoutBuilder for column count.
  Widget _buildChannelGrid() {
    return Consumer<ChannelProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        final channelList = provider.filteredChannels;

        if (channelList.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.tv_off_rounded,
                  size: 48,
                  color: AppColors.textSecondary.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 12),
                const Text(
                  'No channels found',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            // Responsive column count
            int crossAxisCount;
            if (constraints.maxWidth < 360) {
              crossAxisCount = 1;
            } else if (constraints.maxWidth < 600) {
              crossAxisCount = 2;
            } else if (constraints.maxWidth < 900) {
              crossAxisCount = 3;
            } else {
              crossAxisCount = 4;
            }

            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemCount: channelList.length,
              itemBuilder: (context, index) {
                final channel = channelList[index];
                return ChannelCard(
                  channel: channel,
                  isFavorite: provider.isFavorite(channel.name),
                  onTap: () => _navigateToPlayer(context, channel),
                  onFavoriteToggle: () => provider.toggleFavorite(channel.name),
                );
              },
            );
          },
        );
      },
    );
  }

  void _navigateToPlayer(BuildContext context, Channel channel) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => PlayerScreen(channel: channel)));
  }
}
