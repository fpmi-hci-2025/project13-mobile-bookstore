import 'package:bookstore/core/models/book.dart';

abstract class BasketEvent {}

class LoadBasket extends BasketEvent {}

class AddToBasket extends BasketEvent {
  final Book book;
  AddToBasket(this.book);
}

class RemoveFromBasket extends BasketEvent {
  final String id; // cart item id
  RemoveFromBasket(this.id);
}

class ClearBasket extends BasketEvent {}

class DecrementBasket extends BasketEvent {
  final String id; // cart item id
  DecrementBasket(this.id);
}

class IncrementBasket extends BasketEvent {
  final String id; // cart item id
  IncrementBasket(this.id);
}

class SyncBasket extends BasketEvent {}

