import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/src/styles/sc_colors.dart';
import 'package:sc_uikit/src/styles/sc_fonts.dart';
import 'package:sc_tools/sc_tools.dart';

/// 展开折叠title-cell

class SCFoldTitleCell extends StatelessWidget {
  /// 是否折叠
  final bool? fold;

  /// title
  final String title;

  const SCFoldTitleCell({Key? key, required this.title, this.fold})
      : super(key: key);

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
        Image.asset(
          (fold ?? false) ? 'images/fold/icon_fold.png' : 'images/fold/icon_unfold.png',
          width: 16.0,
          height: 16.0,
          package: 'sc_uikit',
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
