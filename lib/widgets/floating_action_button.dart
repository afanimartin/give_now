import 'package:flutter/material.dart';

///
class FloatingActionButtonWidget extends StatelessWidget {
  ///
  const FloatingActionButtonWidget(
      {@required this.onPressed,
      @required this.child,
      @required this.backgroundColor,
      Key key})
      : super(key: key);

  ///
  final void Function() onPressed;

  ///
  final Widget child;

  ///
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: backgroundColor,
        child: child,
      );
}
