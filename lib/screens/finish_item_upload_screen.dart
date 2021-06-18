import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:give_now/widgets/progress_loader.dart';
import '../blocs/item/item_bloc.dart';
import '../blocs/item/item_state.dart';

///
class FinishItemUploadScreen extends StatefulWidget {
  ///
  const FinishItemUploadScreen({Key key}) : super(key: key);

  @override
  _FinishItemUploadScreenState createState() => _FinishItemUploadScreenState();
}

class _FinishItemUploadScreenState extends State<FinishItemUploadScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            'Finish item upload',
            style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                letterSpacing: 1),
          ),
          iconTheme: Theme.of(context).iconTheme,
        ),
        body: BlocBuilder<ItemBloc, ItemState>(
          builder: (context, state) {
            if (state is ImagesToUploadPicked) {
              return Center(
                child: Text(state.images.length.toString()),
              );
            }

            return const ProgressLoader();
          },
        ),
      );
}
