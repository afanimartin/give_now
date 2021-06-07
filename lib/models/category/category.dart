import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

///
class Category extends Equatable {
  ///
  const Category({@required this.categoryId, @required this.title});

  ///
  final String categoryId;

  ///
  final String title;

  @override
  List<Object> get props => [categoryId, title];
}
