import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// picker-自定义header
class SCPickerHeader extends StatelessWidget {
  SCPickerHeader(
      {Key? key,
        this.title = '请选择',
        this.titleColor = SCColors.color_1B1D33,
        this.cancelText = '取消',
        this.cancelColor = SCColors.color_4285F4,
        this.sureText = '确定',
        this.sureColor = SCColors.color_4285F4,
        this.radius = 12.0,
        this.cancelTap,
        this.sureTap})
      : super(key: key);

  /// 标题
  final String? title;

  /// 标题颜色
  final Color? titleColor;

  /// 取消文本
  final String? cancelText;

  /// 取消文本颜色
  final Color? cancelColor;

  /// 确定文本
  final String? sureText;

  /// 确定文本颜色
  final Color? sureColor;

  /// 圆角
  final double? radius;

  /// 点击取消按钮
  final Function? cancelTap;

  /// 点击确定按钮
  final Function? sureTap;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    String titleString = title ?? '请选择';
    String cancelString = cancelText ?? '取消';
    String sureString = sureText ?? '确定';

    return Container(
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius ?? 12.0),
              topRight: Radius.circular(radius ?? 12.0))
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 54.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(
                cancelString,
                style: TextStyle(fontSize: 15.0, color: cancelColor),
              ),
              onPressed: () {
                cancelTap?.call();
              }),
          Expanded(
              child: Text(
                titleString,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16.0, color: titleColor),
              )),
          CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(
                sureString,
                style: TextStyle(fontSize: 15.0, color: sureColor),
              ),
              onPressed: () {
                sureTap?.call();
              })
        ],
      ),
    );
  }
}
