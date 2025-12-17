import 'package:bookstore/core/models/book.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard({required this.book, required this.theme});

  final Book book;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.constSize150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderSize20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.10),
            offset: const Offset(0, 4),
            blurRadius: 24,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding:  EdgeInsets.all(AppSizes.constSize12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.borderSize16),
              child: Image.network(
                book.imageUrl,
                fit: BoxFit.cover,
                height: AppSizes.constSize150,
                width: double.infinity,
                errorBuilder: (_, __, ___) =>
                    Container(color: Colors.grey.shade200),
              ),
       
            ),
            SizedBox(height: AppSizes.sizeH12),
            Text(book.title, style: theme.textTheme.bodyMedium),
          SizedBox(height: AppSizes.sizeH4),
            Text(
              '\$${book.price.toStringAsFixed(2)}',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
