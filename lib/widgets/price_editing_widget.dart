import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/item/item_cubit.dart';

///
class PriceEditingWidget extends StatelessWidget {
  ///
  const PriceEditingWidget(
      {required this.controller,
      this.onChanged,
      this.decoration,
      this.style,
      Key? key})
      : super(key: key);

  ///
  final TextEditingController controller;

  ///
  final InputDecoration? decoration;

  ///
  final TextStyle? style;

  ///
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        onChanged: (String price) =>
            context.read<ItemBloc>().priceChanged(price),
        keyboardType: TextInputType.number,
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
  }
}
