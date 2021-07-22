import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///
class PhoneNumberEditingWidget extends StatelessWidget {
  ///
  const PhoneNumberEditingWidget(
      {@required this.controller, @required this.onChanged, Key key})
      : super(key: key);

  ///
  final TextEditingController controller;

  ///
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        keyboardType: TextInputType.phone,
        onChanged: onChanged,
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
    // ignore: cascade_invocations
    properties.add(
        DiagnosticsProperty<void Function(String p1)>('onChanged', onChanged));
  }
}
