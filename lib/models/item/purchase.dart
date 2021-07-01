import 'package:equatable/equatable.dart';

///
class Purchase extends Equatable {
  ///
  const Purchase(
      this.id, this.sellerId, this.buyerId, this.buyerPhone, this.buyerAddress);

  ///
  final String id;

  ///
  final String sellerId;

  ///
  final String buyerId;

  ///
  final String buyerPhone;

  ///
  final String buyerAddress;

  @override
  List<Object> get props => [id, sellerId, buyerId, buyerPhone, buyerAddress];
}
