import 'package:bookstore/core/mock/mock_data.dart';
import 'package:bookstore/core/models/favorite_item.dart';
import 'package:bookstore/features/home/profile/page/favorite/presentation/component/favorite_list_item.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/widgets/app_header_widget.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late List<FavoriteItem> favoriteItems;

  @override
  void initState() {
    super.initState();
    favoriteItems = List.from(mockFavorite); 
  }

  void _removeFavorite(FavoriteItem item) {
    setState(() {
      favoriteItems.remove(item);
    });
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
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.sizeW16),
                itemCount: favoriteItems.length,
                itemBuilder: (context, index) {
                  final item = favoriteItems[index];
                  return FavoriteListItem(
                    item: item,
                    onFavoriteToggle: () => _removeFavorite(item),
                  );
                },
                separatorBuilder: (_, __) => SizedBox(height: AppSizes.sizeH8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
