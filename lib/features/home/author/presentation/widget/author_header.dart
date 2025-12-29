import 'package:bookstore/core/models/author.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class AuthorHeader extends StatelessWidget {
  const AuthorHeader({super.key, required this.author, required this.theme});

  final Author author;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(author.imageUrl),
        ),
        SizedBox(height: AppSizes.sizeH12),
        Text(
          author.role,
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
        ),
           SizedBox(height: AppSizes.sizeH8),
        Text(
          author.name,
          style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
          SizedBox(height: AppSizes.sizeH12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 1; i <= 5; i++)
              Icon(
                i <= author.rating.round() ? Icons.star : Icons.star_border,
                color: theme.colorScheme.primary,
                size: 24,
              ),
              SizedBox(height: AppSizes.sizeH8),
            Text(
              '(${author.rating.toStringAsFixed(1)})',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.secondary),
            ),
          ],
        ),
      ],
    );
  }
}