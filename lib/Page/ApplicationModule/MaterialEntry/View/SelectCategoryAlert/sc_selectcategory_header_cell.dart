import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

/// header-cell

class SCSelectCategoryHeaderCell extends StatelessWidget {

  const SCSelectCategoryHeaderCell({
    Key? key,
    required this.isHiddenTopLine,
    required this.isHiddenBottomLine
  }) : super(key: key);

  /// 是否顶部线
  final bool isHiddenTopLine;

  /// 是否隐藏底部线
  final bool isHiddenBottomLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          leftView(),
          const SizedBox(width: 14.0,),
          titleView(),
          rightView()
        ],
      ),
    );
  }

  /// 左侧圆圈和竖线
  Widget leftView() {
    return Column(
      children: [
        lineV(!isHiddenTopLine),
        circleView(),
        lineV(!isHiddenBottomLine)
      ],
    );
  }

  /// title
  Widget titleView() {
    return const Expanded(child: Text('请选择', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(
      fontSize: SCFonts.f16,
      fontWeight: FontWeight.w400,
      color: SCColors.color_1B1D33
    ),));
  }

  /// 右侧详情icon
  Widget rightView() {
    return Image.asset(SCAsset.iconArrowRight, width: 16.0, height: 16.0,);
  }

  /// 圆圈
  Widget circleView() {
    double width = 10.0;
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width/2.0),
        color: SCColors.color_4285F4
      ),
    );
  }

  /// 竖线
  Widget lineV(bool visible) {
    return Expanded(child: Visibility(
      visible: visible,
        child: Container(
      width: 0.5,
      color: SCColors.color_4285F4,
    )));
  }

  /// 组件高度
  static double getHeight() {
    return 40.0;
  }
}