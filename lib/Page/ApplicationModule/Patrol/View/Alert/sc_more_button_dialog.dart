
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Utils/sc_utils.dart';

/// 更多按钮弹窗

class SCMoreButtonDialog extends StatelessWidget{

  final List list;
  /// 点击
  final Function(int index)? tapAction;

  /// 点击空白位置关闭弹窗
  final Function? closeAction;

  SCMoreButtonDialog({Key? key, required this.list, this.tapAction, this.closeAction}) : super(key: key);

  /// cell高度
  double cellHeight = 46.0;

  /// cell宽度108
  double cellWidth = 108.0;

  /// 弹窗宽度148
  double width = 108.0 + 12;

  /// 底部offset28.0
  double bottomOffSet = 50.0;

  /// 三角形高度6.0
  double triangleHeight = 6.0;

  /// 上下阴影6.0
  double shadowOffSet = 6.0;

  /// 最多数量
  int maxCount = 6;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    double viewHeight = list.length > maxCount ? cellHeight * maxCount + shadowOffSet * 2 + triangleHeight : cellHeight * list.length + shadowOffSet * 2 + triangleHeight;
    return Stack(
      children: [
        Positioned(
            left: 0.0,
            right: 0.0,
            top: 0.0,
            bottom: 0.0,
            child: GestureDetector(
              onTap: () {
                closeAction?.call();
              },
              child: Container(color: Colors.transparent,),
            )),
        Positioned(
            left: 16.0,
            bottom: bottomOffSet + SCUtils().getBottomSafeArea(),
            width: width,
            height: viewHeight,
            child: contentView(viewHeight))
      ],
    );
  }

  /// 弹窗view
  Widget contentView(double height) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image.asset(
          SCAsset.iconMoreButtonBottomBg,
          centerSlice: const Rect.fromLTRB(17, 13, 102, 46),
          width: width,
          height: height,
        ),
        listview(),
      ],
    );
  }

  /// 内容listview
  Widget listview() {
    ScrollPhysics physics = list.length > maxCount ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics();
    double height = list.length > maxCount ? cellHeight * maxCount + shadowOffSet : cellHeight * list.length + shadowOffSet;
    return Container(
        width: cellWidth,
        height: height,
        padding: EdgeInsets.only(top: shadowOffSet),
        child: ListView.separated(
            padding: const EdgeInsets.only(left: 12.0),
            shrinkWrap: true,
            physics: physics,
            itemBuilder: (BuildContext context, int index) {
              return cell(index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(height: 0.5, color: SCColors.color_EDEDF0,);
            },
            itemCount: list.length));
  }

  Widget cell(int index) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
        height: cellHeight,
        alignment: Alignment.centerLeft,
        child: Text(
          list[index],
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
          fontSize: SCFonts.f14,
          color: SCColors.color_1B1D33,
          fontWeight: FontWeight.w400,
        ),),
    ), onPressed: () {
      tapAction?.call(index);
    });
  }
}