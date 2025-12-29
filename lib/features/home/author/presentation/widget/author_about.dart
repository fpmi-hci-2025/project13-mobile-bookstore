import 'package:bookstore/core/models/author.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class AuthorAbout extends StatelessWidget {
  const AuthorAbout({super.key, required this.author, required this.theme});

  final Author author;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
          SizedBox(height: AppSizes.sizeH12),
        Text(
          author.biography,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade700,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}