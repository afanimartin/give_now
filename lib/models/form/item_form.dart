import 'package:formz/formz.dart';

///
enum InputError {
  ///
  empty
}

///
class TitleInput extends FormzInput<String, InputError> {
  const TitleInput.pure() : super.pure('');

  ///
  const TitleInput.dirty([String value = '']) : super.dirty(value);

  @override
  InputError validator(String value) =>
      value.isNotEmpty ? null : InputError.empty;
}

///
class DescriptionInput extends FormzInput<String, InputError> {
  const DescriptionInput.pure() : super.pure('');

  ///
  const DescriptionInput.dirty([String value = '']) : super.dirty(value);

  @override
  InputError validator(String value) =>
      value.isNotEmpty ? null : InputError.empty;
}

///
class CategoryInput extends FormzInput<String, InputError> {
  const CategoryInput.pure() : super.pure('');

  ///
  const CategoryInput.dirty([String value = '']) : super.dirty(value);

  @override
  InputError validator(String value) =>
      value.isNotEmpty ? null : InputError.empty;
}

///
class ConditionInput extends FormzInput<String, InputError> {
  const ConditionInput.pure() : super.pure('');

  ///
  const ConditionInput.dirty([String value = '']) : super.dirty(value);

  @override
  InputError validator(String value) =>
      value.isNotEmpty ? null : InputError.empty;
}

///
class PriceInput extends FormzInput<String, InputError> {
  const PriceInput.pure() : super.pure('');

  ///
  const PriceInput.dirty([String value = '']) : super.dirty(value);

  @override
  InputError validator(String value) =>
      value.isNotEmpty ? null : InputError.empty;
}

///
enum PhoneNumberInputError {
  ///
  invalid
}

///
class PhoneNumberInput extends FormzInput<String, PhoneNumberInputError> {
  const PhoneNumberInput.pure() : super.pure('');

  ///
  PhoneNumberInput.dirty([String value = '']) : super.dirty(value);

  // static final RegExp _phoneValidator =
  //     RegExp(r'^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$');

  ///
  @override
  PhoneNumberInputError validator(String value) =>
      value.isNotEmpty ? null : PhoneNumberInputError.invalid;
}
