import 'package:flutter_test/flutter_test.dart';

import '../mocks/data/item.dart';
import '../mocks/repository/upload_repository_mock.dart';

void main() {
  UploadRepositoryMock? mockUplodRepository;

  setUp(() {
    mockUplodRepository = UploadRepositoryMock();
  });

  test('add', () {
    mockUplodRepository?.add(item);
  });

  group('uploads', () {
    test('length list should be 0', () async {
      final snapshot = await mockUplodRepository?.uploads();

      expect(snapshot?.length, 0);
    });

    test('length list should be 1', () async {
      mockUplodRepository?.add(item);

      final snapshot = await mockUplodRepository?.uploads();

      expect(snapshot?.length, 1);
    });

    test('add, delete, length should be 0', () async {
      mockUplodRepository?.add(item);

      final snapshot = await mockUplodRepository?.uploads();

      expect(snapshot?.length, 1);

      for (var i = 0; i < snapshot!.length; i++) {
        if (item.id == snapshot[i]['id']) {
          snapshot.remove(snapshot[i]);
        }
      }

      expect(snapshot.length, 0);
    });
  });
}
