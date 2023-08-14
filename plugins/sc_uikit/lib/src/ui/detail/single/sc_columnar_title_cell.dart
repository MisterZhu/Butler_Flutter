import 'package:flutter/cupertino.dart';
import 'package:sc_tools/sc_tools.dart';
import 'package:sc_uikit/src/styles/sc_colors.dart';
import 'package:sc_uikit/src/styles/sc_fonts.dart';

/// 柱状条title-cell

class SCColumnarTitleCell extends StatelessWidget {
  /// title
  final String title;

  const SCColumnarTitleCell({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 2.0,
          height: 13.0,
          color: SCColors.color_4285F4,
        ),
        const SizedBox(
          width: 5.0,
        ),
        Expanded(
            child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontFamilyFallback: SCToolsConfig.getPFSCForIOS(),
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w500,
              color: SCColors.color_1B1D33),
        ))
      ],
    );
  }
}
