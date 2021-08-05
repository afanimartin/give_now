import 'package:equatable/equatable.dart';
import '../../models/item/item.dart';

///
class DonationEvent extends Equatable {
  ///
  const DonationEvent();

  @override
  List<Object> get props => [];
}

///
class DonateItem extends DonationEvent {
  ///
  const DonateItem({required this.item});

  ///
  final Item item;

  ///
  @override
  List<Object> get props => [item];
}
