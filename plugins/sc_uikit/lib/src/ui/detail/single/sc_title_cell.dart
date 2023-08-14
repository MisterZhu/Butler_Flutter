/// 常用标题cell
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_tools/sc_tools.dart';
import 'package:sc_uikit/src/image/sc_image.dart';
import 'package:sc_uikit/src/styles/sc_colors.dart';
import 'package:sc_uikit/src/styles/sc_fonts.dart';

/// 文本cell

class SCTitleCell extends StatelessWidget {
  /// title
  final String? title;

  /// title颜色
  final Color? titleColor;

  /// title字体大小
  final double? titleFontSize;

  /// content
  final String? content;

  /// content颜色
  final Color? contentColor;

  /// content字体大小
  final double? contentFontSize;

  /// maxLength
  final int? maxLength;

  /// 左侧icon
  final String? leftIcon;

  /// 右侧icon
  final String? rightIcon;

  /// 左侧icon点击
  final Function? leftAction;

  /// 右侧icon点击
  final Function? rightAction;

  const SCTitleCell(
      {Key? key,
      this.title,
      this.content,
      this.leftIcon,
      this.rightIcon,
      this.leftAction,
      this.rightAction,
      this.maxLength,
      this.titleColor,
      this.titleFontSize,
      this.contentColor,
      this.contentFontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        leftIconItem(),
        titleItem(),
        const SizedBox(
          width: 6.0,
        ),
        rightIconItem(),
        contentItem()
      ],
    );
  }

  /// 左侧icon
  Widget leftIconItem() {
    bool offstage = (leftIcon ?? '').isEmpty ? true : false;
    return Offstage(
      offstage: offstage,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, top: 1.0),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: SCImage(url: leftIcon ?? '', width: 16.0, height: 16.0),
          onTap: () {
            leftAction?.call();
          },
        ),
      ),
    );
  }

  /// title
  Widget titleItem() {
    return Expanded(
        flex: 5,
        child: Text(
          SCBaseStrings.autoLineString(title ?? ''),
          maxLines: 1,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: titleFontSize ?? SCFonts.f14,
              fontWeight: FontWeight.w400,
              height: 1.3,
              color: titleColor ?? SCColors.color_5E5F66),
        ));
  }

  /// content
  Widget contentItem() {
    return Expanded(
        flex: 3,
        child: Text(
          SCBaseStrings.autoLineString(content ?? ''),
          maxLines: maxLength ?? 1,
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: contentFontSize ?? SCFonts.f14,
              fontWeight: FontWeight.w400,
              height: 1.3,
              color: contentColor ?? SCColors.color_1B1D33),
        ));
  }

  /// 右侧icon
  Widget rightIconItem() {
    bool offstage = (rightIcon ?? '').isEmpty ? true : false;
    return Offstage(
      offstage: offstage,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, top: 1.0),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: SCImage(url: rightIcon ?? '', width: 16.0, height: 16.0),
          onTap: () {
            rightAction?.call();
          },
        ),
      ),
    );
  }
}
