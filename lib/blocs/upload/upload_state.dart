import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import '../../models/form/item_form.dart';

///
class UploadState extends Equatable {
  ///
  const UploadState({
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
  UploadState copyWith(
          {TitleInput? title,
          DescriptionInput? description,
          CategoryInput? category,
          ConditionInput? condition,
          QuantityInput? quantity,
          PriceInput? price,
          PhoneNumberInput? phone,
          List<Asset>? images,
          FormzStatus? formzStatus}) =>
      UploadState(
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
class ItemBeingAdded extends UploadState {}

///
class ItemUploadedSuccessfully extends UploadState {}
