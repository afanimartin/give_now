import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

///
class Category extends Equatable {
  ///
  const Category({@required this.categoryId, @required this.name});

  ///
  final String categoryId;

  ///
  final String name;

  @override
  List<Object> get props => [categoryId, name];
}
