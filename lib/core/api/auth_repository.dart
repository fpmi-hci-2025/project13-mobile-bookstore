import 'package:bookstore/core/api/api_client.dart';
import 'package:bookstore/core/models/user.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<AuthResult> login(String email, String password) async {
    try {
      final response = await _apiClient.login(email, password);
      final authResponse = AuthResponse.fromJson(response.data);
      
      // Save token
      await _apiClient.saveToken(authResponse.token);
      
      return AuthResult.success(authResponse);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return AuthResult.error('Invalid email or password');
      }
      return AuthResult.error('Connection error. Please try again.');
    } catch (e) {
      return AuthResult.error('Something went wrong. Please try again.');
    }
  }

  Future<AuthResult> register(String username, String email, String password) async {
    try {
      final response = await _apiClient.register(username, email, password);
      final authResponse = AuthResponse.fromJson(response.data);
      
      // Save token
      await _apiClient.saveToken(authResponse.token);
      
      return AuthResult.success(authResponse);
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        return AuthResult.error('User with this email already exists');
      }
      if (e.response?.statusCode == 400) {
        final message = e.response?.data['error'] ?? 'Invalid data';
        return AuthResult.error(message);
      }
      return AuthResult.error('Connection error. Please try again.');
    } catch (e) {
      return AuthResult.error('Something went wrong. Please try again.');
    }
  }

  Future<User?> getProfile() async {
    try {
      final response = await _apiClient.getProfile();
      return User.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    await _apiClient.clearToken();
  }

  Future<bool> isLoggedIn() async {
    return _apiClient.isLoggedIn();
  }
}

class AuthResult {
  final bool isSuccess;
  final AuthResponse? data;
  final String? error;

  AuthResult._({
    required this.isSuccess,
    this.data,
    this.error,
  });

  factory AuthResult.success(AuthResponse data) => AuthResult._(
    isSuccess: true,
    data: data,
  );

  factory AuthResult.error(String message) => AuthResult._(
    isSuccess: false,
    error: message,
  );
}

