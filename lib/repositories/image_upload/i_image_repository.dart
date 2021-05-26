import 'dart:io';

import 'package:give_now/models/image/image_model.dart';

abstract class IImageRepository {
  Future<List<String>> uploadImageToStorage(List<File> images, String userId);

  Future<void> uploadImageUrlsToFirestore(List<File> urlsToUpload, String userId);

  Stream<List<ImageModel>> imageStream(String userId);
}
