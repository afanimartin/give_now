import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/upload/upload_bloc.dart';
import '../blocs/upload/upload_event.dart';
import '../blocs/upload/upload_state.dart';
import '../models/item/item.dart';
import '../screens/user_profile_screen.dart';

///
class SubmitButtonWidget extends StatelessWidget {
  ///
  const SubmitButtonWidget({@required this.item, Key key}) : super(key: key);

  ///
  final Item item;

  @override
  Widget build(BuildContext context) => BlocBuilder<UploadBloc, UploadState>(
        builder: (context, state) => TextButton(
            onPressed: () {
              context.read<UploadBloc>().add(UploadItem(item: item));

              Navigator.of(context).pushAndRemoveUntil<void>(
                  UserProfileScreen.route, (route) => false);
            },
            child: const Text('Upload')),
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Item>('item', item));
  }
}
