import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../blocs/item/item_bloc.dart';
import '../blocs/item/item_state.dart';
import '../models/image/item_model.dart';
import '../widgets/floating_action_button.dart';
import '../widgets/progress_loader.dart';

///
class ImageDetailScreen extends StatelessWidget {
  ///
  ImageDetailScreen({@required this.image, Key key}) : super(key: key);

  ///
  final ItemModel image;

  ///
  final List<String> images = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: BlocBuilder<ItemBloc, ItemState>(
          builder: (context, state) {
            if (state is ItemUpdated) {
              state.currentUserImages.forEach((image) {
                image.otherImageUrls.forEach((String img) => images.add(img));
              });
              return _PhotoViewWidget(images: images);
            }

            return const ProgressLoader();
          },
        ),
        floatingActionButton: BlocBuilder<ItemBloc, ItemState>(
            builder: (context, state) => FloatingActionButtonWidget(
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () {},
                  child: const Icon(FontAwesomeIcons.donate),
                )),
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ItemModel>('image', image));
    // ignore: cascade_invocations
    properties.add(IterableProperty<String>('images', images));
  }
}

class _PhotoViewWidget extends StatelessWidget {
  ///
  const _PhotoViewWidget({@required this.images, Key key}) : super(key: key);
  final List<String> images;

  @override
  Widget build(BuildContext context) => Container(
        height: 350,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: PhotoViewGallery.builder(
          itemCount: images.length,
          builder: (context, index) {
            final image = images[index];

            return PhotoViewGalleryPageOptions.customChild(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                ),
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
    properties.add(IterableProperty<String>('images', images));
  }
}
