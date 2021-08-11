import 'package:flutter_test/flutter_test.dart';

import '../mocks/data/item.dart';
import '../mocks/repository/item_repository_mock.dart';

void main() {
  ItemRepositoryMock? mockUploadRepository;

  setUp(() {
    mockUploadRepository = ItemRepositoryMock();
  });

  tearDown(() {
    mockUploadRepository?.clearCollection();
  });

  group('upload repository', () {
    test('uploads collection should be empty:length==0', () async {
      final uploads = await mockUploadRepository?.uploads();

      expect(uploads?.length, 0);
    });

    test('add one item:length==1', () async {
      await mockUploadRepository?.upload(itemOne);

      final uploads = await mockUploadRepository?.uploads();

      expect(uploads?.length, 1);
    });

    test('add item, delete item:length==0', () async {
      await mockUploadRepository?.upload(itemOne);

      final uploads = await mockUploadRepository?.uploads();

      expect(uploads?.length, 1);
      await mockUploadRepository?.delete(itemOne);

      expect(uploads!.length, 0);
    });

    test('add item, update item', () async {
      await mockUploadRepository?.upload(itemOne);

      final updatedItem = itemOne.copyWith(title: 'some updated title');

      await mockUploadRepository?.update(updatedItem);

      expect(mockedUploads[0].title, 'some updated title');
    });

    test('add items, clear uploads:length==0', () async {
      await mockUploadRepository?.upload(itemOne);
      await mockUploadRepository?.upload(itemTwo);

      mockUploadRepository?.clearCollection();
      expect(mockedUploads.length, 0);
    });
  });
}

