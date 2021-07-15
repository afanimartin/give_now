import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///
class ProgressLoader extends StatelessWidget {
  ///
  const ProgressLoader({this.color, this.value, Key key}) : super(key: key);

  ///
  final Color color;

  ///
  final double value;

  ///
  @override
  Widget build(BuildContext context) => Container(
      color: color,
      child: Center(
          child: CircularProgressIndicator(
        value: value,
        valueColor:
            AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorDark),
        backgroundColor: Theme.of(context).primaryColor,
      )));
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color));
    // ignore: cascade_invocations
    properties.add(DoubleProperty('value', value));
  }
}
