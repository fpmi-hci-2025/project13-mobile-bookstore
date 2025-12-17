import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class BookDetailHeader extends StatelessWidget {
  const BookDetailHeader({super.key, required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
           SizedBox(height: AppSizes.sizeH8),
        Center(
          child: Container(
            width: AppSizes.sizeW50,
            height: AppSizes.constSize5,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(AppSizes.borderSize4),
            ),
          ),
        ),
            SizedBox(height: AppSizes.sizeH12),
      ],
    );
  }
}
