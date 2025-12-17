import 'package:bookstore/core/models/book.dart';

abstract class BasketEvent {}

class LoadBasket extends BasketEvent {}

class AddToBasket extends BasketEvent {
  final Book book;
  AddToBasket(this.book);
}

class RemoveFromBasket extends BasketEvent {
  final String id; // book.title or uuid
  RemoveFromBasket(this.id);
}

class ClearBasket extends BasketEvent {}
class DecrementBasket extends BasketEvent {
  final String id; // обычно title книги

  DecrementBasket(this.id);
}
