import 'dart:io';

import 'package:give_now/models/image/image_model.dart';

abstract class IImageRepository {
  Future<String> uploadImageToStorage(File imageToUpload, String userId);

  Future<void> uploadImageUrlsToFirestore(List<String> urlsToUpload, String userId);

  Stream<List<ImageModel>> imageStream(String userId);
}
