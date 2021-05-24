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
  Future<void> uploadImage(File imageToUpload, String userId) async {
    var uuid = Uuid();

    final snapshot = await _firebaseStorage
        .ref()
        .child("images/${uuid.v4()}")
        .putFile(imageToUpload);

    final imageUrl = await snapshot.ref.getDownloadURL();

    final image = ImageModel(
        id: uuid.v4(),
        userId: userId,
        mainImageUrl: imageUrl,
        timestamp: Timestamp.now(),
        otherImageUrls: [imageUrl]);

    await _firebaseFirestore.collection('uploads').add(image.toDocument());
  }

  @override
  Stream<List<ImageModel>> imageStream(String userId) =>
      _firebaseFirestore.collection('uploads').snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => ImageModel.fromSnapshot(doc)).toList()
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp)));
}
