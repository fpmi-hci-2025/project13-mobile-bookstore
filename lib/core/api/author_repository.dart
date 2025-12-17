import 'package:bookstore/core/api/api_client.dart';
import 'package:bookstore/core/models/author.dart';

class AuthorRepository {
  final ApiClient _apiClient;

  AuthorRepository(this._apiClient);

  Future<List<Author>> getAuthors({int page = 1, int pageSize = 20}) async {
    try {
      final response = await _apiClient.getAuthors(page: page, pageSize: pageSize);
      final data = response.data;
      
      if (data == null) return [];
      
      // API returns array directly for authors
      if (data is List) {
        return data.map((json) => Author.fromJson(json)).toList();
      }
      
      return [];
    } catch (e) {
      print('Error fetching authors: $e');
      return [];
    }
  }

  Future<Author?> getAuthor(String id) async {
    try {
      final response = await _apiClient.getAuthor(id);
      return Author.fromJson(response.data);
    } catch (e) {
      print('Error fetching author: $e');
      return null;
    }
  }
}

