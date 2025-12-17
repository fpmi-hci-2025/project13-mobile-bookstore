import 'package:bookstore/core/models/book.dart';

class BasketModel {
  final Book book;
  final int quantity;
  final DateTime date;

  BasketModel({required this.book, required this.quantity, required this.date});

  BasketModel copyWith({Book? book, int? quantity, DateTime? date}) {
    return BasketModel(
      book: book ?? this.book,
      quantity: quantity ?? this.quantity,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'book': book.toJson(),
      'quantity': quantity,
      'date': date.toIso8601String(),
    };
  }

  factory BasketModel.fromJson(Map<String, dynamic> json) {
    return BasketModel(
      book: Book.fromJson(json['book']),
      quantity: json['quantity'],
      date: DateTime.parse(json['date']),
    );
  }
}
