import 'package:bookstore/core/models/book.dart';

class CartItem {
  final String id;
  final String bookId;
  final int quantity;
  final Book? book;
  final DateTime? createdAt;

  CartItem({
    required this.id,
    required this.bookId,
    required this.quantity,
    this.book,
    this.createdAt,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id']?.toString() ?? '',
      bookId: json['book_id']?.toString() ?? '',
      quantity: json['quantity'] ?? 1,
      book: json['book'] != null ? Book.fromJson(json['book']) : null,
      createdAt: json['created_at'] != null 
          ? DateTime.tryParse(json['created_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'book_id': bookId,
    'quantity': quantity,
  };

  CartItem copyWith({
    String? id,
    String? bookId,
    int? quantity,
    Book? book,
    DateTime? createdAt,
  }) {
    return CartItem(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      quantity: quantity ?? this.quantity,
      book: book ?? this.book,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class Cart {
  final List<CartItem> items;
  final double total;

  Cart({
    required this.items,
    required this.total,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    final itemsList = json['items'] as List? ?? [];
    return Cart(
      items: itemsList.map((item) => CartItem.fromJson(item)).toList(),
      total: (json['total'] ?? 0).toDouble(),
    );
  }

  factory Cart.empty() => Cart(items: [], total: 0);
}

