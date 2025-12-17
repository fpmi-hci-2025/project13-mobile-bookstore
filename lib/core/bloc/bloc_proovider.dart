import 'package:bookstore/core/di/di_container.dart';
import 'package:bookstore/features/home/cart/bloc/baske_bloc.dart';
import 'package:bookstore/features/home/cart/domain/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final List<BlocProvider> appBlocProviders = [
    BlocProvider<BasketBloc>(
    create: (context) => BasketBloc(
      locator<CartRepository>()
    ),
  ),
];
