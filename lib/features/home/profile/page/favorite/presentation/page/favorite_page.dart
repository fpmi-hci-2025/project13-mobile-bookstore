import 'package:bookstore/core/api/favorite_repository.dart';
import 'package:bookstore/core/di/di_container.dart';
import 'package:bookstore/core/models/favorite_item.dart';
import 'package:bookstore/features/home/profile/page/favorite/presentation/component/favorite_list_item.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/widgets/app_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final FavoriteRepository _favoriteRepository = locator<FavoriteRepository>();
  
  List<FavoriteItem> _favoriteItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() => _isLoading = true);
    
    final favorites = await _favoriteRepository.getFavorites();
    
    if (mounted) {
      setState(() {
        _favoriteItems = favorites;
        _isLoading = false;
      });
    }
  }

  Future<void> _removeFavorite(FavoriteItem item) async {
    // Optimistic update
    setState(() {
      _favoriteItems.remove(item);
    });
    
    // Sync with server
    final success = await _favoriteRepository.removeFromFavorites(item.bookId);
    
    if (!success && mounted) {
      // Revert if failed
      setState(() {
        _favoriteItems.add(item);
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to remove from favorites')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: AppSizes.size47H),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHeaderWidget(theme: theme, text: 'Your favorites'),
            SizedBox(height: AppSizes.sizeH16),
            Expanded(
              child: _isLoading
                  ? _buildShimmerList()
                  : _favoriteItems.isEmpty
                      ? _buildEmptyState(theme)
                      : RefreshIndicator(
                          onRefresh: _loadFavorites,
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: AppSizes.sizeW16),
                            itemCount: _favoriteItems.length,
                            itemBuilder: (context, index) {
                              final item = _favoriteItems[index];
                              return FavoriteListItem(
                                item: item,
                                onFavoriteToggle: () => _removeFavorite(item),
                              );
                            },
                            separatorBuilder: (_, __) => SizedBox(height: AppSizes.sizeH8),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.sizeW16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => SizedBox(height: AppSizes.sizeH8),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: theme.colorScheme.secondary.withOpacity(0.5),
          ),
          SizedBox(height: AppSizes.sizeH16),
          Text(
            'No favorites yet',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.secondary,
            ),
          ),
          SizedBox(height: AppSizes.sizeH8),
          Text(
            'Start adding books to your favorites',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.secondary.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
