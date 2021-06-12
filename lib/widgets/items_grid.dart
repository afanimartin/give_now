import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:give_now/utils/app_theme.dart';
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
  Widget build(BuildContext context) => _itemsGrid();

  Widget _itemsGrid() => SliverPadding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
        sliver: SliverGrid(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            final item = items[index];

            return _itemsStack(context, item);
          }, childCount: items?.length),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
        ),
      );

  Widget _itemsStack(BuildContext context, Item item) => Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ItemDetailScreen(item: item))),
              child: Image.asset(
                item.mainImageUrl,
                height: double.infinity,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
              height: double.infinity,
              width: 300,
              decoration: BoxDecoration(
                  gradient: postGradient,
                  borderRadius: BorderRadius.circular(12))),
          Positioned(
            left: 8,
            bottom: 8,
            child: Text(
              timeago.format(item.timestamp.toDate()),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<Item>('items', items));
    // ignore: cascade_invocations
  }
}
