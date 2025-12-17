import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  static const String baseUrl = 'https://bookstore-api-m4ix.onrender.com/api/v1';
  
  final Dio _dio;
  final FlutterSecureStorage _storage;
  
  ApiClient(this._storage) : _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
    },
  )) {
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    ));
    
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        if (error.response?.statusCode == 401) {
          // Token expired - handle logout
          _storage.delete(key: 'auth_token');
        }
        return handler.next(error);
      },
    ));
  }
  
  Dio get dio => _dio;
  
  // Auth
  Future<Response> register(String username, String email, String password) async {
    return _dio.post('/auth/register', data: {
      'username': username,
      'email': email,
      'password': password,
    });
  }
  
  Future<Response> login(String email, String password) async {
    return _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
  }
  
  Future<Response> getProfile() async {
    return _dio.get('/me');
  }
  
  // Books
  Future<Response> getBooks({int page = 1, int pageSize = 20}) async {
    return _dio.get('/books', queryParameters: {
      'page': page,
      'page_size': pageSize,
    });
  }
  
  Future<Response> getBook(String id) async {
    return _dio.get('/books/$id');
  }
  
  Future<Response> searchBooks(String query, {int page = 1, int pageSize = 20}) async {
    return _dio.get('/books/search', queryParameters: {
      'q': query,
      'page': page,
      'page_size': pageSize,
    });
  }
  
  // Authors
  Future<Response> getAuthors({int page = 1, int pageSize = 20}) async {
    return _dio.get('/authors', queryParameters: {
      'page': page,
      'page_size': pageSize,
    });
  }
  
  Future<Response> getAuthor(String id) async {
    return _dio.get('/authors/$id');
  }
  
  // Cart
  Future<Response> getCart() async {
    return _dio.get('/cart');
  }
  
  Future<Response> addToCart(String bookId, int quantity) async {
    return _dio.post('/cart', data: {
      'book_id': bookId,
      'quantity': quantity,
    });
  }
  
  Future<Response> updateCartItem(String itemId, int quantity) async {
    return _dio.put('/cart/$itemId', data: {
      'quantity': quantity,
    });
  }
  
  Future<Response> removeFromCart(String itemId) async {
    return _dio.delete('/cart/$itemId');
  }
  
  Future<Response> clearCart() async {
    return _dio.delete('/cart');
  }
  
  // Orders
  Future<Response> getOrders({int page = 1, int pageSize = 20}) async {
    return _dio.get('/orders', queryParameters: {
      'page': page,
      'page_size': pageSize,
    });
  }
  
  Future<Response> createOrder(String deliveryAddress) async {
    return _dio.post('/orders', data: {
      'delivery_address': deliveryAddress,
    });
  }
  
  Future<Response> cancelOrder(String orderId) async {
    return _dio.post('/orders/$orderId/cancel');
  }
  
  // Favorites
  Future<Response> getFavorites() async {
    return _dio.get('/favorites');
  }
  
  Future<Response> addToFavorites(String bookId) async {
    return _dio.post('/favorites', data: {
      'book_id': bookId,
    });
  }
  
  Future<Response> removeFromFavorites(String bookId) async {
    return _dio.delete('/favorites/$bookId');
  }
  
  // Reviews
  Future<Response> getBookReviews(String bookId, {int page = 1, int pageSize = 20}) async {
    return _dio.get('/books/$bookId/reviews', queryParameters: {
      'page': page,
      'page_size': pageSize,
    });
  }
  
  Future<Response> createReview(String bookId, int rating, String comment) async {
    return _dio.post('/reviews', data: {
      'book_id': bookId,
      'rating': rating,
      'comment': comment,
    });
  }
  
  // Token management
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }
  
  Future<String?> getToken() async {
    return _storage.read(key: 'auth_token');
  }
  
  Future<void> clearToken() async {
    await _storage.delete(key: 'auth_token');
  }
  
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}

