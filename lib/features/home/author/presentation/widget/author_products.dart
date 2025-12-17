import 'package:bookstore/core/models/author.dart';
import 'package:bookstore/core/models/book.dart';
import 'package:bookstore/features/home/home/presentation/components/book_card.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class AuthorProducts extends StatelessWidget {
  const AuthorProducts({
    super.key,
    required this.author,
    required this.theme,
    required this.onBookTap,
  });

  final Author author;
  final ThemeData theme;
  final void Function(Book) onBookTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Products',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
         SizedBox(height: AppSizes.sizeH16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: author.books.length,
          itemBuilder: (context, index) {
            final book = author.books[index];
            return GestureDetector(
              onTap: () => onBookTap(book),
              child: BookCard(book: book, theme: theme),
            );
          },
        ),
      ],
    );
  }
}
