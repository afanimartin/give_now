import 'package:flutter/material.dart';

///
class ProgressLoader extends StatelessWidget {
  ///
  const ProgressLoader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      color: Theme.of(context).accentColor,
      child: const Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.black,
      )));
}
