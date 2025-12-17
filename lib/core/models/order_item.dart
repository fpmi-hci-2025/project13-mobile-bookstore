enum OrderStatus { delivered, cancelled }

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
}