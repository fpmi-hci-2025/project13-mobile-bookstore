import 'package:bookstore/core/models/cart_item.dart';

abstract class BasketState {}

class BasketLoading extends BasketState {}

class BasketLoaded extends BasketState {
  final List<CartItem> items;
  final double total;

  BasketLoaded({required this.items, required this.total});
}

class BasketEmpty extends BasketState {}

class BasketError extends BasketState {
  final String message;
  BasketError(this.message);
}
