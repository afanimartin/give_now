import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:give_now/screens/finish_item_upload_screen.dart';

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
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Preview images to upload',
            style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                letterSpacing: 1),
          ),
          backgroundColor: Theme.of(context).accentColor,
          iconTheme: Theme.of(context).iconTheme,
        ),
        body: BlocBuilder<ItemBloc, ItemState>(builder: (context, state) {
          if (state is ImagesToUploadPicked) {
            return state.images.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                          child: RenderImagesToUpload(assets: state.images)),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 30,
                            ),
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const FinishItemUploadScreen()))),
                      )
                    ],
                  )
                : const Center(
                    child: Text('No images to preview. Add Images'),
                  );
          }

          return const ProgressLoader();
        }),
      );
}
