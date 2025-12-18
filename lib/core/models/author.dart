import 'package:bookstore/core/models/book.dart';

class Author {
  const Author({
    this.id,
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.biography,
    required this.rating,
    this.books = const [],
  });

  final String? id;
  final String name;
  final String role;
  final String imageUrl;
  final String biography;
  final double rating;
  final List<Book> books;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'role': role,
    'image_url': imageUrl,
    'biography': biography,
    'rating': rating,
    'books': books.map((b) => b.toJson()).toList(),
  };

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json['id']?.toString(),
    name: json['name'] ?? '',
    role: json['role'] ?? 'Writer',
    imageUrl: json['image_url'] ?? json['imageUrl'] ?? '',
    biography: json['biography'] ?? '',
    rating: (json['rating'] ?? 0).toDouble(),
    books: json['books'] != null
        ? (json['books'] as List).map((b) => Book.fromJson(b)).toList()
        : [],
  );

  Author copyWith({
    String? id,
    String? name,
    String? role,
    String? imageUrl,
    String? biography,
    double? rating,
    List<Book>? books,
  }) {
    return Author(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      imageUrl: imageUrl ?? this.imageUrl,
      biography: biography ?? this.biography,
      rating: rating ?? this.rating,
      books: books ?? this.books,
    );
  }
}
