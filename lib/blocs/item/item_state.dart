import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

import '../../models/form/item_form.dart';
import '../../models/item/item.dart';

///
class ItemState extends Equatable {
  ///
  const ItemState({
    this.title = const TitleInput.pure(),
    this.description = const DescriptionInput.pure(),
    this.category = const CategoryInput.pure(),
    this.condition = const ConditionInput.pure(),
    this.quantity = const QuantityInput.pure(),
    this.price = const PriceInput.pure(),
    this.phone = const PhoneNumberInput.pure(),
    this.images,
    this.formzStatus = FormzStatus.pure,
  });

  ///
  final TitleInput title;

  ///
  final DescriptionInput description;

  ///
  final CategoryInput category;

  ///
  final ConditionInput condition;

  ///
  final QuantityInput quantity;

  ///
  final PriceInput price;

  ///
  final PhoneNumberInput phone;

  ///
  final List<Asset>? images;

  ///
  final FormzStatus formzStatus;

  ///
  ItemState copyWith(
          {TitleInput? title,
          DescriptionInput? description,
          CategoryInput? category,
          ConditionInput? condition,
          QuantityInput? quantity,
          PriceInput? price,
          PhoneNumberInput? phone,
          List<Asset>? images,
          FormzStatus? formzStatus}) =>
      ItemState(
          title: title ?? this.title,
          description: description ?? this.description,
          category: category ?? this.category,
          condition: condition ?? this.condition,
          quantity: quantity ?? this.quantity,
          price: price ?? this.price,
          phone: phone ?? this.phone,
          images: images ?? this.images,
          formzStatus: formzStatus ?? this.formzStatus);

  @override
  List<Object?> get props => [
        title,
        description,
        category,
        condition,
        quantity,
        price,
        phone,
        images,
        formzStatus,
      ];
}

///
class InitialItemState extends ItemState {}

///
class ItemsLoaded extends ItemState {
  ///
  ItemsLoaded({required this.items, FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  ///
  final List<Item> items;

  ///
  final FirebaseAuth _firebaseAuth;

  ///
  List<Item> get itemsForSale => items
      .where((item) =>
          item.sellerId != _firebaseAuth.currentUser!.uid &&
          int.parse(item.quantity!) > 0)
      .toList();

  ///
  List<Item> get currentUserItems => items
      .where((item) => item.sellerId == _firebaseAuth.currentUser!.uid)
      .toList();

  ///
  @override
  List<Object?> get props => [items];
}

///
class ItemBeingAdded extends ItemState {}

///
class ItemBeingUpdated extends ItemState {}

///
class ItemBeingDeleted extends ItemState {}

///
class ItemBeingDonated extends ItemState {}
