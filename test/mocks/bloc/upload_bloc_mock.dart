import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:moostamil/models/form/item_form.dart';

import 'upload_event_mock.dart';
import 'upload_state_mock.dart';

class UploadBlocMock extends Bloc<UploadEventMock, UploadStateMock> {
  UploadBlocMock() : super(const UploadStateMock());

  @override
  Stream<UploadStateMock> mapEventToState(UploadEventMock event) async* {}

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
}
