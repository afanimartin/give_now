import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:give_now/screens/home_screen.dart';

import '../blocs/upload/upload_bloc.dart';
import '../blocs/upload/upload_event.dart';
import '../blocs/upload/upload_state.dart';
import '../models/item/upload.dart';

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

  ///
  @override
  void dispose() {
    super.dispose();

    _titleContentController.clear();
    _descriptionContentController.clear();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<UploadBloc, UploadState>(
        builder: (context, state) {
          final _upload = Upload(
              title: _titleContentController.text,
              description: _descriptionContentController.text,
              condition: 'used',
              price: 1000,
              category: 'animal');

          return Align(
            alignment: const Alignment(0, -1),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _TitleInput(
                    controller: _titleContentController,
                  ),
                  _DescriptionInput(
                    controller: _descriptionContentController,
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
}

///
class _TitleInput extends StatelessWidget {
  ///
  const _TitleInput({@required this.controller, Key key}) : super(key: key);

  ///
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => BlocBuilder<UploadBloc, UploadState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) => TextField(
            controller: controller,
            maxLength: 140,
            onChanged: (title) =>
                context.read<UploadBloc>().titleChanged(title),
            decoration: const InputDecoration(
                labelText: 'title', helperText: '', errorText: ''),
          ));
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
  Widget build(BuildContext context) => BlocBuilder<UploadBloc, UploadState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) => TextField(
            controller: controller,
            maxLength: 500,
            onChanged: (description) =>
                context.read<UploadBloc>().descriptionChanged(description),
            decoration: const InputDecoration(
                labelText: 'description', helperText: '', errorText: ''),
          ));
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
                  HomeScreen.route(), (route) => false);
            },
            child: const Text('Upload')),
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Upload>('upload', upload));
  }
}
