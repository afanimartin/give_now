import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///
class ProgressLoader extends StatelessWidget {
  ///
  const ProgressLoader({this.color, Key key}) : super(key: key);

  ///
  final Color color;

  ///
  @override
  Widget build(BuildContext context) => Container(
      color: color,
      child: Center(
          child: CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorDark),
        backgroundColor: Theme.of(context).accentColor,
      )));
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color));
  }
}
