import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/item/item_cubit.dart';

///
class QuantityEditingWidget extends StatelessWidget {
  ///
  const QuantityEditingWidget({required this.controller, Key? key})
      : super(key: key);

  ///
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        onChanged: (String quantity) =>
            context.read<ItemBloc>().quantityChanged(quantity),
        decoration: InputDecoration(
            labelText: 'quantity',
            border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).primaryColorDark))),
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<TextEditingController>('controller', controller));
  }
}
