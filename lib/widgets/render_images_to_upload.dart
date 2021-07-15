import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

import '../utils/constants.dart';
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
        crossAxisCount: Constants.two,
        children: List.generate(
          assets.length,
          (index) {
            final _asset = assets[index];
            return Padding(
              padding: const EdgeInsets.only(
                  left: Constants.elevation,
                  right: Constants.elevation,
                  top: Constants.elevation),
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.all(Radius.circular(Constants.five)),
                child: AssetThumb(
                  asset: _asset,
                  width: Constants.assetHeightWidth,
                  height: Constants.assetHeightWidth,
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
