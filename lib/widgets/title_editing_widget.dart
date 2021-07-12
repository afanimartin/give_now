import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///
class TitleEditingWidget extends StatelessWidget {
  ///
  const TitleEditingWidget(
      {@required this.controller,
      this.onChanged,
      this.decoration,
      this.style,
      this.maxLength,
      Key key})
      : super(key: key);

  ///
  final TextEditingController controller;

  ///
  final InputDecoration decoration;

  ///
  final TextStyle style;

  ///
  final int maxLength;

  ///
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        maxLength: maxLength,
        onChanged: onChanged,
        decoration: decoration,
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<TextEditingController>('controller', controller));
    // ignore: cascade_invocations
    properties
        .add(DiagnosticsProperty<InputDecoration>('decoration', decoration));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<void Function(String value)>(
        'onChanged', onChanged));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<TextStyle>('style', style));
    // ignore: cascade_invocations
    properties.add(IntProperty('maxLength', maxLength));
  }
}
