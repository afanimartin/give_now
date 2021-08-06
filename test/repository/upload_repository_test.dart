import 'package:flutter_test/flutter_test.dart';

import '../mocks/data/item.dart';
import '../mocks/repository/upload_repository_mock.dart';

void main() {
  UploadRepositoryMock? mockUplodRepository;

  setUp(() {
    mockUplodRepository = UploadRepositoryMock();
  });

  test('add', () {
    mockUplodRepository?.add(itemOne);
  });

  group('uploads', () {
    test('length of snapshot should be 0', () async {
      final snapshot = await mockUplodRepository?.uploads();

      expect(snapshot?.length, 0);
    });

    test('length list should be 1', () async {
      mockUplodRepository?.add(itemOne);

      final snapshot = await mockUplodRepository?.uploads();

      expect(snapshot?.length, 1);
    });

    test('add one item, delete one item, length should be 0', () async {
      mockUplodRepository?.add(itemOne);

      final snapshot = await mockUplodRepository?.uploads();

      expect(snapshot?.length, 1);

      for (var i = 0; i < snapshot!.length; i++) {
        if (itemOne.id == snapshot[i]['id']) {
          snapshot.remove(snapshot[i]);
        }
      }

      expect(snapshot.length, 0);
    });

    test('add two items, delete one item, length should be 1', () async {
      mockUplodRepository?.add(itemOne);
      mockUplodRepository?.add(itemTwo);

      final snapshot = await mockUplodRepository?.uploads();

      expect(snapshot?.length, 2);

      for (var i = 0; i < snapshot!.length; i++) {
        if (itemOne.id == snapshot[i]['id']) {
          snapshot.remove(snapshot[i]);
        }
      }

      expect(snapshot.length, 1);
    });
  });
}
