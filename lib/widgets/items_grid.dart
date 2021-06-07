import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../models/item/item.dart';
import '../screens/item_detail_screen.dart';

///
class ItemsGrid extends StatelessWidget {
  ///
  const ItemsGrid({@required this.items, Key key}) : super(key: key);

  ///
  final List<Item> items;

  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
        sliver: SliverGrid(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            final item = items[index];

            return _buildItemCard(context, item);
          }, childCount: items?.length),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisSpacing: 10,
          ),
        ),
      );

  Widget _buildItemCard(BuildContext context, Item item) =>
      GestureDetector(
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
                timeago.format(item.timestamp.toDate()),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ))
            ],
          ),
        ),
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<Item>('items', items));
    // ignore: cascade_invocations
  }
}
