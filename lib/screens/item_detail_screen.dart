import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../blocs/item/item_bloc.dart';
import '../blocs/item/item_state.dart';
import '../models/item/item_model.dart';
import '../widgets/floating_action_button.dart';
import '../widgets/progress_loader.dart';

///
class ItemDetailScreen extends StatelessWidget {
  ///
  ItemDetailScreen({@required this.item, Key key}) : super(key: key);

  ///
  final ItemModel item;

  ///
  final List<String> items = <String>[];

  @override
  Widget build(BuildContext context) {
    item.otherImageUrls.forEach((url) => items.add(url as String));

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          item.title,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          _PhotoViewWidget(items: items),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(item.description),
              Text(item.condition),
              Text(item.price.toString())
            ],
          )
        ],
      ),
      floatingActionButton: BlocBuilder<ItemBloc, ItemState>(
          builder: (context, state) => FloatingActionButtonWidget(
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  _confirmDonation(context, item);
                },
                child: state is ItemIsBeingDonated
                    ? const ProgressLoader()
                    : const Icon(FontAwesomeIcons.cartArrowDown),
              )),
    );
  }

  Future<bool> _confirmDonation(BuildContext context, ItemModel item) async =>
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text(
                  'Confirm donation',
                  style: TextStyle(fontSize: 22),
                ),
                content: const Text(
                    // ignore: lines_longer_than_80_chars
                    'Your donation will help the less privileged live a better life. Thank you!'),
                actions: [
                  TextButton(
                      onPressed: () {
                        context.read<ItemBloc>().donateItemToCharity(item);

                        Navigator.of(context).pop();
                      },
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
    properties.add(DiagnosticsProperty<ItemModel>('item', item));
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
            final item = items[index];

            return PhotoViewGalleryPageOptions.customChild(
              child: Image.asset(
                item,
                fit: BoxFit.cover,
              ),
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
                backgroundColor: Colors.greenAccent,
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
