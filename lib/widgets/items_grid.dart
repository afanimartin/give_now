import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/item/item.dart';
import '../screens/item_detail_screen.dart';
import '../utils/app_theme.dart';
import '../utils/constants.dart';
import 'circular_avatar_widget.dart';

///
class ItemsGrid extends StatelessWidget {
  ///
  const ItemsGrid({required this.items, Key? key}) : super(key: key);

  ///
  final List<Item> items;

  @override
  Widget build(BuildContext context) => _itemsGrid();

  Widget _itemsGrid() => SliverPadding(
        padding: const EdgeInsets.only(
            left: Constants.ten,
            right: Constants.ten,
            bottom: Constants.fourty),
        sliver: SliverGrid(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            final item = items[index];

            return _itemsStack(context, item);
          }, childCount: items.length),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: Constants.maxCrossAxisExtent,
              mainAxisSpacing: Constants.ten,
              crossAxisSpacing: Constants.ten),
        ),
      );

  Widget _itemsStack(BuildContext context, Item item) => Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Constants.circularBorderRadius),
            child: CachedNetworkImage(
              imageUrl: item.mainImageUrl!,
              height: double.infinity,
              width: Constants.threeHundred,
              fit: BoxFit.cover,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute<Widget>(
                builder: (_) => ItemDetailScreen(item: item))),
            child: Container(
                height: double.infinity,
                width: Constants.threeHundred,
                decoration: BoxDecoration(
                    gradient: postGradient,
                    borderRadius:
                        BorderRadius.circular(Constants.circularBorderRadius))),
          ),
          Positioned(
            left: Constants.eight,
            bottom: Constants.eight,
            child: Row(
              children: [
                CircleAvatarWidget(imageUrl: item.sellerPhotoUrl),
                const SizedBox(
                  width: Constants.ten,
                ),
                Text(
                  item.title!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorLight),
                ),
              ],
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
