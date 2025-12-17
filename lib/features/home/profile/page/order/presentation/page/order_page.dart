import 'package:bookstore/core/mock/mock_data.dart';
import 'package:bookstore/core/models/order_item.dart';
import 'package:bookstore/features/home/profile/page/order/presentation/widget/order_content_widget.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/widgets/app_header_widget.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  OrderPage({Key? key}) : super(key: key);

  final List<OrderItem> orderItems = mockOrder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: AppSizes.size47H),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHeaderWidget(theme: theme, text: 'Order History'),
            OrderContentWidget(orderItems: orderItems, theme: theme),
          ],
        ),
      ),
    );
  }
}
