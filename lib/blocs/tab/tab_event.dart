import 'package:equatable/equatable.dart';
import '../../models/app_tab/app_tab.dart';

///
abstract class TabEvent extends Equatable {
  ///
  const TabEvent();
}

///
class UpdateTab extends TabEvent {
  ///
  const UpdateTab({required this.tab});

  ///
  final AppTab tab;

  @override
  List<Object> get props => [tab];
}
