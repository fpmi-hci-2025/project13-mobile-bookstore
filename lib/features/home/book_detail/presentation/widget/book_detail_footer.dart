import 'package:bookstore/core/models/book.dart';
import 'package:bookstore/shared/components/app_button.dart';
import 'package:bookstore/shared/constants/app_icons.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BookDetailFooter extends StatelessWidget {
  const BookDetailFooter({
    super.key,
    required this.theme,
    required this.book,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.onAddToCart,
    required this.onBuy,
  });

  final ThemeData theme;
  final Book book;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onAddToCart;
  final VoidCallback onBuy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:  AppSizes.borderSize24),
      child: Row(
        children: [
          quantity == 0
              ? SizedBox(
                  height:  AppSizes.constSize44,
                  child: AppButton(
                    text: '\$${book.price.toStringAsFixed(2)}',
                    onPressed: onBuy,
                    buttonWidth: AppSizes.sizeW107,
                    buttonHeight:  AppSizes.constSize44,
                    borderRadius: AppSizes.borderSize16,
                    isEnabled: true,
                  ),
                )
              : Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: AppSizes.sizeW107,
                        height: AppSizes.constSize44,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: AppSizes.sizeW8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: onDecrement,
                                child: Container(
                                 width: AppSizes.sizeW24,
                                  height: AppSizes.sizeH24,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFE8E8E8),
                                  ),
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(AppIcons.minus),
                                ),
                              ),
                              Text(
                                '$quantity',
                                style: theme.textTheme.titleMedium,
                              ),
                              GestureDetector(
                                onTap: onIncrement,
                                child: Container(
                                  width: AppSizes.sizeW24,
                                  height: AppSizes.sizeH24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: theme.colorScheme.primary,
                                  ),
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(AppIcons.plus),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (quantity > 0)
                        SizedBox(
                          height: AppSizes.constSize44,
                          child: AppButton(
                            text: 'Go to cart',
                            onPressed: onAddToCart,
                            buttonWidth: AppSizes.sizeW120,
                            buttonHeight: AppSizes.constSize44,
                            borderRadius: AppSizes.borderSize16,
                            isEnabled: true,
                          ),
                        ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
