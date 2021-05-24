import 'dart:io';

import 'package:give_now/models/image/image_model.dart';

abstract class IImageRepository {
  Future<void> uploadImage(File imageToUpload, String userId);

  Stream<List<ImageModel>> imageStream(String userId);
}
