import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/condition.dart';

///
class ConditonEditingWidget extends StatefulWidget {
  ///
  const ConditonEditingWidget(
      {@required this.conditionValue, @required this.onChanged, Key key})
      : super(key: key);

  ///
  final String conditionValue;

  ///
  final void Function(String) onChanged;

  @override
  _ConditonEditingWidgetState createState() => _ConditonEditingWidgetState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<void Function(String p1)>('onChanged', onChanged));
    // ignore: cascade_invocations
    properties.add(StringProperty('conditionValue', conditionValue));
  }
}

class _ConditonEditingWidgetState extends State<ConditonEditingWidget> {
  @override
  Widget build(BuildContext context) => DropdownButton(
        value: widget.conditionValue,
        elevation: 0,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: conditionList
            .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 22),
                )))
            .toList(),
        onChanged: widget.onChanged,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('conditionValue', widget.conditionValue));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<void Function(String p1)>(
        'onChanged', widget.onChanged));
  }
}
