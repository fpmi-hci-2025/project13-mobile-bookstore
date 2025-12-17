import 'package:bookstore/core/models/author.dart';
import 'package:bookstore/core/models/book.dart';
import 'package:bookstore/core/models/favorite_item.dart';
import 'package:bookstore/core/models/order_item.dart';

final List<Book> mockBooks = [
  Book(
    title: 'The Kite Runner',
    price: 39.99,
    imageUrl:
        'https://images.unsplash.com/photo-1521587760476-6c12a4b040da?auto=format&fit=crop&w=600&q=80',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra dignissim ac ac ac. Nibh et sed ac, eget malesuada.',
    rating: 4.0,
    reviewCount: 1240,
    publisher: 'GooDay',
  ),
  Book(
    title: 'The Art of War',
    price: 24.99,
    imageUrl:
        'https://images.unsplash.com/photo-1521587760476-6c12a4b040da?auto=format&fit=crop&w=600&q=80',
    description:
        'Strategic insights that stood the test of time. Perfect for readers who enjoy tactical thinking.',
    rating: 4.5,
    reviewCount: 980,
    publisher: 'Classic Press',
  ),
  Book(
    title: 'The Subtle Art',
    price: 20.99,
    imageUrl:
        'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?auto=format&fit=crop&w=600&q=80',
    description:
        'A counterintuitive approach to living a good life with wit and honesty.',
    rating: 4.2,
    reviewCount: 860,
    publisher: 'Harper Collins',
  ),
];

