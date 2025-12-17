import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BookDetailHeader extends StatelessWidget {
  const BookDetailHeader({
    super.key,
    required this.theme,
    required this.isFavorite,
    required this.isLoading,
    required this.onFavoritePressed,
  });

  final ThemeData theme;
  final bool isFavorite;
  final bool isLoading;
  final VoidCallback onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppSizes.sizeH8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.constSize16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Close button
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.close,
                  color: theme.colorScheme.secondary,
                ),
              ),
              // Drag handle
              Container(
                width: AppSizes.sizeW50,
                height: AppSizes.constSize5,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  borderRadius: BorderRadius.circular(AppSizes.borderSize4),
                ),
              ),
              // Favorite button
              IconButton(
                onPressed: isLoading ? null : onFavoritePressed,
                icon: isLoading
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primary,
                        ),
                      )
                    : Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? AppColors.primary : theme.colorScheme.secondary,
                      ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSizes.sizeH4),
      ],
    );
  }
}
