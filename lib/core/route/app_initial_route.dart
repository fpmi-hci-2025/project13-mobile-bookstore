import 'package:bookstore/core/api/auth_repository.dart';
import 'package:bookstore/core/config/app_routes.dart';
import 'package:bookstore/core/di/di_container.dart';

class AppInitialRoute {
  static Future<String> getInitialRoute() async {
    try {
      final authRepository = locator<AuthRepository>();
      final isLoggedIn = await authRepository.isLoggedIn();
      
      if (isLoggedIn) {
        // Verify token is still valid by fetching profile
        final user = await authRepository.getProfile();
        if (user != null) {
          return AppRoutes.navigation;
        }
      }
    } catch (e) {
      // If any error, go to onboarding
      print('Auth check error: $e');
    }
    
    return AppRoutes.getStarted;
  }
}
