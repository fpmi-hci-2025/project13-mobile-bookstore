import 'package:bookstore/core/models/basket_model.dart';
import 'package:bookstore/features/home/cart/bloc/basket_event.dart';
import 'package:bookstore/features/home/cart/bloc/basket_state.dart';
import 'package:bookstore/features/home/cart/domain/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final CartRepository repository;
  late Map<String, BasketModel> _items;

  BasketBloc(this.repository) : super(BasketLoading()) {
    _items = {};

    on<LoadBasket>((event, emit) async {
      _items = await repository.load();
      _emitState(emit);
    });
    on<DecrementBasket>((event, emit) async {
      final key = event.id;

      if (_items.containsKey(key)) {
        final currentQuantity = _items[key]!.quantity;
        if (currentQuantity > 1) {
          _items[key] = _items[key]!.copyWith(quantity: currentQuantity - 1);
        } else {
          _items.remove(key);
        }
        await repository.save(_items);
        _emitState(emit);
      }
    });

    on<AddToBasket>((event, emit) async {
      final key = event.book.title;

      if (_items.containsKey(key)) {
        _items[key] = _items[key]!.copyWith(
          quantity: _items[key]!.quantity + 1,
        );
      } else {
        _items[key] = BasketModel(
          book: event.book,
          quantity: 1,
          date: DateTime.now(),
        );
      }

      await repository.save(_items);
      _emitState(emit);
    });

    on<RemoveFromBasket>((event, emit) async {
      _items.remove(event.id);

      await repository.save(_items);
      _emitState(emit);
    });

    on<ClearBasket>((event, emit) async {
      _items.clear();
      await repository.clear();
      emit(BasketEmpty());
    });
  }

  void _emitState(Emitter<BasketState> emit) {
    if (_items.isEmpty) {
      emit(BasketEmpty());
    } else {
      emit(BasketLoaded(_items));
    }
  }
}
