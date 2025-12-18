import 'package:bookstore/core/api/api_client.dart';
import 'package:bookstore/core/models/order_item.dart';
import 'package:dio/dio.dart';

class OrderRepository {
  final ApiClient _apiClient;

  OrderRepository(this._apiClient);

  Future<List<Order>> getOrders({int page = 1, int pageSize = 20}) async {
    try {
      final isLoggedIn = await _apiClient.isLoggedIn();
      if (!isLoggedIn) {
        return [];
      }
      
      final response = await _apiClient.getOrders(page: page, pageSize: pageSize);
      final data = response.data;
      
      if (data == null) return [];
      
      if (data is List) {
        return data.map((item) => Order.fromJson(item)).toList();
      }
      
      if (data['orders'] != null) {
        return (data['orders'] as List)
            .map((item) => Order.fromJson(item))
            .toList();
      }
      
      return [];
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return [];
      }
      print('Error fetching orders: $e');
      return [];
    } catch (e) {
      print('Error fetching orders: $e');
      return [];
    }
  }

  Future<Order?> createOrder(String deliveryAddress) async {
    try {
      final response = await _apiClient.createOrder(deliveryAddress);
      return Order.fromJson(response.data);
    } catch (e) {
      print('Error creating order: $e');
      return null;
    }
  }

  Future<bool> cancelOrder(String orderId) async {
    try {
      await _apiClient.cancelOrder(orderId);
      return true;
    } catch (e) {
      print('Error cancelling order: $e');
      return false;
    }
  }
}

