import 'package:flutter/material.dart';

import '../widgets/finish_item_upload_widget.dart';

///
class FinishItemUploadScreen extends StatefulWidget {
  ///
  const FinishItemUploadScreen({Key? key}) : super(key: key);

  @override
  _FinishItemUploadScreenState createState() => _FinishItemUploadScreenState();
}

class _FinishItemUploadScreenState extends State<FinishItemUploadScreen> {
  @override
  Widget build(BuildContext context) => const FinishItemUploadWidget();
}
