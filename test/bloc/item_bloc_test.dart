import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moostamil/utils/paths.dart';

void main() async {
  final instance = FakeFirebaseFirestore();
  final data = <String, dynamic>{'title': 'brand new iPhone'};

  await instance.collection(Paths.uploads).add(data);

  final snapshot = await instance.collection(Paths.uploads).get();

  group('Test firestore', () {
    test('expect length of uploads to be 1', () {
      expect(snapshot.docs.length, 1);
    });
  });
}
