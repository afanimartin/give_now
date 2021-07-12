import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/item/item.dart';

///
class ConfirmationDialog extends StatelessWidget {
  ///
  const ConfirmationDialog(
      {@required this.item,
      @required this.title,
      @required this.content,
      @required this.onPressed,
      Key key})
      : super(key: key);

  ///
  final Item item;

  ///
  final String title;

  ///
  final String content;

  ///
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: _confirmAction(context, item),
        builder: (BuildContext context, AsyncSnapshot<bool> bool) =>
            const Text(''),
      );

  Future<bool> _confirmAction(BuildContext context, Item item) async =>
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  title,
                  style: const TextStyle(fontSize: 22),
                ),
                content: Text(content),
                actions: [
                  TextButton(
                      onPressed: () => onPressed,
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 22),
                      )),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 22),
                      ))
                ],
              ));
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Item>('item', item));
    // ignore: cascade_invocations
    properties.add(StringProperty('title', title));
    // ignore: cascade_invocations
    properties.add(StringProperty('content', content));
    // ignore: cascade_invocations
    properties
        .add(DiagnosticsProperty<void Function()>('onPressed', onPressed));
  }
}
