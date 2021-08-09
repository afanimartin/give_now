import 'package:flutter_test/flutter_test.dart';

import '../mocks/data/item.dart';
import '../mocks/repository/upload_repository_mock.dart';

void main() {
  UploadRepositoryMock? mockUplodRepository;

  setUp(() {
    mockUplodRepository = UploadRepositoryMock();
  });

  tearDown(() async {
    final uploads = await mockUplodRepository?.uploads();
    mockUplodRepository?.clearCollection(uploads);
  });

  group('uploads', () {
    test('uploads collection should be empty:length==0', () async {
      final uploads = await mockUplodRepository?.uploads();

      expect(uploads?.length, 0);
    });

    test('add one item:length==1', () async {
      mockUplodRepository?.add(itemOne);

      final uploads = await mockUplodRepository?.uploads();

      expect(uploads?.length, 1);
    });

    test('add two items, delete one item:length==1', () async {
      mockUplodRepository?.add(itemOne);
      mockUplodRepository?.add(itemTwo);

      final uploads = await mockUplodRepository?.uploads();

      expect(uploads?.length, 2);

      final _fetchedItem = _fetchItem(uploads, itemOne);

      mockUplodRepository?.delete(uploads, _fetchedItem);

      expect(uploads?.length, 1);
    });

    test('add one item:length==1, delete one item:length==0', () async {
      mockUplodRepository?.add(itemOne);

      final uploads = await mockUplodRepository?.uploads();

      expect(uploads?.length, 1);

      for (var i = 0; i < uploads!.length; i++) {
        if (itemOne['id'] == uploads[i]['id']) {
          uploads.remove(uploads[i]);
        }
      }

      expect(uploads.length, 0);
    });

    test('add item, update item', () async {
      mockUplodRepository?.add(itemOne);

      final uploads = await mockUplodRepository?.uploads();

      expect(uploads?.length, 1);

      final _fetchedItem = _fetchItem(uploads, itemOne);
      _fetchedItem['title'] = 'some updated title';

      mockUplodRepository?.update(_fetchedItem);

      expect(uploads?[0]['title'], 'some updated title');
    });

    test('add items, clear uploads:length==0', () async {
      mockUplodRepository?.add(itemOne);
      mockUplodRepository?.add(itemTwo);

      final uploads = await mockUplodRepository?.uploads();

      mockUplodRepository?.clearCollection(uploads);
      expect(uploads?.length, 0);
    });
  });
}

Map<String, dynamic> _fetchItem(
    List<Map<String, dynamic>>? uploads, Map<String, dynamic> item) {
  var _item = <String, dynamic>{};

  for (var i = 0; i < uploads!.length; i++) {
    if (item['id'] == uploads[i]['id']) {
      _item = uploads[i];
    }
  }

  return _item;
}
