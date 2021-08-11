import 'package:moostamil/models/item/item.dart';

abstract class ItemStateMock {}

class ItemInitialState extends ItemStateMock {}

class ItemsLoaded extends ItemStateMock {
  ItemsLoaded({required this.items});

  final List<Item>? items;
}
