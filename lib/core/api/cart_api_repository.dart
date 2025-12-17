import 'package:bookstore/core/api/api_client.dart';
import 'package:bookstore/core/models/cart_item.dart';
import 'package:dio/dio.dart';

class CartApiRepository {
  final ApiClient _apiClient;

  CartApiRepository(this._apiClient);

  Future<Cart> getCart() async {
    try {
      final isLoggedIn = await _apiClient.isLoggedIn();
      if (!isLoggedIn) {
        return Cart.empty();
      }
      
      final response = await _apiClient.getCart();
      return Cart.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return Cart.empty();
      }
      print('Error fetching cart: $e');
      return Cart.empty();
    } catch (e) {
      print('Error fetching cart: $e');
      return Cart.empty();
    }
  }

  Future<Cart?> addToCart(String bookId, {int quantity = 1}) async {
    try {
      final response = await _apiClient.addToCart(bookId, quantity);
      return Cart.fromJson(response.data);
    } catch (e) {
      print('Error adding to cart: $e');
      return null;
    }
  }

  Future<Cart?> updateCartItem(String itemId, int quantity) async {
    try {
      final response = await _apiClient.updateCartItem(itemId, quantity);
      return Cart.fromJson(response.data);
    } catch (e) {
      print('Error updating cart item: $e');
      return null;
    }
  }

  Future<bool> removeFromCart(String itemId) async {
    try {
      await _apiClient.removeFromCart(itemId);
      return true;
    } catch (e) {
      print('Error removing from cart: $e');
      return false;
    }
  }

  Future<bool> clearCart() async {
    try {
      await _apiClient.clearCart();
      return true;
    } catch (e) {
      print('Error clearing cart: $e');
      return false;
    }
  }
}

