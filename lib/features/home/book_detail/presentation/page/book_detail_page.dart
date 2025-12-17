import 'package:bookstore/core/api/favorite_repository.dart';
import 'package:bookstore/core/config/app_routes.dart';
import 'package:bookstore/core/di/di_container.dart';
import 'package:bookstore/core/models/book.dart';
import 'package:bookstore/features/home/book_detail/presentation/widget/book_detail_content.dart';
import 'package:bookstore/features/home/book_detail/presentation/widget/book_detail_footer.dart';
import 'package:bookstore/features/home/book_detail/presentation/widget/book_detail_header.dart';
import 'package:bookstore/features/home/cart/bloc/baske_bloc.dart';
import 'package:bookstore/features/home/cart/bloc/basket_event.dart';
import 'package:bookstore/features/home/cart/bloc/basket_state.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailPage extends StatefulWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  final FavoriteRepository _favoriteRepository = locator<FavoriteRepository>();
  bool _isFavorite = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    if (widget.book.id != null) {
      final isFavorite = await _favoriteRepository.isFavorite(widget.book.id!);
      if (mounted) {
        setState(() {
          _isFavorite = isFavorite;
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    if (widget.book.id == null) return;

    setState(() {
      _isLoading = true;
    });

    if (_isFavorite) {
      final success = await _favoriteRepository.removeFromFavorites(widget.book.id!);
      if (success && mounted) {
        setState(() {
          _isFavorite = false;
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Removed from favorites'),
            duration: Duration(seconds: 1),
          ),
        );
      } else if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      final result = await _favoriteRepository.addToFavorites(widget.book.id!);
      if (result != null && mounted) {
        setState(() {
          _isFavorite = true;
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Added to favorites'),
            duration: Duration(seconds: 1),
          ),
        );
      } else if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FractionallySizedBox(
      heightFactor: 0.92,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizes.borderSize34),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookDetailHeader(
              theme: theme,
              isFavorite: _isFavorite,
              isLoading: _isLoading,
              onFavoritePressed: _toggleFavorite,
            ),

            Expanded(
              child: BlocBuilder<BasketBloc, BasketState>(
                builder: (context, state) {
                  int quantity = 0;
                  String? cartItemId;

                  if (state is BasketLoaded) {
                    // Find item by book id
                    final item = state.items.where(
                      (item) => item.bookId == widget.book.id || item.book?.title == widget.book.title
                    ).firstOrNull;
                    
                    if (item != null) {
                      quantity = item.quantity;
                      cartItemId = item.id;
                    }
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        BookDetailContent(book: widget.book, theme: theme),

                        BookDetailFooter(
                          theme: theme,
                          book: widget.book,
                          quantity: quantity,

                          onIncrement: () {
                            context.read<BasketBloc>().add(AddToBasket(widget.book));
                          },

                          onDecrement: () {
                            if (cartItemId != null) {
                              context.read<BasketBloc>().add(
                                DecrementBasket(cartItemId),
                              );
                            }
                          },

                          onAddToCart: () {
                            Navigator.pushNamed(context, AppRoutes.cart);
                          },

                          onBuy: () {
                            context.read<BasketBloc>().add(AddToBasket(widget.book));
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
