import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/src/styles/sc_colors.dart';

/// 常用图片组件

class SCImage extends StatelessWidget {
  SCImage(
      {Key? key,
      required this.url,
      this.package,
      this.placeholder,
      this.width,
      this.height,
      this.fit})
      : super(key: key);

  /// 图片地址
  final String url;

  /// package
  final String? package;

  /// placeholder
  final String? placeholder;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// fit
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    if (url == '' || url.contains('.mp4')) {
      return Container(
        color: SCColors.color_F2F3F5,
      );
    } else {
      if (url.contains('http')) {
        return netImage();
      } else {
        return localImage();
      }
    }
  }

  /// 本地图片
  Widget localImage() {
    return Image.asset(
      url.isEmpty ? '' : url,
      width: width,
      height: height,
      fit: fit,
      package: package,
    );
  }

  /// 网络图片
  Widget netImage() {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (BuildContext context, String url) {
        if (placeholder == null) {
          return Container(
            color: SCColors.color_F2F3F5,
          );
        } else {
          return Image.asset(placeholder ?? '');
        }
      },
      errorWidget: (
        BuildContext context,
        String url,
        dynamic error,
      ) {
        return Container(
          color: SCColors.color_F2F3F5,
        );
      },
    );
  }
}
