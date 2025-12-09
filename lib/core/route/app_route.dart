import 'package:bookstore/core/config/app_routes.dart';
import 'package:bookstore/features/auth/presentation/page/auth_page.dart';
import 'package:bookstore/features/home/navigation/pages/navigation_page.dart';
import 'package:bookstore/features/home/profile/page/account/presentation/page/my_account_page.dart';
import 'package:bookstore/features/home/profile/page/favorite/presentation/page/favorite_page.dart';
import 'package:bookstore/features/home/profile/page/location/presentation/page/my_location_page.dart';
import 'package:bookstore/features/home/profile/page/order/presentation/page/order_page.dart';
import 'package:bookstore/features/location/presentation/page/location_page.dart';
import 'package:bookstore/features/location/presentation/page/select_location_page.dart';
import 'package:bookstore/features/onboarding/presentation/page/onboarding_page.dart';
import 'package:bookstore/features/registration/presentation/page/registration_page.dart';
import 'package:bookstore/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return route(SplashPage());
      case AppRoutes.getStarted:
        return route(OnboardingPage());
      case AppRoutes.auth:
        return route(const AuthPage());
      case AppRoutes.registration:
        return route(const RegistrationPage());
      case AppRoutes.location:
        return route(const LocationPage());
      case AppRoutes.selectLocation:
        return route(const SelectLocationPage());
      case AppRoutes.navigation:
        return route(const NavigationPage());
      case AppRoutes.myAccount:
        return route(const MyAccountPage());
      case AppRoutes.favorite:
        return route(FavoritesPage());
      case AppRoutes.order:
        return route(OrderPage());
      case AppRoutes.myLocation:
        return route(MyLocationPage());
      default:
        return route(OnboardingPage());
    }
  }
}

MaterialPageRoute route(Widget page, {RouteSettings? settings}) {
  return MaterialPageRoute(settings: settings, builder: (_) => page);
}
