import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 横线cell

class SCLineCell extends StatelessWidget {

  /// 颜色
  final Color? color;

  /// padding
  final EdgeInsetsGeometry? padding;

  const SCLineCell({Key? key, this.color, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Container(
        height: 0.5,
        color: color ?? SCColors.color_EDEDF0,
      ),
    );
  }

}