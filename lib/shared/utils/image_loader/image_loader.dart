import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:lottie/lottie.dart';

class ImageLoader {
  // Lotte Asset
  static Widget assetLottie({
    String? imagePath,
    FrameRate? frameRate,
    FilterQuality? filterQuality,
    double? height,
    double? width,
    bool? wantScale = false,
    double? scale,
  }) {
    if (imagePath != null) {
      return wantScale == true
          ? Transform.scale(
              scale: scale,
              child: Lottie.asset(imagePath,
                  frameRate: frameRate,
                  filterQuality: filterQuality,
                  height: height,
                  width: width),
            )
          : Lottie.asset(imagePath,
              frameRate: frameRate,
              filterQuality: filterQuality,
              height: height,
              width: width);
    }

    return Container();
  }

  // Network Lottie
  static Widget networkLottie(
      {String? imagePath,
      FrameRate? frameRate,
      FilterQuality? filterQuality,
      double? height,
      double? width}) {
    if (imagePath != null) {
      return Lottie.network(imagePath,
          frameRate: frameRate,
          filterQuality: filterQuality,
          height: height,
          width: width);
    }

    return Container();
  }

  //Image Asset
  static Widget assetImage(
      {String? imagePath,
      Color? loaderColor,
      double? width,
      double? height,
      double? scale,
      Color? color,
      BoxFit? fit,
      bool? wantsScale = false}) {
    if (imagePath != null) {
      return wantsScale == true
          ? Transform.scale(
              scale: scale,
              child: Image.asset(
                fit: fit,
                imagePath,
                width: width,
                height: height,
                color: loaderColor,
              ))
          : Image.asset(
              imagePath,
              fit: fit,
              width: width,
              height: height,
              color: loaderColor,
            );
    }

    return Container();
  }

  static Widget file(
      {String? imagePath,
      double? width,
      double? height,
      double? scale,
      BoxFit? fit,
      bool? wantsScale = false}) {
    if (imagePath != null) {
      return Image.file(
        File(imagePath),
        fit: fit,
        width: width,
        height: height,
      );
    }

    return Container();
  }

  //Image Network

  static Widget networkAssetImage(
      {String? imagePath,
      double? width,
      double? height,
      double? scale,
      BoxFit? fit,
      bool? wantsScale = false}) {
    if (imagePath != null) {
      return wantsScale == true
          ? Transform.scale(
              scale: scale,
              child: Image.network(
                imagePath,
                width: width,
                height: height,
                fit: fit,
              ))
          : Image.network(
              imagePath,
              width: width,
              height: height,
              fit: fit,
            );
    }

    return Container();
  }
  //
  // static Widget cachedNetworkImage(
  //     {String? imagePath,
  //     double? width,
  //     double? height,
  //     Color? color,
  //     double? scale,
  //     BoxFit? fit,
  //     bool? wantsScale = false}) {
  //   if (imagePath != null) {
  //     return Transform.scale(
  //       scale: wantsScale == true ? scale : 1,
  //       child: CachedNetworkImage(
  //         width: width != null ? width * SizeConfig.widthMultiplier! : null,
  //         height: height != null ? height * SizeConfig.heightMultiplier! : null,
  //         color: color,
  //         imageUrl: imagePath,
  //         fit: fit,
  //       ),
  //     );
  //   }
  //
  //   return Container();
  // }

  static ImageProvider svgImageProvider(
      {required String imagePath,
      double? scale,
      Size? size,
      Color? color,
      svg_provider.SvgSource? source}) {
    return svg_provider.Svg(imagePath,
        scale: scale,
        size: size,
        color: color,
        source: source ?? svg_provider.SvgSource.asset);
  }

  static ImageProvider networkImageProvider({
    required String imagePath,
    double? scale,
    Color? color,
  }) {
    return Image.network(
      imagePath,
      color: color,
    ).image;
  }

  static ImageProvider networkImage({
    required String imagePath,
    double? scale,
    Color? color,
  }) {
    return NetworkImage(
      imagePath,
      scale: scale ?? 1,
    );
  }

  static ImageProvider svgNetworkImageProvider(
      {required String imagePath,
      double? scale,
      Size? size,
      Color? color,
      svg_provider.SvgSource? source}) {
    return svg_provider.Svg(imagePath,
        scale: scale,
        size: size,
        color: color,
        source: source ?? svg_provider.SvgSource.network);
  }

//Svg Picture asset
  static Widget svgPictureAssetImage(
      {String? imagePath,
      double? width,
      double? height,
      Color? color,
      double? scale,
      bool? wantsScale = false}) {
    if (imagePath != null) {
      return wantsScale == true
          ? Transform.scale(
              scale: scale,
              child: SvgPicture.asset(
                imagePath,
                width: width,
                height: height,
                color: color,
              ),
            )
          : SvgPicture.asset(
              imagePath,
              width: width,
              height: height,
              color: color,
            );
    }

    return Container();
  }

  static Widget svgPictureNetworkAssetImage(
      {String? imagePath,
      double? width,
      double? height,
      Color? color,
      double? scale,
      bool? wantsScale = false}) {
    if (imagePath != null) {
      return wantsScale == true
          ? Transform.scale(
              scale: scale,
              child: SvgPicture.network(
                imagePath,
                width: width,
                height: height,
                color: color,
              ),
            )
          : SvgPicture.network(
              imagePath,
              width: width,
              height: height,
              color: color,
            );
    }

    return Container();
  }
}
