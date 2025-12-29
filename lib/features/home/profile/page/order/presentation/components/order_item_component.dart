import 'package:bookstore/core/models/order_item.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class OrderItemComponent extends StatelessWidget {
  final Order order;

  const OrderItemComponent({Key? key, required this.order}) : super(key: key);

  Map<String, dynamic> _getStatusDetails(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    switch (order.status) {
      case OrderStatus.delivered:
        return {
          'text': 'Delivered',
          'color': Colors.green,
          'style': textTheme.bodySmall?.copyWith(color: Colors.green),
        };
      case OrderStatus.cancelled:
        return {
          'text': 'Cancelled',
          'color': Colors.red,
          'style': textTheme.bodySmall?.copyWith(color: Colors.red),
        };
      case OrderStatus.pending:
        return {
          'text': 'Pending',
          'color': Colors.orange,
          'style': textTheme.bodySmall?.copyWith(color: Colors.orange),
        };
      case OrderStatus.processing:
        return {
          'text': 'Processing',
          'color': Colors.blue,
          'style': textTheme.bodySmall?.copyWith(color: Colors.blue),
        };
      case OrderStatus.shipped:
        return {
          'text': 'Shipped',
          'color': Colors.purple,
          'style': textTheme.bodySmall?.copyWith(color: Colors.purple),
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusDetails = _getStatusDetails(context);
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.sizeW8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.borderSize8),
            child: order.imageUrl.isNotEmpty
                ? Image.network(
                    order.imageUrl,
                    width: AppSizes.constSize60,
                    height: AppSizes.constSize60,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: AppSizes.constSize60,
                        height: AppSizes.constSize60,
                        color: Colors.grey[200],
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return _buildPlaceholder();
                    },
                  )
                : _buildPlaceholder(),
          ),
          SizedBox(width: AppSizes.sizeW16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  order.title,
                  style: textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppSizes.constSize4),
                Row(
                  children: [
                    // Status
                    Text(statusDetails['text'], style: statusDetails['style']),
                    // Dot separator
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.constSize4),
                      child: Container(
                        width: AppSizes.constSize4,
                        height: AppSizes.constSize4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: statusDetails['color'],
                        ),
                      ),
                    ),
                    // Items count
                    Text(
                      '${order.itemCount} items',
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.constSize4),
                // Total
                Text(
                  '\$${order.total.toStringAsFixed(2)}',
                  style: textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: AppSizes.constSize60,
      height: AppSizes.constSize60,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(AppSizes.borderSize8),
      ),
      child: const Icon(Icons.shopping_bag_outlined, color: Colors.grey),
    );
  }
}
