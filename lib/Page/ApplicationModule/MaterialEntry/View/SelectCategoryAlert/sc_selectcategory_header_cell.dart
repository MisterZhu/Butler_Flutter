import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

import '../../Model/sc_selectcategory_model.dart';

/// header-cell

class SCSelectCategoryHeaderCell extends StatelessWidget {

  const SCSelectCategoryHeaderCell({
    Key? key,
    required this.isHiddenTopLine,
    required this.isHiddenBottomLine,
    required this.model,
    this.onTap
  }) : super(key: key);

  /// 是否顶部线
  final bool isHiddenTopLine;

  /// 是否隐藏底部线
  final bool isHiddenBottomLine;

  /// model
  final SCSelectCategoryModel model;

  /// 点击回调
  final Function(SCSelectCategoryModel model)? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap?.call(model);
      },
      child: Container(
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
    Color color;
    if (model.enable ?? false) {
      color = SCColors.color_1B1D33;
    } else {
      color = SCColors.color_4285F4;
    }
    return Expanded(child: Text(model.title ?? '请选择', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(
      fontSize: SCFonts.f16,
      fontWeight: FontWeight.w400,
      color: color
    ),));
  }

  /// 右侧详情icon
  Widget rightView() {
    bool showArrow = model.showArrow ?? false;
    if (showArrow) {
      return Image.asset(SCAsset.iconArrowRight, width: 16.0, height: 16.0,);
    } else {
      return const SizedBox(width: 16.0,);
    }
  }

  /// 圆圈
  Widget circleView() {
    double width = 10.0;
    BoxDecoration boxDecoration;
    if (model.enable ?? false) {
      boxDecoration = BoxDecoration(
          borderRadius: BorderRadius.circular(width/2.0),
          color: SCColors.color_4285F4
      );
    } else {
      boxDecoration = BoxDecoration(
          borderRadius: BorderRadius.circular(width/2.0),
          color: SCColors.color_FFFFFF,
        border: Border.all(width: 1.0, color: SCColors.color_4285F4)
      );
    }

    return Container(
      width: width,
      height: width,
      decoration: boxDecoration,
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