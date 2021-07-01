import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:give_now/blocs/cart/cart_event.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../blocs/cart/cart_bloc.dart';
import '../models/item/item.dart';
import '../widgets/floating_action_button.dart';

///
class ItemDetailScreen extends StatelessWidget {
  ///
  ItemDetailScreen({@required this.item, Key key}) : super(key: key);

  ///
  final Item item;

  ///
  final List<String> items = <String>[];

  @override
  Widget build(BuildContext context) {
    item.otherImageUrls.forEach((url) => items.add(url as String));

    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            item.title ?? '',
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          ),
          backgroundColor: Theme.of(context).accentColor,
          iconTheme: Theme.of(context).iconTheme,
        ),
        body: Column(
          children: [
            _PhotoViewWidget(items: items),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title ?? '',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(item.description ?? ''),
                Text(item.condition ?? ''),
                Text(item.price.toString() ?? ''),
                Text(item.category ?? '')
              ],
            )
          ],
        ),
        floatingActionButton: FloatingActionButtonWidget(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            context.read<CartBloc>().add(AddItemToCart(cartItem: item));
          },
          child: const Icon(Icons.shopping_bag_outlined),
        ));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Item>('item', item));
    // ignore: cascade_invocations
    properties.add(IterableProperty<String>('items', items));
  }
}

class _PhotoViewWidget extends StatelessWidget {
  ///
  const _PhotoViewWidget({@required this.items, Key key}) : super(key: key);
  final List<String> items;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 300,
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
                  : Image.asset('assets/placeholder-image.png'),
            );
          },
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          enableRotation: true,
          loadingBuilder: (context, event) => Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColorDark,
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes,
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
