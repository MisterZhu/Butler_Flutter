import 'package:flutter/material.dart';
import 'package:sc_uikit/src/styles/sc_colors.dart';
import 'package:sc_uikit/src/styles/sc_fonts.dart';
import 'package:sc_uikit/src/ui/detail/single/sc_task_time_item.dart';

/// 剩余时间cell

class SCRemainingTimeCell extends StatelessWidget {
  /// title
  final String? title;

  /// 标题颜色
  final Color? titleColor;

  /// content
  final String? content;

  /// content颜色
  final Color? contentColor;

  /// 时间
  final int time;

  const SCRemainingTimeCell(
      {Key? key,
      this.title,
      this.content,
      required this.time,
      this.titleColor,
      this.contentColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title ?? '',
          style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: titleColor ?? SCColors.color_5E5F66),
        ),
        const SizedBox(
          width: 6.0,
        ),
        SCTaskTimeItem(
          time: time,
        ),
        statusItem()
      ],
    );
  }

  /// 状态
  Widget statusItem() {
    return Expanded(
        child: Text(
      content ?? '',
      textAlign: TextAlign.right,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: contentColor ?? SCColors.color_FF8A00),
    ));
  }
}
