import 'package:bookstore/core/models/author.dart';
import 'package:bookstore/core/models/book.dart';
import 'package:bookstore/features/home/author/presentation/widget/author_about.dart';
import 'package:bookstore/features/home/author/presentation/widget/author_header.dart';
import 'package:bookstore/features/home/author/presentation/widget/author_products.dart';
import 'package:bookstore/features/home/book_detail/presentation/page/book_detail_page.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AuthorPage extends StatelessWidget {
  const AuthorPage({super.key, required this.author});

  final Author author;

  void _openBookDetail(BuildContext context, Book book) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BookDetailPage(book: book),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Author',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.sizeW24,
            vertical: AppSizes.sizeH16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthorHeader(author: author, theme: theme),
              SizedBox(height: AppSizes.sizeH32),
              AuthorAbout(author: author, theme: theme),
              SizedBox(height: AppSizes.sizeH32),
              AuthorProducts(
                author: author,
                theme: theme,
                onBookTap: (book) => _openBookDetail(context, book),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
