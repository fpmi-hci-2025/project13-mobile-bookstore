import 'dart:convert';
import 'dart:developer';
import 'package:bookstore/core/models/basket_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class BasketStorage {
  final FlutterSecureStorage _storage;
  static const String _key = 'basket_items';

  BasketStorage(this._storage);

  Future<void> saveBasketItems(Map<String, BasketModel> items) async {
    try {
      final jsonList = items.map((key, item) => MapEntry(key, item.toJson()));
      final jsonString = json.encode(jsonList);
      await _storage.write(key: _key, value: jsonString);
      // log('Saving key: $_key with JSON data: $jsonString');
      for (var entry in items.entries) {
        log('[BASKET SAVE] Key: ${entry.key} | Value: ${entry.value}');
      }
    } catch (e) {
      // throw BasketStorageException(
      //   'Failed to save basket items: ${e.toString()}',
      // );
    }
  }

  Future<Map<String, BasketModel>> loadBasketItems() async {
   // try {
      final jsonString = await _storage.read(key: _key);
      if (jsonString == null) return {};

      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return jsonMap.map((key, item) =>
        MapEntry(key, BasketModel.fromJson(Map<String, dynamic>.from(item))));
    // } catch (e) {
    //   throw BasketStorageException('Failed to load basket items: ${e.toString()}');
    // }
  //  return testBasketItems;
  }

  Future<void> clearBasketItems() async {
    try {
      final existingItems = await loadBasketItems();

      if (existingItems.isNotEmpty) {
        for (final entry in existingItems.entries) {
                log('[BASKET Delete] Key: ${entry.key} | Value: ${entry.value}');
        }
      } else {
        log('Корзина уже пуста, удалять нечего.');
      }

      await _storage.delete(key: _key);
    } catch (e) {
      // throw BasketStorageException(
      //   'Failed to clear all basket items: ${e.toString()}',
      // );
    }
  }

  Future<void> clearBasketItem() async {
    try {
      await _storage.delete(key: _key);
    } catch (e) {
      // throw BasketStorageException(
      //   'Failed to clear single basket item: ${e.toString()}',
      // );
    }
  }
}