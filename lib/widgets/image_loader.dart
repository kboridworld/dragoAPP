import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/pages/login/user_model.dart';
import 'package:dragoma/utils/platform_utils.dart';
import 'package:flutter/material.dart';
import 'package:lib_ylz_ui_kit_package/ProgressHUD/spin_kit_ring.dart';
import 'package:lib_ylz_utils_package/lib_ylz_utils_package.dart';

/// 图片加载组件：支持本地图片和网络图片
class ImageLoader extends StatelessWidget {
  ImageLoader(this.name,
      {Key? key,
      this.width,
      this.height,
      this.fit,
      this.format = 'png',
      this.placeholderPath = 'userCenter/icon_login_logo',
      this.color,
      this.needToken = true,
      this.scaleToWidth})
      : super(key: key);

  final String name;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String format;
  final String placeholderPath;
  final Color? color;
  final bool needToken;
  final int? scaleToWidth;

  @override
  Widget build(BuildContext context) {
    if (this.name.isTextEmpty) {
      return AssetImageLoader(
        placeholderPath,
        height: height,
        width: width,
        fit: fit,
        format: format,
        color: color,
      );
    }
    if (name.startsWith('http')) {
      String url = _imageURL;
      if (!url.isTextEmpty && scaleToWidth != null) {
        url =
            '$url${url.contains('?') ? '&' : '?'}x-oss-process=image/resize,h_$scaleToWidth,m_lfit';
      }
      return CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) => Container(
          color: ColorValues.background,
          child: SpinKitRing(
            size: 25,
            lineWidth: 3,
            color: Colors.white,
          ),
        ),
        errorWidget: (context, url, error) => AssetImageLoader(
          placeholderPath,
          height: height,
          width: width,
          fit: fit,
          color: color,
        ),
        width: width,
        height: height,
        fit: fit,
      );
    }
    if (name.startsWith("file:")) {
      return Image.file(
        File(name.replaceFirst("file:", "")),
        width: width,
        height: height,
        fit: fit,
        color: color,
      );
    }

    return AssetImageLoader(
      name,
      width: width,
      height: height,
      fit: fit,
      format: format,
      color: color,
    );
  }

  String get _imageURL {
    if (!needToken) return name;

    bool isFirstParam = !name.contains('?');

    return name +
        (isFirstParam ? '?' : '&') +
        'token=${UserModel.shareInstance.token}';
  }
}

class AssetImageLoader extends StatelessWidget {
  AssetImageLoader(this.name,
      {Key? key,
      this.width,
      this.height,
      this.cacheHeight,
      this.cacheWidth,
      this.fit,
      this.format = 'png',
      this.color})
      : super(key: key);
  final String name;
  final double? width;
  final double? height;
  final int? cacheWidth;
  final int? cacheHeight;
  final BoxFit? fit;
  final String format;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageUtils.getImagePath(name, format: format),
      width: width,
      height: height,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      fit: fit,
      color: color,
    );
  }
}

class ImageUtils {
  static ImageProvider getAssetImage(String name, {String format = 'png'}) {
    return AssetImage(getImagePath(name, format: format));
  }

  static String getImagePath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }
}
