import 'package:bookstore/core/models/basket_model.dart';
import 'package:bookstore/core/storage/basket_storage.dart';

class CartRepository {
  final BasketStorage storage;

  CartRepository(this.storage);

  Future<Map<String, BasketModel>> load() async {
    return await storage.loadBasketItems();
  }

  Future<void> save(Map<String, BasketModel> items) async {
    return await storage.saveBasketItems(items);
  }

  Future<void> clear() async {
    return await storage.clearBasketItems();
  }
}