final List<Author> mockAuthors = [
  Author(
    name: 'John Freeman',
    role: 'Writer',
    imageUrl:
        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=400&q=80',
    biography:
        'John Freeman is an accomplished writer known for his insightful works on literature and culture.',
    rating: 4.5,
    books: [
      Book(
        title: 'The Art of Writing',
        price: 24.99,
        imageUrl:
            'https://images.unsplash.com/photo-1544939630-927d24b0cb3d?auto=format&fit=crop&w=600&q=80',
        description: 'A comprehensive guide to the craft of writing.',
        rating: 4.5,
        reviewCount: 980,
        publisher: 'Classic Press',
      ),
    ],
  ),
  Author(
    name: 'Tess Gunty',
    role: 'Novelist',
    imageUrl:
        'https://images.unsplash.com/photo-1504593811423-6dd665756598?auto=format&fit=crop&w=400&q=80',
    biography:
        'Gunty was born and raised in South Bend, Indiana. She graduated from the University of Notre Dame with a Bachelor of Arts in English and from New York University.',
    rating: 4.0,
    books: [
      Book(
        title: 'The Da Vinci Code',
        price: 19.99,
        imageUrl:
            'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=600&q=80',
        description:
            'A gripping mystery thriller that combines art, history, and religion in an unforgettable adventure.',
        rating: 4.3,
        reviewCount: 1520,
        publisher: 'Doubleday',
      ),
      Book(
        title: 'Carrie Fisher',
        price: 27.12,
        imageUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=600&q=80',
        description:
            'A candid memoir from the beloved actress and writer, sharing her life experiences with humor and honesty.',
        rating: 4.5,
        reviewCount: 890,
        publisher: 'Simon & Schuster',
      ),
      Book(
        title: 'The Good Sister',
        price: 27.12,
        imageUrl:
            'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?auto=format&fit=crop&w=600&q=80',
        description:
            'A psychological thriller about the complex bond between sisters and the secrets that bind them.',
        rating: 4.2,
        reviewCount: 1100,
        publisher: 'Ballantine Books',
      ),
      Book(
        title: 'The Waiting',
        price: 27.12,
        imageUrl:
            'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80',
        description:
            'A poignant story of love, loss, and the power of hope in the face of uncertainty.',
        rating: 4.0,
        reviewCount: 750,
        publisher: 'HarperCollins',
      ),
    ],
  ),
  Author(
    name: 'Richard Perry',
    role: 'Writer',
    imageUrl:
        'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?auto=format&fit=crop&w=400&q=80',
    biography:
        'Richard Perry is a distinguished writer known for his compelling narratives and deep character development.',
    rating: 4.3,
    books: [
      Book(
        title: 'The Subtle Art',
        price: 20.99,
        imageUrl:
            'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?auto=format&fit=crop&w=600&q=80',
        description:
            'A counterintuitive approach to living a good life with wit and honesty.',
        rating: 4.2,
        reviewCount: 860,
        publisher: 'Harper Collins',
      ),
    ],
  ),
];


  final List<Book> mockCategoryBooks = const [
    Book(
      title: 'The Da Vinci Code',
      price: 19.99,
      imageUrl:
          'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=600&q=80',
      description:
          'A gripping mystery thriller that combines art, history, and religion in an unforgettable adventure.',
      rating: 4.3,
      reviewCount: 1520,
      publisher: 'Doubleday',
    ),
    Book(
      title: 'Carrie Fisher',
      price: 27.12,
      imageUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=600&q=80',
      description:
          'A candid memoir from the beloved actress and writer, sharing her life experiences with humor and honesty.',
      rating: 4.5,
      reviewCount: 890,
      publisher: 'Simon & Schuster',
    ),
    Book(
      title: 'The Good Sister',
      price: 27.12,
      imageUrl:
          'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?auto=format&fit=crop&w=600&q=80',
      description:
          'A psychological thriller about the complex bond between sisters and the secrets that bind them.',
      rating: 4.2,
      reviewCount: 1100,
      publisher: 'Ballantine Books',
    ),
    Book(
      title: 'The Waiting',
      price: 27.12,
      imageUrl:
          'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80',
      description:
          'A poignant story of love, loss, and the power of hope in the face of uncertainty.',
      rating: 4.0,
      reviewCount: 750,
      publisher: 'HarperCollins',
    ),
    Book(
      title: 'Where Are You',
      price: 24.99,
      imageUrl:
          'https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=600&q=80',
      description:
          'An emotional journey of self-discovery and finding your place in the world.',
      rating: 4.1,
      reviewCount: 680,
      publisher: 'Penguin Random House',
    ),
    Book(
      title: 'A Novel',
      price: 22.99,
      imageUrl:
          'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?auto=format&fit=crop&w=600&q=80',
      description:
          'A compelling narrative that explores the depths of human emotion and connection.',
      rating: 4.4,
      reviewCount: 920,
      publisher: 'Random House',
    ),
  ];

 List<FavoriteItem> mockFavorite = [
    FavoriteItem(
      title: 'In in amet ultrices sit.',
      price: '\$19.99',
      imageUrl: 'https://picsum.photos/seed/album1/60/60',
    ),
    FavoriteItem(
      title: 'Bibendum facilisis.',
      price: '\$27.12',
      imageUrl: 'https://picsum.photos/seed/album2/60/60',
    ),
    FavoriteItem(
      title: 'Nulla et diam cras.',
      price: '\$13.52',
      imageUrl: 'https://picsum.photos/seed/album3/60/60',
    ),
    FavoriteItem(
      title: 'Risus malesuada in.',
      price: '\$31.00',
      imageUrl: 'https://picsum.photos/seed/album4/60/60',
    ),
  ];

 final List<OrderItem> mockOrder = [
    OrderItem(
      title: 'The Da vinci Code',
      imageUrl: 'https://picsum.photos/seed/order1/60/60',
      status: OrderStatus.delivered,
      itemCount: 1,
    ),
    OrderItem(
      title: 'Carrie Fisher',
      imageUrl: 'https://picsum.photos/seed/order2/60/60',
      status: OrderStatus.delivered,
      itemCount: 5,
    ),
    OrderItem(
      title: 'The Waiting',
      imageUrl: 'https://picsum.photos/seed/order3/60/60',
      status: OrderStatus.cancelled,
      itemCount: 2,
    ),
  ];