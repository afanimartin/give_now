import 'package:flutter/material.dart';

///
class ProgressLoader extends StatelessWidget {
  ///
  const ProgressLoader({Key key}) : super(key: key);

  ///
  @override
  Widget build(BuildContext context) => SizedBox(
          child: Center(
              child: CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorDark),
        backgroundColor: Theme.of(context).accentColor,
      )));
}
