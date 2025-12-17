class Book {
  const Book({
    this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.rating,
    required this.reviewCount,
    required this.publisher,
    this.genre,
    this.stock,
    this.authorId,
  });

  final String? id;
  final String title;
  final double price;
  final String imageUrl;
  final String description;
  final double rating;
  final int reviewCount;
  final String publisher;
  final String? genre;
  final int? stock;
  final String? authorId;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'image_url': imageUrl,
    'description': description,
    'rating': rating,
    'review_count': reviewCount,
    'publisher': publisher,
    'genre': genre,
    'stock': stock,
    'author_id': authorId,
  };

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json['id']?.toString(),
    title: json['title'] ?? '',
    price: (json['price'] ?? 0).toDouble(),
    imageUrl: json['image_url'] ?? json['imageUrl'] ?? '',
    description: json['description'] ?? '',
    rating: (json['rating'] ?? 0).toDouble(),
    reviewCount: json['review_count'] ?? json['reviewCount'] ?? 0,
    publisher: json['publisher'] ?? '',
    genre: json['genre'],
    stock: json['stock'],
    authorId: json['author_id']?.toString(),
  );

  Book copyWith({
    String? id,
    String? title,
    double? price,
    String? imageUrl,
    String? description,
    double? rating,
    int? reviewCount,
    String? publisher,
    String? genre,
    int? stock,
    String? authorId,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      publisher: publisher ?? this.publisher,
      genre: genre ?? this.genre,
      stock: stock ?? this.stock,
      authorId: authorId ?? this.authorId,
    );
  }
}
