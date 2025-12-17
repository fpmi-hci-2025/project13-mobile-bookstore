import 'package:bookstore/core/models/cart_item.dart';
import 'package:bookstore/features/home/cart/bloc/baske_bloc.dart';
import 'package:bookstore/features/home/cart/bloc/basket_event.dart';
import 'package:bookstore/features/home/cart/bloc/basket_state.dart';
import 'package:bookstore/shared/components/app_action_sheet.dart';
import 'package:bookstore/shared/constants/app_icons.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/theme/app_colors.dart';
import 'package:bookstore/shared/widgets/app_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: AppSizes.size47H),
        child: Column(
          children: [
            AppHeaderWidget(
              theme: theme,
              text: 'Basket',
              showButton: true,
              buttonWidget: IconButton(
                icon: Icon(Icons.delete, color: theme.colorScheme.secondary),
                onPressed: () {
                  AppActionSheet.actionSheet(
                    context,
                    () {
                      context.read<BasketBloc>().add(ClearBasket());
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    'Empty basket',
                    'Cancel',
                    Icons.auto_delete,
                    Icons.cancel,
                  );
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<BasketBloc, BasketState>(
                builder: (context, state) {
                  if (state is BasketLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is BasketEmpty) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 280),
                        SvgPicture.asset(
                          AppIcons.buyFill,
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Your basket is empty",
                          style: theme.textTheme.headlineLarge?.copyWith(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    );
                  }

                  if (state is BasketLoaded) {
                    final items = state.items;

                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          for (var item in items)
                            CartItemComponent(item: item, theme: theme),
                          const SizedBox(height: 16),
                          const DateSelectionTile(),
                          const SizedBox(height: 16),
                          const PaymentComponent(),
                          const SizedBox(height: 16),
                          // Total
                          Container(
                            padding: const EdgeInsets.all(16),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              "Total: \$${state.total.toStringAsFixed(2)}",
                              style: theme.textTheme.headlineLarge?.copyWith(
                                fontSize: 22,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    );
                  }
                  
                  if (state is BasketError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.error_outline, size: 48, color: Colors.red),
                          const SizedBox(height: 16),
                          Text(state.message),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<BasketBloc>().add(LoadBasket());
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItemComponent extends StatelessWidget {
  const CartItemComponent({super.key, required this.item, required this.theme});

  final CartItem item;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final book = item.book;
    final price = book?.price ?? 0;
    final title = book?.title ?? 'Unknown';
    final imageUrl = book?.imageUrl ?? '';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Book image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 60,
              height: 60,
              child: imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image_not_supported),
                    )
                  : const Icon(Icons.book, size: 40),
            ),
          ),
          const SizedBox(width: 12),

          // Title and quantity controls
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Quantity control
                    Container(
                      width: 110,
                      height: 36,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.read<BasketBloc>().add(
                                DecrementBasket(item.id),
                              );
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[200],
                              ),
                              child: const Icon(
                                Icons.remove,
                                size: 20,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Text(
                            '${item.quantity}',
                            style: theme.textTheme.titleMedium,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<BasketBloc>().add(
                                IncrementBasket(item.id),
                              );
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.colorScheme.primary,
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${(price * item.quantity).toStringAsFixed(2)}",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentComponent extends StatelessWidget {
  const PaymentComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.credit_card,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        title: Text(
          'Choose your payment method',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 17),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: () {
          // Navigate to payment page
        },
      ),
    );
  }
}

class DateSelectionTile extends StatefulWidget {
  const DateSelectionTile({super.key});

  @override
  State<DateSelectionTile> createState() => _DateSelectionTileState();
}

class _DateSelectionTileState extends State<DateSelectionTile> {
  DateTime? _selectedDate;

  String get _displayText {
    if (_selectedDate == null) return 'Select the order pickup date';
    return '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.calendar_today,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        title: Text(
          _displayText,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 17),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: () async {
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: _selectedDate ?? DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
          );

          if (pickedDate != null) {
            setState(() {
              _selectedDate = pickedDate;
            });
          }
        },
      ),
    );
  }
}
