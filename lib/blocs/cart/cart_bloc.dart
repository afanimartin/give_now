import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

///
class CartBloc extends Bloc<CartEvent, CartState> {
  ///
  CartBloc() : super( CartState());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is LoadCartItems) {
      yield* _mapLoadCartItemsToState();
    } else if (event is UpdateCartItems) {
      yield* _mapCartUpdatedToState(event);
    }
  }

  Stream<CartState> _mapLoadCartItemsToState() async* {
    try {
      yield CartUpdated(cartItems: state.currentUserCartItems);
    } on Exception catch (_) {}
  }

  Stream<CartState> _mapCartUpdatedToState(UpdateCartItems event) async* {
    yield CartUpdated(cartItems: event.cartItems);
  }
}
