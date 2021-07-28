import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

///
final firebaseStorage = FirebaseStorage.instance;

///
Future<List<String>> getDownloadURL(List<File> images) async {
  ///
  final imageUrls = <String>[];

  ///
  const uuid = Uuid();

  for (var i = 0; i < images.length; i++) {
    final _ref = await firebaseStorage
        .ref()
        .child('images/${uuid.v4()}')
        .putFile(images[i]);

    final _url = await _ref.ref.getDownloadURL();
    imageUrls.add(_url);
  }

  return imageUrls;
}
