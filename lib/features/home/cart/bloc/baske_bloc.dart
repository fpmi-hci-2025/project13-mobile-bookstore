import 'package:bookstore/core/api/cart_api_repository.dart';
import 'package:bookstore/core/models/cart_item.dart';
import 'package:bookstore/features/home/cart/bloc/basket_event.dart';
import 'package:bookstore/features/home/cart/bloc/basket_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final CartApiRepository repository;
  List<CartItem> _items = [];
  double _total = 0;

  BasketBloc(this.repository) : super(BasketLoading()) {
    on<LoadBasket>(_onLoadBasket);
    on<AddToBasket>(_onAddToBasket);
    on<RemoveFromBasket>(_onRemoveFromBasket);
    on<DecrementBasket>(_onDecrementBasket);
    on<IncrementBasket>(_onIncrementBasket);
    on<ClearBasket>(_onClearBasket);
    on<SyncBasket>(_onSyncBasket);
  }

  Future<void> _onLoadBasket(LoadBasket event, Emitter<BasketState> emit) async {
    emit(BasketLoading());
    
    final cart = await repository.getCart();
    _items = cart.items;
    _total = cart.total;
    
    _emitState(emit);
  }

  Future<void> _onAddToBasket(AddToBasket event, Emitter<BasketState> emit) async {
    final bookId = event.book.id;
    if (bookId == null) return;

    // Optimistic update
    final existingIndex = _items.indexWhere((item) => item.bookId == bookId);
    if (existingIndex != -1) {
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + 1,
      );
    } else {
      _items.add(CartItem(
        id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
        bookId: bookId,
        quantity: 1,
        book: event.book,
      ));
    }
    _recalculateTotal();
    _emitState(emit);

    // Sync with server
    final cart = await repository.addToCart(bookId);
    if (cart != null) {
      _items = cart.items;
      _total = cart.total;
      _emitState(emit);
    }
  }

  Future<void> _onRemoveFromBasket(RemoveFromBasket event, Emitter<BasketState> emit) async {
    // Optimistic update
    _items.removeWhere((item) => item.id == event.id);
    _recalculateTotal();
    _emitState(emit);

    // Sync with server
    await repository.removeFromCart(event.id);
  }

  Future<void> _onDecrementBasket(DecrementBasket event, Emitter<BasketState> emit) async {
    final index = _items.indexWhere((item) => item.id == event.id);
    if (index == -1) return;

    final item = _items[index];
    if (item.quantity > 1) {
      // Decrement quantity
      _items[index] = item.copyWith(quantity: item.quantity - 1);
      _recalculateTotal();
      _emitState(emit);

      // Sync with server
      final cart = await repository.updateCartItem(event.id, item.quantity - 1);
      if (cart != null) {
        _items = cart.items;
        _total = cart.total;
        _emitState(emit);
      }
    } else {
      // Remove item
      add(RemoveFromBasket(event.id));
    }
  }

  Future<void> _onIncrementBasket(IncrementBasket event, Emitter<BasketState> emit) async {
    final index = _items.indexWhere((item) => item.id == event.id);
    if (index == -1) return;

    final item = _items[index];
    
    // Optimistic update
    _items[index] = item.copyWith(quantity: item.quantity + 1);
    _recalculateTotal();
    _emitState(emit);

    // Sync with server
    final cart = await repository.updateCartItem(event.id, item.quantity + 1);
    if (cart != null) {
      _items = cart.items;
      _total = cart.total;
      _emitState(emit);
    }
  }

  Future<void> _onClearBasket(ClearBasket event, Emitter<BasketState> emit) async {
    _items.clear();
    _total = 0;
    emit(BasketEmpty());

    await repository.clearCart();
  }

  Future<void> _onSyncBasket(SyncBasket event, Emitter<BasketState> emit) async {
    final cart = await repository.getCart();
    _items = cart.items;
    _total = cart.total;
    _emitState(emit);
  }

  void _recalculateTotal() {
    _total = _items.fold(0, (sum, item) {
      final price = item.book?.price ?? 0;
      return sum + (price * item.quantity);
    });
  }

  void _emitState(Emitter<BasketState> emit) {
    if (_items.isEmpty) {
      emit(BasketEmpty());
    } else {
      emit(BasketLoaded(items: _items, total: _total));
    }
  }
}
