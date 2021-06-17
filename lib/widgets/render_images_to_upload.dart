import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

import 'progress_loader.dart';

///
class RenderImagesToUpload extends StatelessWidget {
  ///
  const RenderImagesToUpload({@required this.assets, Key key})
      : super(key: key);

  ///
  final List<Asset> assets;

  @override
  Widget build(BuildContext context) => GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          assets.length,
          (index) {
            final _asset = assets[index];
            return Padding(
              padding: const EdgeInsets.only(left: 4, right: 4, top: 4),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: AssetThumb(
                  asset: _asset,
                  width: 300,
                  height: 300,
                  spinner: const ProgressLoader(),
                ),
              ),
            );
          },
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<List<Asset>>('assets', assets));
  }
}
