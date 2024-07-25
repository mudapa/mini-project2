import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/cart_model.dart';
import '../../../data/remote/cart_remote.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<LoadCartEvent>((event, emit) async {
      emit(CartLoadingState());
      try {
        final cart = await CartRemote().fetchCart();
        emit(CartLoadedState(cart: cart));
      } catch (e) {
        emit(CartErrorState());
      }
    });
  }
}
