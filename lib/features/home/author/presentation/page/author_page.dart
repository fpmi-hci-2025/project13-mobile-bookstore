import 'package:bookstore/core/api/author_repository.dart';
import 'package:bookstore/core/di/di_container.dart';
import 'package:bookstore/core/models/author.dart';
import 'package:bookstore/core/models/book.dart';
import 'package:bookstore/features/home/author/presentation/widget/author_about.dart';
import 'package:bookstore/features/home/author/presentation/widget/author_header.dart';
import 'package:bookstore/features/home/author/presentation/widget/author_products.dart';
import 'package:bookstore/features/home/book_detail/presentation/page/book_detail_page.dart';
import 'package:bookstore/features/home/cart/bloc/baske_bloc.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorPage extends StatefulWidget {
  const AuthorPage({super.key, required this.author});

  final Author author;

  @override
  State<AuthorPage> createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
  final AuthorRepository _authorRepository = locator<AuthorRepository>();
  
  late Author _author;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _author = widget.author;
    _loadAuthorDetails();
  }

  Future<void> _loadAuthorDetails() async {
    if (widget.author.id == null) {
      setState(() => _isLoading = false);
      return;
    }

    final author = await _authorRepository.getAuthor(widget.author.id!);
    
    if (mounted) {
      setState(() {
        if (author != null) {
          _author = author;
        }
        _isLoading = false;
      });
    }
  }

  void _openBookDetail(BuildContext context, Book book) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<BasketBloc>(),
        child: BookDetailPage(book: book),
      ),
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
      body: RefreshIndicator(
        onRefresh: _loadAuthorDetails,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.sizeW24,
              vertical: AppSizes.sizeH16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthorHeader(author: _author, theme: theme),
                SizedBox(height: AppSizes.sizeH32),
                AuthorAbout(author: _author, theme: theme),
                SizedBox(height: AppSizes.sizeH32),
                if (_isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (_author.books.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Center(
                      child: Text(
                        'No books available',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                  )
                else
                  AuthorProducts(
                    author: _author,
                    theme: theme,
                    onBookTap: (book) => _openBookDetail(context, book),
                  ),
                SizedBox(height: AppSizes.sizeH34),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
