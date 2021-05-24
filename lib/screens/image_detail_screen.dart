import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:give_now/models/image/image_model.dart';

class ImageDetailScreen extends StatelessWidget {
  final ImageModel image;

  const ImageDetailScreen({@required this.image, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: image.mainImageUrl,
              ),
            ),
          ],
        ),
      );
}
