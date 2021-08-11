import 'dart:io';

import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';


/// pick images as Asset and convert to File for upload
Future<List<File>> imagesToUpload(List<Asset>? images) async {
  final files = <File>[];

  final appDocDir = await getTemporaryDirectory();
  final appDocPath = appDocDir.path;

  for (var i = 0; i < images!.length; i++) {
    final byteData = await images[i].getByteData();

    final tempFile = File('$appDocPath/${images[i].name}');

    final file = await tempFile.writeAsBytes(byteData.buffer
        .asInt8List(byteData.offsetInBytes, byteData.lengthInBytes));

    files.add(file);
  }
  return files;
}