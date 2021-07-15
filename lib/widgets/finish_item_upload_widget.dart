import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/upload/upload_bloc.dart';
import '../blocs/upload/upload_state.dart';
import '../models/item/upload.dart';
import '../utils/category.dart';
import '../utils/condition.dart';
import '../utils/constants.dart';
import 'category_editing_widget.dart';
import 'condition_editing_widget.dart';
import 'description_editing_widget.dart';
import 'phone_number_widget.dart';
import 'price_editing_widget.dart';
import 'quantity_editing_widget.dart';
import 'submit_button_widget.dart';
import 'title_editing_widget.dart';

///
class FinishItemUploadWidget extends StatefulWidget {
  ///
  const FinishItemUploadWidget({Key key}) : super(key: key);

  @override
  _FinishItemUploadWidgetState createState() => _FinishItemUploadWidgetState();
}

class _FinishItemUploadWidgetState extends State<FinishItemUploadWidget> {
  final _titleContentController = TextEditingController();
  final _descriptionContentController = TextEditingController();
  final _priceContentController = TextEditingController();
  final _phoneController = TextEditingController();
  final _quantityController = TextEditingController();

  String _conditionValue = conditionList[0];
  String _categoryValue = categoryList[0];

  @override
  Widget build(BuildContext context) => BlocBuilder<UploadBloc, UploadState>(
        builder: (context, state) {
          final _upload = Upload(
              title: _titleContentController.text,
              description: _descriptionContentController.text,
              condition: _conditionValue,
              quantity: _quantityController.text,
              price: _priceContentController.text,
              category: _categoryValue,
              phone: _phoneController.text);

          return Align(
            alignment: const Alignment(0, -1),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TitleEditingWidget(
                    controller: _titleContentController,
                    onChanged: (String title) =>
                        context.read<UploadBloc>().titleChanged(title),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColorDark)),
                      labelText: 'title',
                      helperText: '',
                    ),
                  ),
                  const SizedBox(
                    height: Constants.six,
                  ),
                  DescriptionEditingWidget(
                    controller: _descriptionContentController,
                    maxLength: Constants.fiveHundred,
                    onChanged: (String description) => context
                        .read<UploadBloc>()
                        .descriptionChanged(description),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColorDark)),
                      labelText: 'description',
                      helperText: '',
                    ),
                  ),
                  const SizedBox(
                    height: Constants.six,
                  ),
                  PriceEditingWidget(
                    controller: _priceContentController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColorDark)),
                        labelText: 'price'),
                  ),
                  const SizedBox(
                    height: Constants.six,
                  ),
                  QuantityEditingWidget(controller: _quantityController),
                  const SizedBox(
                    height: Constants.six,
                  ),
                  PhoneNumberWidget(controller: _phoneController),
                  const SizedBox(
                    height: Constants.six,
                  ),
                  const SizedBox(
                    height: Constants.six,
                  ),
                  CategoryEditingWidget(
                    categoryValue: _categoryValue,
                    onChanged: (String value) {
                      setState(() {
                        _categoryValue = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: Constants.six,
                  ),
                  ConditonEditingWidget(
                      conditionValue: _conditionValue,
                      onChanged: (String value) {
                        setState(() {
                          _conditionValue = value;
                        });
                      }),
                  const SizedBox(
                    height: Constants.six,
                  ),
                  SubmitButtonWidget(
                    upload: _upload,
                  )
                ],
              ),
            ),
          );
        },
      );

  @override
  void dispose() {
    super.dispose();

    _titleContentController.clear();
    _descriptionContentController.clear();
    _priceContentController.clear();
    _phoneController.clear();
  }
}
