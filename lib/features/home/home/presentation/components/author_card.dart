import 'package:bookstore/core/models/author.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class AuthorCard extends StatelessWidget {
  const AuthorCard({required this.author, required this.theme});

  final Author author;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(author.imageUrl),
        ),
      SizedBox(height: AppSizes.sizeH8),
        Text(author.name, style: theme.textTheme.bodyLarge?.copyWith()),
         SizedBox(height: AppSizes.sizeH4),
        Text(
          author.role,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
