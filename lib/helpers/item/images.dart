import '../../models/item/item.dart';

///
List<String> images(Item item) {
  final _items = <String>[];

  for (var i = 0; i < item.otherImageUrls.length; i++) {
    _items.add(item.otherImageUrls[i] as String);
  }

  return _items;
}
