import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../helpers/repository/item_repository_helper.dart';

import '../../models/item/item.dart';
import '../../models/item/upload.dart';
import '../../utils/paths.dart';
import 'i_upload_repository.dart';

///
class UploadRepository extends IUploadRepository {
  final _firebaseFirestore = FirebaseFirestore.instance;

  ///
  @override
  Future<void> upload(Upload upload, List<File> urlsToUpload) async {
    final imageUrls = await getDownloadURL(urlsToUpload);

    final item = convertUploadToItem(upload, imageUrls);

    await _firebaseFirestore.collection(Paths.uploads).add(item.toDocument());
  }

  ///
  @override
  Future<void> update(Item item) async {
    await _firebaseFirestore
        .collection(Paths.uploads)
        .doc(item.id)
        .update(item.toDocument());
  }

  ///
  @override
  Future<void> delete(Item item) async {
    await _firebaseFirestore.collection(Paths.uploads).doc(item.id).delete();
  }

  @override
  Stream<List<Item>> uploads() =>
      _firebaseFirestore.collection(Paths.uploads).snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Item.fromSnapshot(doc)).toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt)));
}
