import 'dart:io';

import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

///
Future<List<Asset>> filesToUpload() async {
  final files = <File>[];

  ///
  var images = <Asset>[];

  await Permission.photos.request();

  final permissionStatus = await Permission.photos.status;

  final appDocDir = await getTemporaryDirectory();
  final appDocPath = appDocDir.path;

  if (permissionStatus.isGranted) {
    images =
        await MultiImagePicker.pickImages(maxImages: 6, selectedAssets: images);

    for (var i = 0; i < images.length; i++) {
      final byteData = await images[i].getByteData();

      final tempFile = File('$appDocPath/${images[i].name}');

      final file = await tempFile.writeAsBytes(byteData.buffer
          .asInt8List(byteData.offsetInBytes, byteData.lengthInBytes));

      files.add(file);
    }
  }

  return images;
}
