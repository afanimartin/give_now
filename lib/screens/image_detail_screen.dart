import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:give_now/blocs/image/image_bloc.dart';
import 'package:give_now/blocs/image/image_state.dart';
import 'package:give_now/models/image/image_model.dart';
import 'package:give_now/widgets/progress_loader.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageDetailScreen extends StatelessWidget {
  final ImageModel image;

  ImageDetailScreen({@required this.image, Key key}) : super(key: key);

  final List<String> images = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: BlocBuilder<ImageBloc, ImageState>(
          builder: (context, state) {
            if (state is ImagesUpdated) {
              state.currentUserImages.forEach((image) {
                image.otherImageUrls.forEach((img) {
                  images.add(img);
                });
              });
              return _PhotoViewWidget(images: images);
            }

            return const ProgressLoader();
          },
        ),
      );
}

class _PhotoViewWidget extends StatelessWidget {
  final List<String> images;
  const _PhotoViewWidget({@required this.images, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: PhotoViewGallery.builder(
          itemCount: images.length,
          builder: (context, index) {
            final image = images[index];

            return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(image),
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.contained * 2);
          },
          scrollPhysics: BouncingScrollPhysics(),
          backgroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          enableRotation: true,
          loadingBuilder: (context, event) => Center(
            child: Container(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes,
              ),
            ),
          ),
        ),
      );
}
