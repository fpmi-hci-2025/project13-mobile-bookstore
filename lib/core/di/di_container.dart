import 'package:bookstore/core/api/api_client.dart';
import 'package:bookstore/core/api/author_repository.dart';
import 'package:bookstore/core/api/book_repository.dart';
import 'package:bookstore/core/storage/basket_storage.dart';
import 'package:bookstore/features/home/cart/domain/cart_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Storage
  locator.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  
  // API Client
  locator.registerSingleton<ApiClient>(
    ApiClient(locator<FlutterSecureStorage>()),
  );
  
  // Repositories
  locator.registerSingleton<BookRepository>(
    BookRepository(locator<ApiClient>()),
  );
  locator.registerSingleton<AuthorRepository>(
    AuthorRepository(locator<ApiClient>()),
  );
  
  // Legacy (for basket)
  locator.registerSingleton<BasketStorage>(
    BasketStorage(locator<FlutterSecureStorage>()),
  );
  locator.registerSingleton<CartRepository>(
    CartRepository(locator<BasketStorage>()),
  );
}
