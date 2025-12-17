import 'package:bookstore/core/models/order_item.dart';
import 'package:bookstore/features/home/profile/page/order/presentation/components/order_item_component.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OrderContentWidget extends StatelessWidget {
  const OrderContentWidget({
    super.key,
    required this.orderItems,
    required this.theme,
  });

  final List<OrderItem> orderItems;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: AppSizes.sizeW16,
        left: AppSizes.sizeW16,
        top: AppSizes.sizeH16,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.borderSize16),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.sizeW16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < orderItems.length; i++) ...[
                  OrderItemComponent(item: orderItems[i]),
                  if (i < orderItems.length - 1)
                    Divider(
                      height: AppSizes.sizeH16,
                      thickness: 1,
                      color: theme.colorScheme.onSurface.withOpacity(
                        0.1,
                      ),
                      indent: 75,
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
