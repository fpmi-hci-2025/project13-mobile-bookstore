import 'package:bookstore/core/api/api_client.dart';
import 'package:bookstore/core/models/favorite_item.dart';
import 'package:dio/dio.dart';

class FavoriteRepository {
  final ApiClient _apiClient;

  FavoriteRepository(this._apiClient);

  Future<List<FavoriteItem>> getFavorites() async {
    try {
      final isLoggedIn = await _apiClient.isLoggedIn();
      if (!isLoggedIn) {
        return [];
      }
      
      final response = await _apiClient.getFavorites();
      final data = response.data;
      
      if (data == null) return [];
      
      if (data is List) {
        return data.map((item) => FavoriteItem.fromJson(item)).toList();
      }
      
      if (data['favorites'] != null) {
        return (data['favorites'] as List)
            .map((item) => FavoriteItem.fromJson(item))
            .toList();
      }
      
      return [];
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return [];
      }
      print('Error fetching favorites: $e');
      return [];
    } catch (e) {
      print('Error fetching favorites: $e');
      return [];
    }
  }

  Future<FavoriteItem?> addToFavorites(String bookId) async {
    try {
      final response = await _apiClient.addToFavorites(bookId);
      return FavoriteItem.fromJson(response.data);
    } catch (e) {
      print('Error adding to favorites: $e');
      return null;
    }
  }

  Future<bool> removeFromFavorites(String bookId) async {
    try {
      await _apiClient.removeFromFavorites(bookId);
      return true;
    } catch (e) {
      print('Error removing from favorites: $e');
      return false;
    }
  }

  Future<bool> isFavorite(String bookId) async {
    try {
      final favorites = await getFavorites();
      return favorites.any((item) => item.bookId == bookId);
    } catch (e) {
      return false;
    }
  }
}

