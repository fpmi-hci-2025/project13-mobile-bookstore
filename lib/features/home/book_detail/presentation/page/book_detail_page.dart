import 'package:bookstore/core/config/app_routes.dart';
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

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

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
            BookDetailHeader(theme: theme),

            Expanded(
              child: BlocBuilder<BasketBloc, BasketState>(
                builder: (context, state) {
                  int quantity = 0;

                  if (state is BasketLoaded &&
                      state.items.containsKey(book.title)) {
                    quantity = state.items[book.title]!.quantity;
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        BookDetailContent(book: book, theme: theme),

                        BookDetailFooter(
                          theme: theme,
                          book: book,
                          quantity: quantity,

                          
                          onIncrement: () {
                            context.read<BasketBloc>().add(AddToBasket(book));
                          },

                          onDecrement: () {
                            context.read<BasketBloc>().add(
                              DecrementBasket(book.title),
                            );
                          },

                         
                          onAddToCart: () {
                            Navigator.pushNamed(context, AppRoutes.cart);
                          },

                        
                          onBuy: () {
                            context.read<BasketBloc>().add(AddToBasket(book));
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
