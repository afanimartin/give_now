import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/cart/cart.dart';

///
class CartState extends Equatable {
  ///
  const CartState({this.cartItems, FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  ///
  final List<CartItem> cartItems;

  ///
  final FirebaseAuth _firebaseAuth;

  ///
  CartState copyWith({List<CartItem> cartItems}) =>
      CartState(cartItems: cartItems ?? this.cartItems);

  ///
  // List<CartItem> get currentUserCartItems => cartItems
  //     .where((item) => item.buyerId == _firebaseAuth.currentUser.uid)
  //     .toList();

  ///
  int get totalCost {
    int total = 0;

    for (int i = 0; i < cartItems.length; i++) {
      total += cartItems[i].price;
    }
    return total;
  }

  ///
  @override
  List<Object> get props => [cartItems];
}

///
class LoadingCartItems extends CartState {}
