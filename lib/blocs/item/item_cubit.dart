import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../extension_methods/item/item_repository_extensions.dart';

import '../../helpers/image/preview_images.dart';
import '../../helpers/image/upload_images.dart';
import '../../helpers/repository/upload_repository_helper.dart';
import '../../models/form/item_form.dart';
import '../../models/item/item.dart';
import '../../repositories/cart/cart_repository.dart';
import '../../repositories/item/i_item_repository.dart';
import 'item_state.dart';

///
class ItemCubit extends Cubit<ItemState> {
  ///
  ItemCubit(
      {required IItemRepository itemRepository,
      required FirebaseAuth firebaseAuth,
      required CartRepository? cartRepository})
      : _itemRepository = itemRepository,
        _firebaseAuth = firebaseAuth,
        _cartRepository = cartRepository,
        super(InitialItemState());

  final IItemRepository _itemRepository;

  ///
  final CartRepository? _cartRepository;

  ///
  final FirebaseAuth _firebaseAuth;

  StreamSubscription<List<Item>>? _itemStreamSubscription;

  ///
  void addImagesToState() async {
    try {
      final _files = await imagesToPreview();

      emit(state.copyWith(images: _files));
    } on Exception catch (_) {}
  }

  ///
  void addItem(Item item) async {
    // do not emit any state before this line
    // to avoid loss of images from the state object
    final _imagesToUpload = await imagesToUpload(state.images);
    final _imageUrls = await getDownloadURL(_imagesToUpload);

    emit(ItemBeingAdded());

    try {
      final _item = Item(
        sellerId: _firebaseAuth.currentUser?.uid,
        sellerPhotoUrl: _firebaseAuth.currentUser?.photoURL,
        title: item.title,
        description: item.description,
        condition: item.condition,
        quantity: item.quantity,
        category: item.category,
        price: item.price,
        sellerPhoneNumber: item.sellerPhoneNumber,
        mainImageUrl: _imageUrls[0],
        otherImageUrls: _imageUrls.sublist(1),
        createdAt: Timestamp.now(),
      );

      await _itemRepository.add(_item);
    } on Exception catch (_) {}
  }

  ///
  void addItemToCart(Item item) async {
    try {
      final _item = item.copyWith(
          buyerId: _firebaseAuth.currentUser!.uid, createdAt: Timestamp.now());

      await _cartRepository!.add(_item);
    } on Exception catch (_) {}
  }

  ///
  void fetchItems() async {
    try {
      await _itemStreamSubscription?.cancel();

      _itemStreamSubscription = _itemRepository
          .allItems()!
          .listen((items) => emit(ItemsLoaded(items: items)));
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  ///
  void updateItem(Item item) async {
    emit(ItemBeingUpdated());

    try {
      await _itemRepository.update(item);
    } on Exception catch (_) {}
  }

  ///
  void deleteItem(Item item) async {
    emit(ItemBeingDeleted());

    try {
      await _itemRepository.delete(item);
    } on Exception catch (_) {}
  }

  ///
  void donateItem(Item item) async {
    emit(ItemBeingDonated());
    try {
      await ItemRepositoryExtensions.donateItem(item);
    } on Exception catch (_) {}
  }

  ///
  void titleChanged(String value) {
    final title = TitleInput.dirty(value);
    emit(state.copyWith(
        title: title,
        formzStatus: Formz.validate([
          title,
          state.description,
          state.category,
          state.condition,
          state.price
        ])));
  }

  ///
  void descriptionChanged(String value) {
    final description = DescriptionInput.dirty(value);
    emit(state.copyWith(
        description: description,
        formzStatus: Formz.validate([
          description,
          state.title,
          state.category,
          state.condition,
          state.price
        ])));
  }

  ///
  void categoryChanged(String value) {
    final category = CategoryInput.dirty(value);
    emit(state.copyWith(
        category: category,
        formzStatus: Formz.validate([
          category,
          state.description,
          state.title,
          state.condition,
          state.price
        ])));
  }

  ///
  void conditionChanged(String value) {
    final condition = ConditionInput.dirty(value);
    emit(state.copyWith(
        condition: condition,
        formzStatus: Formz.validate([
          condition,
          state.description,
          state.category,
          state.title,
          state.price
        ])));
  }

  ///
  void quantityChanged(String value) {
    final quantity = QuantityInput.dirty(value);
    emit(state.copyWith(
        quantity: quantity,
        formzStatus: Formz.validate([
          quantity,
          state.condition,
          state.description,
          state.category,
          state.title,
          state.price
        ])));
  }

  ///
  void priceChanged(String value) {
    final price = PriceInput.dirty(value);
    emit(state.copyWith(
        price: price,
        formzStatus: Formz.validate([
          price,
          state.description,
          state.category,
          state.title,
          state.condition
        ])));
  }

  ///
  void phoneChanged(String value) {
    final _phone = PhoneNumberInput.dirty(value);
    emit(state.copyWith(
        phone: _phone,
        formzStatus: Formz.validate([
          _phone,
          state.title,
          state.description,
          state.category,
          state.condition,
          state.price
        ])));
  }
}
