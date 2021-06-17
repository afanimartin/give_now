import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/item/item_bloc.dart';
import '../blocs/item/item_state.dart';
import '../widgets/progress_loader.dart';
import '../widgets/render_images_to_upload.dart';

///
class ItemPreviewScreen extends StatefulWidget {
  ///
  const ItemPreviewScreen({Key key}) : super(key: key);

  @override
  _ItemPreviewScreenState createState() => _ItemPreviewScreenState();
}

class _ItemPreviewScreenState extends State<ItemPreviewScreen> {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ItemBloc, ItemState>(builder: (context, state) {
        if (state is ImagesToUploadPicked) {
          return RenderImagesToUpload(
            images: state.images,
          );
        }

        return const ProgressLoader();
      });
}
