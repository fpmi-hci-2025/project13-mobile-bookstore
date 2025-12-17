import 'package:bookstore/core/models/book.dart';

class Author {
  const Author({
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.biography,
    required this.rating,
    required this.books,
  });

  final String name;
  final String role;
  final String imageUrl;
  final String biography;
  final double rating;
  final List<Book> books;
}
