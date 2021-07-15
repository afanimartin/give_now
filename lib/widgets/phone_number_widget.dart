import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/upload/upload_bloc.dart';

///
class PhoneNumberWidget extends StatelessWidget {
  ///
  const PhoneNumberWidget({@required this.controller, Key key})
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
