import 'package:bookstore/core/api/book_repository.dart';
import 'package:bookstore/core/di/di_container.dart';
import 'package:bookstore/core/models/book.dart';
import 'package:bookstore/features/home/book_detail/presentation/page/book_detail_page.dart';
import 'package:bookstore/features/home/home/presentation/components/book_card.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final BookRepository _bookRepository = getIt<BookRepository>();
  final TextEditingController _searchController = TextEditingController();
  
  int _selectedCategoryIndex = 0;
  List<Book> _allBooks = [];
  List<Book> _filteredBooks = [];
  bool _isLoading = true;
  String _searchQuery = '';

  final List<String> _categories = const [
    'All',
    'Fiction',
    'Mystery',
    'Romance',
    'Sci-Fi',
    'Fantasy',
    'Non-Fiction',
    'Biography',
  ];

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadBooks() async {
    setState(() => _isLoading = true);
    
    try {
      final books = await _bookRepository.getBooks(pageSize: 100);
      setState(() {
        _allBooks = books;
        _filterBooks();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _filterBooks() {
    final category = _categories[_selectedCategoryIndex];
    
    setState(() {
      _filteredBooks = _allBooks.where((book) {
        // Category filter
        final matchesCategory = category == 'All' || 
            (book.genre?.toLowerCase().contains(category.toLowerCase()) ?? false);
        
        // Search filter
        final matchesSearch = _searchQuery.isEmpty ||
            book.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (book.genre?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
            book.publisher.toLowerCase().contains(_searchQuery.toLowerCase());
        
        return matchesCategory && matchesSearch;
      }).toList();
    });
  }

  void _onSearchChanged(String query) {
    _searchQuery = query;
    _filterBooks();
  }

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
    _filterBooks();
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
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text('Category', style: theme.textTheme.bodyLarge),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.sizeW24),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search books...',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                  prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            _searchController.clear();
                            _onSearchChanged('');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ),
          
          SizedBox(height: AppSizes.sizeH16),
          
          // Categories
          SizedBox(
            height: AppSizes.constSize40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: AppSizes.sizeW24),
              itemCount: _categories.length,
              separatorBuilder: (_, __) => SizedBox(width: AppSizes.sizeW12),
              itemBuilder: (context, index) {
                final isSelected = _selectedCategoryIndex == index;
                return GestureDetector(
                  onTap: () => _onCategorySelected(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.sizeW20,
                      vertical: AppSizes.sizeH8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : Colors.white,
                      borderRadius: BorderRadius.circular(AppSizes.borderSize20),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: theme.colorScheme.primary.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        _categories[index],
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                              ? Colors.white
                              : theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          SizedBox(height: AppSizes.sizeH16),
          
          // Results count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.sizeW24),
            child: Row(
              children: [
                Text(
                  '${_filteredBooks.length} books found',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: AppSizes.sizeH8),
          
          // Books grid
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredBooks.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No books found',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Try a different search or category',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _loadBooks,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: AppSizes.sizeW24),
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.65,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: _filteredBooks.length,
                            itemBuilder: (context, index) {
                              final book = _filteredBooks[index];
                              return GestureDetector(
                                onTap: () => _openBookDetail(book),
                                child: BookCard(book: book, theme: theme),
                              );
                            },
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
