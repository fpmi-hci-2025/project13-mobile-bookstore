import 'package:bookstore/core/models/book.dart';

class FavoriteItem {
  final String id;
  final String bookId;
  final Book? book;
  final DateTime? createdAt;
  bool isFavorite;

  FavoriteItem({
    required this.id,
    required this.bookId,
    this.book,
    this.createdAt,
    this.isFavorite = true,
  });

  // Getters for backward compatibility
  String get title => book?.title ?? '';
  String get price => '\$${book?.price.toStringAsFixed(2) ?? '0.00'}';
  String get imageUrl => book?.imageUrl ?? '';

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id']?.toString() ?? '',
      bookId: json['book_id']?.toString() ?? '',
      book: json['book'] != null ? Book.fromJson(json['book']) : null,
      createdAt: json['created_at'] != null 
          ? DateTime.tryParse(json['created_at']) 
          : null,
      isFavorite: true,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'book_id': bookId,
  };
}
