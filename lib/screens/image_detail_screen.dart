import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:give_now/blocs/image/image_bloc.dart';
import 'package:give_now/blocs/image/image_state.dart';
import 'package:give_now/models/image/image_model.dart';
import 'package:give_now/widgets/floating_action_button.dart';
import 'package:give_now/widgets/progress_loader.dart';
import 'package:photo_view/photo_view_gallery.dart';

///
class ImageDetailScreen extends StatelessWidget {
  ///
  ImageDetailScreen({@required this.image, Key key}) : super(key: key);

  ///
  final ImageModel image;

  ///
  final List<String> images = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: BlocBuilder<ImageBloc, ImageState>(
          builder: (context, state) {
            if (state is ImagesUpdated) {
              state.currentUserImages.map((image) {
                image.otherImageUrls.map((img) => images);
              });
              return _PhotoViewWidget(images: images);
            }

            return const ProgressLoader();
          },
        ),
        floatingActionButton: BlocBuilder<ImageBloc, ImageState>(
            builder: (context, state) => FloatingActionButtonWidget(
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () {},
                  child: const Icon(FontAwesomeIcons.donate),
                )),
      );
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
}
