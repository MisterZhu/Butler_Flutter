import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stamp_image/stamp_image.dart';

/// 水印

enum SCWaterMarkType {
  onlyLogo, // 只有logo
  onlyText, // 只有文本
  logoAndText // logo和文本
}

class SCWaterMark {
  /// 类型
  SCWaterMarkType markType = SCWaterMarkType.onlyLogo;

  /// 图片path
  String imagePath = '';

  /// logo宽度
  double logoWidth = 60.0;

  /// logo高度
  double logoHeight = 60.0;

  /// logo
  String logoPath = '';

  /// 文本内容
  String text = '';

  /// 文本位置
  Alignment textAlignment = Alignment.bottomRight;

  /// 文本style
  TextStyle textStyle = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white);

  /// 生成水印图
  makeWaterMark({required BuildContext context, Function(File file)? success}) {
    StampImage.create(
      context: context,
      image: File(imagePath),
      children: itemList(),
      onSuccess: (file) {
        success?.call(file);
      },
    );
  }

  /// 文本
  Widget textItem() {
    if (textAlignment == Alignment.topLeft) {
      return Positioned(
        top: 0,
        left: 0,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      );
    } else if (textAlignment == Alignment.topCenter) {
      return Positioned(
        right: 0,
        top: 0,
        left: 0,
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              text,
              style: textStyle,
            ),
          ),
        ),
      );
    } else if (textAlignment == Alignment.topRight) {
      return Positioned(
        top: 0,
        right: 0,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      );
    } else if (textAlignment == Alignment.centerLeft) {
      return Positioned(
        top: 0,
        right: 0,
        bottom: 0,
        left: 0,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              text,
              style: textStyle,
            ),
          ),
        ),
      );
    } else if (textAlignment == Alignment.center) {
      return Positioned(
        top: 0,
        right: 0,
        bottom: 0,
        left: 0,
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              text,
              style: textStyle,
            ),
          ),
        ),
      );
    } else if (textAlignment == Alignment.centerRight) {
      return Positioned(
        top: 0,
        right: 0,
        bottom: 0,
        left: 0,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              text,
              style: textStyle,
            ),
          ),
        ),
      );
    } else if (textAlignment == Alignment.bottomLeft) {
      return Positioned(
        bottom: 0,
        left: 0,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      );
    } else if (textAlignment == Alignment.bottomCenter) {
      return Positioned(
        right: 0,
        bottom: 0,
        left: 0,
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              text,
              style: textStyle,
            ),
          ),
        ),
      );
    } else {
      return Positioned(
        bottom: 0,
        right: 0,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      );
    }
  }

  /// logo
  Widget logo() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          logoPath,
          width: logoWidth,
          height: logoHeight,
        ),
      ),
    );
  }

  /// itemList
  List<Widget> itemList() {
    if (markType == SCWaterMarkType.onlyLogo) {
      return [logo()];
    } else if (markType == SCWaterMarkType.onlyText) {
      return [textItem()];
    } else {
      return [textItem(), logo()];
    }
  }
}
