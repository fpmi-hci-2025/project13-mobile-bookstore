class Book {
  const Book({
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.rating,
    required this.reviewCount,
    required this.publisher,
  });

  final String title;
  final double price;
  final String imageUrl;
  final String description;
  final double rating;
  final int reviewCount;
  final String publisher;
    Map<String, dynamic> toJson() => {
    'title': title,
    'price': price,
    'imageUrl': imageUrl,
    'description': description,
    'rating': rating,
    'reviewCount': reviewCount,
    'publisher': publisher,
  };

  static Book fromJson(Map<String, dynamic> json) => Book(
    title: json['title'],
    price: json['price'],
    imageUrl: json['imageUrl'],
    description: json['description'],
    rating: json['rating'],
    reviewCount: json['reviewCount'],
    publisher: json['publisher'],
  );
}
