import 'package:bookstore/core/models/favorite_item.dart';
import 'package:bookstore/shared/components/app_box_shadow.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FavoriteListItem extends StatelessWidget {
  final FavoriteItem item;
  final VoidCallback onFavoriteToggle;

  const FavoriteListItem({
    Key? key,
    required this.item,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.borderSize16),
        boxShadow: [AppBoxShadow.boxShadow()],
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: AppSizes.sizeH8, horizontal: AppSizes.sizeW16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.borderSize8),
              child: Image.network(
                item.imageUrl,
                width: AppSizes.sizeW60,
                height:  AppSizes.constSize60,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width:AppSizes.sizeW16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: textTheme.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(item.price, style: textTheme.bodySmall?.copyWith(color: AppColors.secondary)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: onFavoriteToggle,
            ),
          ],
        ),
      ),
    );
  }
}
