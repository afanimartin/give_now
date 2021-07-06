import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/item/item.dart';
import '../screens/item_detail_screen.dart';

///
class ItemCardWidget extends StatelessWidget {
  ///
  const ItemCardWidget({@required this.item, Key key}) : super(key: key);

  ///
  final Item item;

  @override
  Widget build(BuildContext context) => _buildItemCard(context, item);

  Widget _buildItemCard(BuildContext context, Item item) => GestureDetector(
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ItemDetailScreen(item: item))),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  item.mainImageUrl,
                  fit: BoxFit.cover,
                  width: 400,
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  item.title,
                ),
              )),
              Expanded(
                  child: Text(
                timeago.format(item.createdAt.toDate()),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ))
            ],
          ),
        ),
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Item>('item', item));
  }
}
