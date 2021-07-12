import 'package:flutter/material.dart';

import '../widgets/finish_item_upload_widget.dart';

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
              color: Theme.of(context).primaryColorDark, letterSpacing: 1),
        ),
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: FinishItemUploadWidget(),
      ));
}
