import 'package:flutter/cupertino.dart';
import 'package:sc_tools/sc_tools.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 内容cell

class SCContentCell extends StatelessWidget {

  /// 内容
  final String content;

  /// 最大行数
  final int? maxLength;

  const SCContentCell({Key? key, required this.content, this.maxLength}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      maxLines: maxLength,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w500,
          fontFamilyFallback: SCToolsConfig.getPFSCForIOS(),
          color: SCColors.color_1B1D33),
    );
  }

}