import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:give_now/screens/marketplace_screen.dart';

import '../blocs/upload/upload_bloc.dart';
import '../blocs/upload/upload_event.dart';
import '../blocs/upload/upload_state.dart';
import '../models/item/upload.dart';
import '../screens/user_profile_screen.dart';
import '../utils/category.dart';
import '../utils/condition.dart';
import 'category_editing_widget.dart';
import 'condition_editing_widget.dart';
import 'description_editing_widget.dart';
import 'price_editing_widget.dart';
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

  String _conditionValue = conditionList[0];
  String _categoryValue = categoryList[0];

  @override
  Widget build(BuildContext context) => BlocBuilder<UploadBloc, UploadState>(
        builder: (context, state) {
          final _upload = Upload(
              title: _titleContentController.text,
              description: _descriptionContentController.text,
              condition: _conditionValue,
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
                    height: 6,
                  ),
                  DescriptionEditingWidget(
                    controller: _descriptionContentController,
                    maxLength: 500,
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
                    height: 6,
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
                    height: 6,
                  ),
                  _SellerPhoneNumber(controller: _phoneController),
                  const SizedBox(
                    height: 6,
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
                    height: 6,
                  ),
                  ConditonEditingWidget(
                      conditionValue: _conditionValue,
                      onChanged: (String value) {
                        setState(() {
                          _conditionValue = value;
                        });
                      }),
                  const SizedBox(
                    height: 6,
                  ),
                  _SubmitButton(
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

///
class _SellerPhoneNumber extends StatelessWidget {
  const _SellerPhoneNumber({@required this.controller, Key key})
      : super(key: key);

  ///
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        keyboardType: TextInputType.phone,
        onChanged: (String phone) =>
            context.read<UploadBloc>().phoneChanged(phone),
        maxLength: 10,
        decoration: InputDecoration(
            labelText: 'phone',
            border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).primaryColorDark))),
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<TextEditingController>('controller', controller));
  }
}

///
class _SubmitButton extends StatelessWidget {
  const _SubmitButton({@required this.upload, Key key}) : super(key: key);

  ///
  final Upload upload;

  @override
  Widget build(BuildContext context) => BlocBuilder<UploadBloc, UploadState>(
        builder: (context, state) => TextButton(
            onPressed: () {
              context.read<UploadBloc>().add(UploadItem(upload: upload));

              Navigator.of(context).pushAndRemoveUntil<void>(
                  UserProfileScreen.route, (route) => false);
            },
            child: const Text('Upload')),
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Upload>('upload', upload));
  }
}
