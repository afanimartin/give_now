import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///
class CircleAvatarWidget extends StatelessWidget {
  ///
  const CircleAvatarWidget(
      {@required this.radius, @required this.imageUrl, Key key})
      : super(key: key);

  ///
  final double radius;

  ///
  final String imageUrl;

  @override
  Widget build(BuildContext context) => CircleAvatar(
      radius: radius, backgroundImage: CachedNetworkImageProvider(imageUrl));
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('radius', radius));
    // ignore: cascade_invocations
    properties.add(StringProperty('imageUrl', imageUrl));
  }
}
