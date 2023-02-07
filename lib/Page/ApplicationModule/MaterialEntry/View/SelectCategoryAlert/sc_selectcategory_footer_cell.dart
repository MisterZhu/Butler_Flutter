import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// footer-cell

class SCSelectCategoryFooterCell extends StatelessWidget {

  /// cell点击
  final Function? onTap;

  const SCSelectCategoryFooterCell({
    Key? key,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {onTap?.call();},
      child: Container(
        height: getHeight(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: titleView(),
      ),
    );
  }

  /// title
  Widget titleView() {
    return const Text('仓库1', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(
        fontSize: SCFonts.f16,
        fontWeight: FontWeight.w400,
        color: SCColors.color_1B1D33
    ),);
  }

  /// 组件高度
  static double getHeight() {
    return 40.0;
  }
}