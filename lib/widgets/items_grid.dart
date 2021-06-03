import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../models/image/item_model.dart';
import '../screens/item_detail_screen.dart';

///
class ItemsGrid extends StatelessWidget {
  ///
  const ItemsGrid({@required this.items, Key key}) : super(key: key);

  ///
  final List<ItemModel> items;

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
              crossAxisSpacing: 10,
              childAspectRatio: 0.8),
        ),
      );

  Widget _buildItemCard(BuildContext context, ItemModel item) =>
      GestureDetector(
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ItemDetailScreen(item: item))),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: item.mainImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(child: Text(timeago.format(item.timestamp.toDate())))
            ],
          ),
        ),
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<ItemModel>('items', items));
    // ignore: cascade_invocations
  }
}
