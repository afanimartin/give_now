import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:give_now/models/app_tab/app_tab.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();
}

class UpdateTab extends TabEvent {
  final AppTab tab;

  const UpdateTab({@required this.tab});

  @override
  List<Object> get props => [tab];
}
