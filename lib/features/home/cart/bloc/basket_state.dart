import 'package:bookstore/core/models/basket_model.dart';

abstract class BasketState {}

class BasketLoading extends BasketState {}

class BasketLoaded extends BasketState {
  final Map<String, BasketModel> items;
  final double total;

  BasketLoaded(this.items)
      : total = items.values
            .map((e) => e.book.price * e.quantity)
            .fold(0, (a, b) => a + b);
}

class BasketEmpty extends BasketState {}
