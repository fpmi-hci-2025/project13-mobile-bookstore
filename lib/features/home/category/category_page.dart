import 'package:bookstore/core/mock/mock_data.dart';
import 'package:bookstore/core/models/book.dart';
import 'package:bookstore/features/home/book_detail/presentation/page/book_detail_page.dart';
import 'package:bookstore/features/home/home/presentation/components/book_card.dart';
import 'package:bookstore/shared/constants/app_icons.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectedCategoryIndex = 0;

  final List<String> _categories = const [
    'All',
    'Novels',
    'Self Love',
    'Science',
    'Romantic',
  ];

  final List<Book> _books = mockCategoryBooks;
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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0, 
        scrolledUnderElevation:
            0, 
        leading: IconButton(
          onPressed: () {
          
          },
          icon: SvgPicture.asset(AppIcons.loupe, width: AppSizes.constSize24, height: AppSizes.constSize24),
        ),
        title: Text('Category', style: theme.textTheme.bodyLarge),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: AppSizes.constSize40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding:  EdgeInsets.symmetric(horizontal: AppSizes.sizeW24),
              itemCount: _categories.length,
              separatorBuilder: (_, __) =>  SizedBox(width:  AppSizes.sizeW16),
              itemBuilder: (context, index) {
                final isSelected = _selectedCategoryIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                  },
                  child: Container(
                    padding:  EdgeInsets.symmetric(
                      horizontal:  AppSizes.sizeW20,
                      vertical:  AppSizes.sizeH8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(AppSizes.borderSize20),
                    ),
                    child: Center(
                      child: Text(
                        _categories[index],
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected
                              ? theme.colorScheme.surface
                              : theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
           SizedBox(height: AppSizes.sizeH24),
          Expanded(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal:  AppSizes.sizeW24),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _books.length,
                itemBuilder: (context, index) {
                  final book = _books[index];
                  return GestureDetector(
                    onTap: () => _openBookDetail(book),
                    child: BookCard(book: book, theme: theme),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
