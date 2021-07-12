// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:multi_image_picker2/multi_image_picker2.dart';

// class PickImages extends StatefulWidget {
//   const PickImages({Key key}) : super(key: key);

//   @override
//   _PickImagesState createState() => _PickImagesState();
// }

// class _PickImagesState extends State<PickImages> {
//   List<Asset> images = [];
//   List files = [];
//   List<Asset> resultList = [];

//   @override
//   Widget build(BuildContext context) => Scaffold(body: _buildGridView());

//   Widget _buildGridView() {
//     if (images != null) {
//       return GridView.count(
//           crossAxisCount: 2,
//           children: List.generate(images.length, (index) {
//             final asset = images[index];
//             return Padding(
//               padding: const EdgeInsets.all(8),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(15)),
//                 child: AssetThumb(asset: asset, width: 300, height: 300),
//               ),
//             );
//           }));
//     } else {
//       return Container();
//     }
//   }

//   Future<void> _loadAssets() async {
//     String error = 'No error detected';

//     try {
//       resultList = await MultiImagePicker.pickImages(
//           maxImages: 4, selectedAssets: images);

//       for (var i = 0; i < images.length; i++) {
//         final path = File(images[i].identifier);

//         files.add(path);
//       }
//       print(files);
//     } on Exception catch (err) {
//       error = err.toString();
//     }

//     if (mounted) {
//       setState(() {
//         images = resultList;
//         error = error;
//       });
//     }
//   }
// }
