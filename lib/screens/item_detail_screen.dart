import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../blocs/item/item_cubit.dart';
import '../blocs/item/item_state.dart';
import '../helpers/item/images.dart';
import '../models/item/item.dart';
import '../utils/constants.dart';
import '../widgets/floating_action_button.dart';
import '../widgets/progress_loader.dart';
import 'marketplace_screen.dart';

///
class ItemDetailScreen extends StatelessWidget {
  ///
  const ItemDetailScreen({required this.item, Key? key}) : super(key: key);

  ///
  final Item item;

  @override
  Widget build(BuildContext context) {
    final _images = images(item);

    return BlocBuilder<ItemCubit, ItemState>(
        builder: (context, state) => Scaffold(
            backgroundColor: Theme.of(context).accentColor,
            appBar: AppBar(
              elevation: 0,
              title: Text(
                item.title ?? '',
                style: Theme.of(context).textTheme.headline5,
              ),
              backgroundColor: Theme.of(context).accentColor,
              iconTheme: Theme.of(context).iconTheme,
            ),
            body: state is ItemsLoaded
                ? Column(
                    children: [
                      _PhotoViewWidget(items: _images),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title ?? '',
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: Constants.onePointTwo),
                          ),
                          Text(item.description ?? ''),
                          Text(item.condition ?? ''),
                          Text(item.price.toString()),
                          Text(item.category ?? '')
                        ],
                      ),
                    ],
                  )
                : const ProgressLoader(),
            floatingActionButton: FloatingActionButtonWidget(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                context.read<ItemCubit>().addItemToCart(item);

                Navigator.of(context).pop();
              },
              child: const Icon(Icons.shopping_bag_outlined),
            )));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Item>('item', item));
  }
}

class _PhotoViewWidget extends StatelessWidget {
  ///
  const _PhotoViewWidget({required this.items, Key? key}) : super(key: key);
  final List<String> items;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: Constants.threeHundred,
        child: PhotoViewGallery.builder(
          itemCount: items.length,
          builder: (context, index) {
            final url = items[index];

            return PhotoViewGalleryPageOptions.customChild(
              child: items.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: url,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink(),
            );
          },
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          enableRotation: true,
          loadingBuilder: (context, event) => Center(
            child: SizedBox(
              width: Constants.iconButtonSize,
              height: Constants.iconButtonSize,
              child: ProgressLoader(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
              ),
            ),
          ),
        ),
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<String>('items', items));
  }
}
