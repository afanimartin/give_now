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
        backgroundColor: Theme.of(context).primaryColorLight,
      )));
}
