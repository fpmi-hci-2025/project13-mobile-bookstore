import 'package:bookstore/core/api/api_client.dart';
import 'package:bookstore/core/api/auth_repository.dart';
import 'package:bookstore/core/api/author_repository.dart';
import 'package:bookstore/core/api/book_repository.dart';
import 'package:bookstore/core/api/cart_api_repository.dart';
import 'package:bookstore/core/api/favorite_repository.dart';
import 'package:bookstore/core/api/order_repository.dart';
import 'package:bookstore/core/services/location_service.dart';
import 'package:bookstore/features/home/cart/bloc/baske_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
final getIt = GetIt.instance;

void setupLocator() {
  // Storage
  locator.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  
  // API Client
  locator.registerSingleton<ApiClient>(
    ApiClient(locator<FlutterSecureStorage>()),
  );
  
  // Repositories
  locator.registerSingleton<AuthRepository>(
    AuthRepository(locator<ApiClient>()),
  );
  locator.registerSingleton<BookRepository>(
    BookRepository(locator<ApiClient>()),
  );
  locator.registerSingleton<AuthorRepository>(
    AuthorRepository(locator<ApiClient>()),
  );
  locator.registerSingleton<CartApiRepository>(
    CartApiRepository(locator<ApiClient>()),
  );
  locator.registerSingleton<FavoriteRepository>(
    FavoriteRepository(locator<ApiClient>()),
  );
  locator.registerSingleton<OrderRepository>(
    OrderRepository(locator<ApiClient>()),
  );
  
  // Services
  locator.registerSingleton<LocationService>(LocationService());
  
  // Blocs
  locator.registerFactory<BasketBloc>(
    () => BasketBloc(locator<CartApiRepository>()),
  );
}
