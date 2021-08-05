import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:moostamil/models/item/item.dart';
import 'package:moostamil/utils/paths.dart';

class UploadRepositoryMock {
  final _fakeFirebaseFirestore = FakeFirebaseFirestore();

  ///
  void add(Item item) {
    _fakeFirebaseFirestore.collection(Paths.uploads).add(item.toDocument());
  }

  void delete(Item item) async {
    final snapshot = await uploads();

    for (var i = 0; i < snapshot.length; i++) {
        if(item.id == snapshot[i]['id']) {
          snapshot.remove(snapshot[i]);
        }
      }
  }

  Future<List<Map<String, dynamic>>> uploads() async {
    final data = await _fakeFirebaseFirestore.collection(Paths.uploads).get();
    return data.docs.map((doc) => doc.data()).toList();
  }
}
