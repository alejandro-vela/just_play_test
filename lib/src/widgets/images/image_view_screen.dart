import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'custom_image.dart';

class ImageViewScreen extends StatelessWidget {
  static const String routeName = 'image_view_screen';
  final String image;
  final ImageType? type;
  const ImageViewScreen({
    Key? key,
    required this.image,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () => Navigator.of(context).pop(),
      isFullScreen: false,
      dragSensitivity: .4,
      maxTransformValue: 4,
      direction: DismissiblePageDismissDirection.vertical,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: InteractiveViewer(
            child: CustomImage(
              image: image,
              view: false,
              type: type,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
