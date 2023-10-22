import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../services/navigation_service.dart';
import 'image_view_screen.dart';

enum ImageType { file, network }

const noImage = 'assets/static/img/no-image.png';
const jarLoading = 'assets/static/img/jar-loading.gif';

class CustomImage extends StatelessWidget {
  final String image;
  final bool? view;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final Color? color;
  final double? borderRadius;
  final ImageType? type;
  const CustomImage({
    Key? key,
    required this.image,
    this.view,
    this.fit,
    this.height,
    this.width,
    this.color,
    this.borderRadius,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: view == true
            ? () => NavigationService.push(
                context: context,
                screen: ImageViewScreen(image: image, type: type),
                routeName: ImageViewScreen.routeName)
            : null,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          child: SizedBox(
            height: height,
            width: width,
            child: type == ImageType.file
                ? _ImageFile(
                    image,
                    height,
                    width,
                    fit,
                  )
                : image.startsWith('assets/')
                    ? _ImageAsset(
                        image,
                        height,
                        width,
                        fit,
                        color,
                      )
                    : _ImageNetwork(
                        image,
                        height,
                        width,
                        fit,
                        color,
                      ),
          ),
        ),
      );
}

class _ImageAsset extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;
  const _ImageAsset(this.image, this.height, this.width, this.fit, this.color);

  @override
  Widget build(BuildContext context) {
    return image.contains('.svg')
        ? SvgPicture.asset(
            image,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
          )
        : Image.asset(
            image,
            color: color,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                noImage,
                height: height,
                width: width,
                fit: fit ?? BoxFit.cover,
              );
            },
          );
  }
}

class _ImageFile extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  const _ImageFile(
    this.image,
    this.height,
    this.width,
    this.fit,
  );

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(image),
      fit: fit ?? BoxFit.cover,
      height: height,
      width: width,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          noImage,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
        );
      },
    );
  }
}

class _ImageNetwork extends StatelessWidget {
  final String image;

  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;
  const _ImageNetwork(
    this.image,
    this.height,
    this.width,
    this.fit,
    this.color,
  );

  @override
  Widget build(BuildContext context) {
    if (image.contains('.svg')) {
      return SvgPicture.network(
        image,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        placeholderBuilder: (BuildContext context) => Image.asset(
          jarLoading,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
        ),
      );
    }
    return FadeInImage(
      placeholder: AssetImage(
        jarLoading,
      ),
      image: NetworkImage(image),
      imageErrorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Image.asset(
          noImage,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          filterQuality: FilterQuality.medium,
        );
      },
      fit: fit ?? BoxFit.cover,
    );
  }
}
