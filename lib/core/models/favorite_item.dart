class FavoriteItem {
  final String title;
  final String price;
  final String imageUrl; // Теперь это URL-адрес
   bool isFavorite;

  FavoriteItem({
    required this.title,
    required this.price,
    required this.imageUrl,
    this.isFavorite = true,
  });
}