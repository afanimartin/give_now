import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:give_now/models/image/image_model.dart';
import 'package:give_now/repositories/image_upload/i_image_repository.dart';
import 'package:uuid/uuid.dart';

class ImageRepository extends IImageRepository {
  final _firebaseStorage = FirebaseStorage.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<String> uploadImageToStorage(File imageToUpload, String userId) async {
    final uuid = Uuid();
    final imageUrls = [];

    final snapshot = await _firebaseStorage
        .ref()
        .child("images/${imageToUpload.path}")
        .putFile(imageToUpload);

    final url = await snapshot.ref.getDownloadURL();
    imageUrls.add(url);

    final image = ImageModel(
        id: uuid.v4(),
        userId: userId,
        mainImageUrl: imageUrls[0],
        timestamp: Timestamp.now(),
        otherImageUrls: imageUrls.sublist(1));

    await _firebaseFirestore.collection('uploads').add(image.toDocument());

    return url;
  }

  Future<void> uploadImages(List<File> images, String userId) async {
    final uuid = Uuid();
    List<String> imageUrls = [];

    for (int i = 0; i < images.length; i++) {
      final _ref = await _firebaseStorage
          .ref()
          .child("images/${uuid.v4()}")
          .putFile(images[i]);

      final _url = await _ref.ref.getDownloadURL();
      imageUrls.add(_url);
    }

    if (imageUrls.isNotEmpty) {
      final image = ImageModel(
          id: uuid.v4(),
          userId: userId,
          mainImageUrl: imageUrls[0],
          timestamp: Timestamp.now(),
          otherImageUrls: imageUrls.sublist(1));

      await _firebaseFirestore.collection('uploads').add(image.toDocument());
    } else {
      print("Urls list is empty");
    }
  }

  @override
  Future<void> uploadImageUrlsToFirestore(
      List<String> urlsToUpload, String userId) async {
    // final uuid = Uuid();

    // final List<String> imageUrls = [];

    // for (var i = 0; i < urlsToUpload.length; i++) {
    //   final str = await uploadImageToStorage(urlsToUpload[i]);
    //   imageUrls.add(str);
    // }

    // final image = ImageModel(
    //     id: uuid.v4(),
    //     userId: userId,
    //     mainImageUrl: imageUrls[0],
    //     timestamp: Timestamp.now(),
    //     otherImageUrls: imageUrls.sublist(1));

    // await _firebaseFirestore.collection('uploads').add(image.toDocument());
  }

  @override
  Stream<List<ImageModel>> imageStream(String userId) =>
      _firebaseFirestore.collection('uploads').snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => ImageModel.fromSnapshot(doc)).toList()
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp)));
}
