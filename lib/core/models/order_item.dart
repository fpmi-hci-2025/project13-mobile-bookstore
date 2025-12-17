import 'package:bookstore/core/models/book.dart';

enum OrderStatus { 
  pending, 
  processing, 
  shipped, 
  delivered, 
  cancelled;
  
  static OrderStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return OrderStatus.pending;
      case 'processing':
        return OrderStatus.processing;
      case 'shipped':
        return OrderStatus.shipped;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }
  
  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class OrderItemData {
  final String id;
  final String bookId;
  final int quantity;
  final double price;
  final Book? book;

  OrderItemData({
    required this.id,
    required this.bookId,
    required this.quantity,
    required this.price,
    this.book,
  });

  factory OrderItemData.fromJson(Map<String, dynamic> json) {
    return OrderItemData(
      id: json['id']?.toString() ?? '',
      bookId: json['book_id']?.toString() ?? '',
      quantity: json['quantity'] ?? 1,
      price: (json['price'] ?? 0).toDouble(),
      book: json['book'] != null ? Book.fromJson(json['book']) : null,
    );
  }
}

class Order {
  final String id;
  final String userId;
  final OrderStatus status;
  final double total;
  final String? deliveryAddress;
  final List<OrderItemData> items;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Order({
    required this.id,
    required this.userId,
    required this.status,
    required this.total,
    this.deliveryAddress,
    required this.items,
    this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final itemsList = json['items'] as List? ?? [];
    return Order(
      id: json['id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      status: OrderStatus.fromString(json['status'] ?? 'pending'),
      total: (json['total'] ?? 0).toDouble(),
      deliveryAddress: json['delivery_address'],
      items: itemsList.map((item) => OrderItemData.fromJson(item)).toList(),
      createdAt: json['created_at'] != null 
          ? DateTime.tryParse(json['created_at']) 
          : null,
      updatedAt: json['updated_at'] != null 
          ? DateTime.tryParse(json['updated_at']) 
          : null,
    );
  }

  // For backward compatibility with OrderItem
  String get title {
    if (items.isEmpty) return 'Order #$id';
    if (items.length == 1) return items.first.book?.title ?? 'Order #$id';
    return '${items.first.book?.title ?? 'Order'} +${items.length - 1} more';
  }
  
  String get imageUrl => items.isNotEmpty ? (items.first.book?.imageUrl ?? '') : '';
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
}

// Legacy class for backward compatibility
class OrderItem {
  final String title;
  final String imageUrl;
  final OrderStatus status;
  final int itemCount;

  OrderItem({
    required this.title,
    required this.imageUrl,
    required this.status,
    required this.itemCount,
  });

  factory OrderItem.fromOrder(Order order) {
    return OrderItem(
      title: order.title,
      imageUrl: order.imageUrl,
      status: order.status,
      itemCount: order.itemCount,
    );
  }
}
