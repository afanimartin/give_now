import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';

import '../../helpers/image/preview_image.dart';
import '../../helpers/image/upload_image.dart';
import '../../models/form/item_form.dart';
import '../../repositories/item/item_repository.dart';
import 'upload_event.dart';
import 'upload_state.dart';

///
class UploadBloc extends Bloc<UploadEvent, UploadState> {
  ///
  UploadBloc(
      {@required ItemRepository itemRepository, FirebaseAuth firebaseAuth})
      : _itemRepository = itemRepository,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(const UploadState());

  ///
  final ItemRepository _itemRepository;

  ///
  final FirebaseAuth _firebaseAuth;

  @override
  Stream<UploadState> mapEventToState(UploadEvent event) async* {
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
    yield ItemIsBeingAdded();

    const _uuid = Uuid();

    final _imagesToUpload = await imagesToUpload(state.images);

    try {
      final _item = event.upload.copyWith(
          id: _uuid.v4(),
          sellerId: _firebaseAuth.currentUser.uid,
          sellerPhotoUrl: _firebaseAuth.currentUser.photoURL,
          title: event.upload.title,
          description: event.upload.description,
          condition: event.upload.condition,
          category: event.upload.category,
          price: event.upload.price,
          phone: event.upload.phone
          );

      await _itemRepository.uploadItemToFirestore(_item, _imagesToUpload);

      yield ItemUploadedSuccessfully();
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
