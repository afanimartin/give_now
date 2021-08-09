import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:moostamil/utils/paths.dart';

class UploadRepositoryMock {
  final _fakeFirebaseFirestore = FakeFirebaseFirestore();

  ///
  void add(Map<String, dynamic> item) {
    _fakeFirebaseFirestore.collection(Paths.uploads).add(item);
  }

  ///
  void update(Map<String, dynamic> item) {
    _fakeFirebaseFirestore
        .collection(Paths.uploads)
        .doc(item['id'] as String)
        .update(item);
  }

  void delete(List<Map<String, dynamic>>? uploads, Map<String, dynamic> item) {
    uploads?.remove(item);
  }

  Future<List<Map<String, dynamic>>> uploads() async {
    final data = await _fakeFirebaseFirestore.collection(Paths.uploads).get();
    return data.docs.map((doc) => doc.data()).toList();
  }
}
