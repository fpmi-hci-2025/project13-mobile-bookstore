import 'package:bookstore/core/storage/basket_storage.dart';
import 'package:bookstore/features/home/cart/bloc/basket_state.dart';
import 'package:bookstore/features/home/cart/domain/cart_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  locator.registerSingleton<BasketStorage>(
    BasketStorage(locator<FlutterSecureStorage>()),
  );
  locator.registerSingleton<CartRepository>(CartRepository(locator<BasketStorage>()));
}
