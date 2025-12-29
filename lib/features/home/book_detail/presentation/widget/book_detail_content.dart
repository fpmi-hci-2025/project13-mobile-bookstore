import 'package:bookstore/core/models/book.dart';
import 'package:bookstore/shared/components/app_box_shadow.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class BookDetailContent extends StatelessWidget {
  const BookDetailContent({super.key, required this.book, required this.theme});

  final Book book;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all(AppSizes.constSize24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.borderSize32),
        boxShadow: [
          AppBoxShadow.boxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 30,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.borderSize24),
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Image.network(book.imageUrl, fit: BoxFit.cover),
            ),
          ),
            SizedBox(height: AppSizes.sizeH20),
          Text(
            book.title,
            style: theme.textTheme.headlineLarge?.copyWith(fontSize: 26),
          ),
               SizedBox(height: AppSizes.sizeH12),
          Text(
            book.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.secondary,
            ),
          ),
               SizedBox(height: AppSizes.sizeH16),
          Text(
            'Review',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
           SizedBox(height: AppSizes.sizeH8),
          Row(
            children: [
              for (int i = 1; i <= 5; i++)
                Icon(
                  i <= book.rating.round() ? Icons.star : Icons.star_border,
                  color: theme.colorScheme.primary,
                  size: AppSizes.constSize24,
                ),
               SizedBox(width: AppSizes.sizeW8),
              Text(
                '(${book.rating.toStringAsFixed(1)})',
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
