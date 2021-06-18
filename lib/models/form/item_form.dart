import 'package:formz/formz.dart';

///
enum InputError {
  ///
  empty
}

///
class ItemForm extends FormzInput<String, InputError> {
  const ItemForm.pure() : super.pure('');

  ///
  const ItemForm.dirty({String value = ''}) : super.dirty(value);

  @override
  InputError validator(String value) =>
      value.isNotEmpty ? null : InputError.empty;
}
