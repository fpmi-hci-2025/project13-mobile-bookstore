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

  Future<UpdateProfileResult> updateProfile({String? username, String? email}) async {
    try {
      final response = await _apiClient.updateProfile(
        username: username,
        email: email,
      );
      return UpdateProfileResult.success(User.fromJson(response.data));
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        return UpdateProfileResult.error('Username or email already taken');
      }
      if (e.response?.statusCode == 400) {
        final message = e.response?.data['error'] ?? 'Invalid data';
        return UpdateProfileResult.error(message);
      }
      return UpdateProfileResult.error('Connection error. Please try again.');
    } catch (e) {
      return UpdateProfileResult.error('Something went wrong. Please try again.');
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

class UpdateProfileResult {
  final bool isSuccess;
  final User? user;
  final String? error;

  UpdateProfileResult._({
    required this.isSuccess,
    this.user,
    this.error,
  });

  factory UpdateProfileResult.success(User user) => UpdateProfileResult._(
    isSuccess: true,
    user: user,
  );

  factory UpdateProfileResult.error(String message) => UpdateProfileResult._(
    isSuccess: false,
    error: message,
  );
}

