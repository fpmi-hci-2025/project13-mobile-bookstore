import 'package:bookstore/core/models/order_item.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class OrderItemComponent extends StatelessWidget {
  final OrderItem item;

  const OrderItemComponent({Key? key, required this.item}) : super(key: key);

 
  Map<String, dynamic> _getStatusDetails(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    switch (item.status) {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusDetails = _getStatusDetails(context);
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding:  EdgeInsets.symmetric(vertical: AppSizes.sizeW8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.borderSize8),
            child: Image.network(
              item.imageUrl,
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
                return Container(
                  width: AppSizes.constSize60,
                  height: AppSizes.constSize60,
                  color: Colors.grey[200],
                  child: const Icon(Icons.error_outline, color: Colors.red),
                );
              },
            ),
          ),
      SizedBox(width: AppSizes.sizeW16),

       
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                
                Text(
                  item.title,
                  style: textTheme.bodyMedium, 
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                 SizedBox(height: AppSizes.constSize4,),
                Row(
                  children: [
                    // Статус (Delivered/Cancelled)
                    Text(statusDetails['text'], style: statusDetails['style']),
                    // Точка-разделитель
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.constSize4,
                      ), 
                      child: Container(
                        width: AppSizes.constSize4,
                        height: AppSizes.constSize4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: statusDetails['color'],
                        ),
                      ),
                    ),
                   
                    Text(
                      '${item.itemCount} items',
                      style: textTheme.bodySmall, // Используем bodySmall
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