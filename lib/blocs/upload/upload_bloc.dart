import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../helpers/image/preview_images.dart';
import '../../helpers/image/upload_images.dart';
import '../../helpers/repository/upload_repository_helper.dart';
import '../../models/form/item_form.dart';
import '../../models/item/item.dart';
import '../../repositories/upload/upload_repository.dart';
import 'upload_event.dart';
import 'upload_state.dart';

///
class UploadBloc extends Bloc<ItemEvent, UploadState> {
  ///
  UploadBloc(
      {@required UploadRepository itemRepository, FirebaseAuth firebaseAuth})
      : _itemRepository = itemRepository,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(const UploadState());

  ///
  final UploadRepository _itemRepository;

  ///
  final FirebaseAuth _firebaseAuth;

  @override
  Stream<UploadState> mapEventToState(ItemEvent event) async* {
    if (event is PickAndPreviewImages) {
      yield* _mapPickAndUploadItemsToState();
    } else if (event is UploadItem) {
      yield* _mapUploadItemToState(event);
    }
  }

  Stream<UploadState> _mapPickAndUploadItemsToState() async* {
    try {
      final _files = await imagesToPreview();

      yield UploadState(images: _files);
    } on Exception catch (_) {}
  }

  Stream<UploadState> _mapUploadItemToState(UploadItem event) async* {
    yield ItemBeingAdded();

    final _imagesToUpload = await imagesToUpload(state.images);
    final _imageUrls = await getDownloadURL(_imagesToUpload);

    try {
      final _item = Item(
        sellerId: _firebaseAuth.currentUser.uid,
        sellerPhotoUrl: _firebaseAuth.currentUser.photoURL,
        title: event.item.title,
        description: event.item.description,
        condition: event.item.condition,
        quantity: event.item.quantity,
        category: event.item.category,
        price: event.item.price,
        sellerPhoneNumber: event.item.sellerPhoneNumber,
        mainImageUrl: _imageUrls[0],
        otherImageUrls: _imageUrls.sublist(1),
        createdAt: Timestamp.now(),
      );

      await _itemRepository.upload(_item);
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
