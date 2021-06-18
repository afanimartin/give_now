import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/item/item_bloc.dart';
import '../blocs/item/item_state.dart';

///
class FinishItemUploadWidget extends StatelessWidget {
  ///
  const FinishItemUploadWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocListener<ItemBloc, ItemState>(
        listener: (context, state) {},
        child: Align(
          alignment: const Alignment(0, -1),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [_TitleInput(), _DescriptionInput()],
            ),
          ),
        ),
      );
}

///
class _TitleInput extends StatelessWidget {
  ///
  const _TitleInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<ItemBloc, ItemState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) => TextField(
            maxLength: 140,
            onChanged: (title) => context.read<ItemBloc>().titleChanged(title),
            decoration: const InputDecoration(
                labelText: 'title', helperText: '', errorText: ''),
          ));
}

///
class _DescriptionInput extends StatelessWidget {
  ///
  const _DescriptionInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<ItemBloc, ItemState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) => TextField(
            maxLength: 500,
            onChanged: (title) =>
                context.read<ItemBloc>().descriptionChanged(title),
            decoration: const InputDecoration(
                labelText: 'description', helperText: '', errorText: ''),
          ));
}
