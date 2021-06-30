import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/upload/upload_bloc.dart';
import '../blocs/upload/upload_event.dart';
import '../blocs/upload/upload_state.dart';
import '../models/item/upload.dart';
import '../screens/home_screen.dart';
import '../utils/category.dart';
import '../utils/condition.dart';

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

  String _categoryValue = categoryList[0];
  String _conditionValue = conditionList[0];

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
                  _TitleInput(
                    controller: _titleContentController,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  _DescriptionInput(
                    controller: _descriptionContentController,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  _renderCategory(),
                  const SizedBox(
                    height: 6,
                  ),
                  _renderCondition(),
                  const SizedBox(
                    height: 6,
                  ),
                  _ItemPrice(controller: _priceContentController),
                  const SizedBox(
                    height: 6,
                  ),
                  _SellerPhoneNumber(controller: _phoneController),
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

  Widget _renderCategory() => DropdownButton(
        value: _categoryValue,
        elevation: 0,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: categoryList
            .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 22),
                )))
            .toList(),
        onChanged: (String value) {
          setState(() {
            _categoryValue = value;
          });
        },
      );

  Widget _renderCondition() => DropdownButton(
        value: _conditionValue,
        elevation: 0,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: conditionList
            .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 22),
                )))
            .toList(),
        onChanged: (String value) {
          setState(() {
            _conditionValue = value;
          });
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
class _TitleInput extends StatelessWidget {
  ///
  const _TitleInput({@required this.controller, Key key}) : super(key: key);

  ///
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        maxLength: 140,
        onChanged: (String title) =>
            context.read<UploadBloc>().titleChanged(title),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColorDark)),
          labelText: 'title',
          helperText: '',
        ),
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<TextEditingController>('controller', controller));
  }
}

///
class _DescriptionInput extends StatelessWidget {
  ///
  const _DescriptionInput({@required this.controller, Key key})
      : super(key: key);

  ///
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => BlocListener<UploadBloc, UploadState>(
        listener: (context, state) {},
        child: TextField(
          controller: controller,
          onChanged: (String description) =>
              context.read<UploadBloc>().descriptionChanged(description),
          maxLength: 500,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).primaryColorDark)),
            labelText: 'description',
            helperText: '',
          ),
        ),
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<TextEditingController>('controller', controller));
  }
}

///
class _ItemPrice extends StatelessWidget {
  const _ItemPrice({@required this.controller, Key key}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        onChanged: (String title) =>
            context.read<UploadBloc>().priceChanged(title),
        decoration: InputDecoration(
            labelText: 'price',
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

              Navigator.of(context)
                  .pushAndRemoveUntil<void>(HomeScreen.route, (route) => false);
            },
            child: const Text('Upload')),
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Upload>('upload', upload));
  }
}
