import 'package:bookstore/core/mock/mock_data.dart';
import 'package:bookstore/core/models/author.dart';
import 'package:bookstore/core/models/book.dart';
import 'package:bookstore/features/home/author/presentation/page/author_page.dart';
import 'package:bookstore/features/home/book_detail/presentation/page/book_detail_page.dart';
import 'package:bookstore/features/home/home/presentation/components/author_card.dart';
import 'package:bookstore/features/home/home/presentation/components/book_card.dart';
import 'package:bookstore/features/home/home/presentation/components/promo_card.dart';
import 'package:bookstore/features/home/home/presentation/components/section_header.dart';
import 'package:bookstore/shared/components/app_page_indicator.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class HomeContentWidget extends StatefulWidget {
  const HomeContentWidget({super.key});

  @override
  State<HomeContentWidget> createState() => _HomeContentWidgetState();
}

class _HomeContentWidgetState extends State<HomeContentWidget> {
  final List<Book> _books = mockBooks;
  List<Author> get _authors => mockAuthors;

  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _openBookDetail(Book book) {
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppSizes.constSize180,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 3,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: AppSizes.constSize4),
                child: PromoCard(theme: theme),
              );
            },
          ),
        ),
        SizedBox(height: AppSizes.sizeH12),
        Center(
          child: AppPageIndicator(
            currentPage: _currentPage.toDouble(),
            totalPages: 3,
            dotsSize: 6,
            activeDotsColor: theme.colorScheme.secondary,
            dotsColor: theme.colorScheme.secondary.withOpacity(0.3),
          ),
        ),
        SizedBox(height: AppSizes.sizeH24),

        // Books
        SectionHeader(title: 'Books', theme: theme),
        SizedBox(height: AppSizes.sizeH16),
        SizedBox(
          height: AppSizes.constSize240,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _books.length,
            itemBuilder: (_, index) {
              final book = _books[index];
              return GestureDetector(
                onTap: () => _openBookDetail(book),
                child: BookCard(book: book, theme: theme),
              );
            },
            separatorBuilder: (_, __) =>  SizedBox(width: AppSizes.sizeW16),
          ),
        ),
        SizedBox(height: AppSizes.sizeH16),
        SizedBox(
          height: AppSizes.constSize240,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _books.length,
            itemBuilder: (_, index) {
              final book = _books[index];
              return GestureDetector(
                onTap: () => _openBookDetail(book),
                child: BookCard(book: book, theme: theme),
              );
            },
            separatorBuilder: (_, __) => SizedBox(width: AppSizes.sizeW16),
          ),
        ),
          SizedBox(height: AppSizes.sizeH24),

        // Authors
        SectionHeader(title: 'Authors', theme: theme),
        SizedBox(height: AppSizes.sizeH16),
        SizedBox(
          height: AppSizes.constSize140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _authors.length,
            itemBuilder: (_, index) {
              final author = _authors[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AuthorPage(author: author),
                    ),
                  );
                },
                child: AuthorCard(author: author, theme: theme),
              );
            },
            separatorBuilder: (_, __) => SizedBox(width: AppSizes.sizeW24),
          ),
        ),
      ],
    );
  }
}
