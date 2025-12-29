import 'package:bookstore/core/api/author_repository.dart';
import 'package:bookstore/core/api/book_repository.dart';
import 'package:bookstore/core/di/di_container.dart';
import 'package:bookstore/core/models/author.dart';
import 'package:bookstore/core/models/book.dart';
import 'package:bookstore/features/home/author/presentation/page/author_page.dart';
import 'package:bookstore/features/home/book_detail/presentation/page/book_detail_page.dart';
import 'package:bookstore/features/home/cart/bloc/baske_bloc.dart';
import 'package:bookstore/features/home/home/presentation/components/author_card.dart';
import 'package:bookstore/features/home/home/presentation/components/book_card.dart';
import 'package:bookstore/features/home/home/presentation/components/promo_card.dart';
import 'package:bookstore/features/home/home/presentation/components/section_header.dart';
import 'package:bookstore/shared/components/app_page_indicator.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomeContentWidget extends StatefulWidget {
  const HomeContentWidget({super.key});

  @override
  State<HomeContentWidget> createState() => _HomeContentWidgetState();
}

class _HomeContentWidgetState extends State<HomeContentWidget> {
  final BookRepository _bookRepository = locator<BookRepository>();
  final AuthorRepository _authorRepository = locator<AuthorRepository>();

  List<Book> _books = [];
  List<Author> _authors = [];
  bool _isLoading = true;

  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    
    try {
      final books = await _bookRepository.getBooks();
      final authors = await _authorRepository.getAuthors();
      
      if (mounted) {
        setState(() {
          _books = books;
          _authors = authors;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading data: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _openBookDetail(Book book) {
    final basketBloc = context.read<BasketBloc>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: basketBloc,
        child: BookDetailPage(book: book),
      ),
    );
  }

  Widget _buildShimmerList({required double height, int itemCount = 3}) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (_, __) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: AppSizes.constSize160,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        separatorBuilder: (_, __) => SizedBox(width: AppSizes.sizeW16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: _loadData,
      child: Column(
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
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.constSize4),
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
          
          if (_isLoading)
            _buildShimmerList(height: AppSizes.constSize240)
          else if (_books.isEmpty)
            SizedBox(
              height: AppSizes.constSize240,
              child: Center(
                child: Text(
                  'No books available',
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            )
          else
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
          
          if (_isLoading)
            _buildShimmerList(height: AppSizes.constSize140)
          else if (_authors.isEmpty)
            SizedBox(
              height: AppSizes.constSize140,
              child: Center(
                child: Text(
                  'No authors available',
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            )
          else
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
      ),
    );
  }
}
