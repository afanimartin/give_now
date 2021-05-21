import 'dart:io';

abstract class IImageRepository {
  Future<void> uploadImage(File imageToUpload, String userId);
}
