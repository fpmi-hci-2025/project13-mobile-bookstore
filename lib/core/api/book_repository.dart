import 'package:bookstore/core/api/api_client.dart';
import 'package:bookstore/core/models/book.dart';

class BookRepository {
  final ApiClient _apiClient;

  BookRepository(this._apiClient);

  Future<List<Book>> getBooks({int page = 1, int pageSize = 20}) async {
    try {
      final response = await _apiClient.getBooks(page: page, pageSize: pageSize);
      final data = response.data;
      
      if (data['books'] == null) return [];
      
      return (data['books'] as List)
          .map((json) => Book.fromJson(json))
          .toList();
    } catch (e) {
      print('Error fetching books: $e');
      return [];
    }
  }

  Future<Book?> getBook(String id) async {
    try {
      final response = await _apiClient.getBook(id);
      return Book.fromJson(response.data);
    } catch (e) {
      print('Error fetching book: $e');
      return null;
    }
  }

  Future<List<Book>> searchBooks(String query, {int page = 1, int pageSize = 20}) async {
    try {
      final response = await _apiClient.searchBooks(query, page: page, pageSize: pageSize);
      final data = response.data;
      
      if (data['books'] == null) return [];
      
      return (data['books'] as List)
          .map((json) => Book.fromJson(json))
          .toList();
    } catch (e) {
      print('Error searching books: $e');
      return [];
    }
  }
}

