import 'package:bookstore/core/config/app_routes.dart';

class AppInitialRoute {
  static Future<String> getInitialRoute() async {
    return AppRoutes.getStarted;
  }
}
