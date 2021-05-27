import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final Color backgroundColor;

  const FloatingActionButtonWidget(
      {@required this.onPressed,
      @required this.child,
      @required this.backgroundColor,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        onPressed: onPressed,
        child: child,
        backgroundColor: backgroundColor,
      );
}
