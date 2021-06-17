import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///
class RenderImagesToUpload extends StatelessWidget {
  ///
  const RenderImagesToUpload({@required this.images, Key key})
      : super(key: key);

  ///
  final List<File> images;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(),
        body: Container(
          height: 500,
          color: Colors.white,
          child: ListView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                final _image = images[index];

                return Image.file(
                  _image,
                  height: 100,
                  width: 50,
                );
              }),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<List<File>>('images', images));
  }
}
