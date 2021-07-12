import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/category.dart';

///
class CategoryEditingWidget extends StatefulWidget {
  ///
  const CategoryEditingWidget(
      {@required this.categoryValue, @required this.onChanged, Key key})
      : super(key: key);

  ///
  final void Function(String) onChanged;

  ///
  final String categoryValue;

  @override
  _CategoryEditingWidgetState createState() => _CategoryEditingWidgetState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('categoryValue', categoryValue));
    // ignore: cascade_invocations
    properties.add(
        DiagnosticsProperty<void Function(String p1)>('onChanged', onChanged));
  }
}

class _CategoryEditingWidgetState extends State<CategoryEditingWidget> {
  @override
  Widget build(BuildContext context) => DropdownButton(
        value: widget.categoryValue,
        elevation: 0,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: categoryList
            .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 22),
                )))
            .toList(),
        onChanged: widget.onChanged,
      );
}
