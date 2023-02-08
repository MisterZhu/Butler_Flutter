
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

/// 底部按钮cell

class SCBottomButtonItem extends StatelessWidget {

  /// 按钮类型，0一个按钮，1两个按钮
  final int buttonType;

  /// onTap
  final Function? tapAction;

  /// onTap
  final Function? leftTapAction;

  /// onTap
  final Function? rightTapAction;

  /// title
  final List<String> list;

  SCBottomButtonItem({Key? key,
    required this.list,
    this.buttonType = 0,
    this.tapAction,
    this.leftTapAction,
    this.rightTapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(MediaQuery.of(context).viewInsets.bottom);
  }

  /// body
  Widget body(double bottom) {
    return Container(
      width: double.infinity,
      height: 54.0 + SCUtils().getBottomSafeArea(),
      color: SCColors.color_FFFFFF,
      padding: EdgeInsets.only(left: 16.0, top: 7.0, right: 16.0, bottom: SCUtils().getBottomSafeArea() + 7.0),
      child: buttonType == 1 ? buttonsItem() : buttonItem(list[0]),
    );
  }

  /// 2个按钮
  Widget buttonsItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        leftButtonItem(list[0]),
        const SizedBox(width: 13.0,),
        rightButtonItem(list[1]),
      ],
    );
  }

  /// 底部左边按钮
  Widget leftButtonItem(String title) {
    double btnWidth = (SCUtils().getScreenWidth() - 45.0) / 2.0;
    return Container(
      width: btnWidth,
      height: 40.0,
      decoration: BoxDecoration(
        color: SCColors.color_FFFFFF,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: SCColors.color_4285F4, width: 1.0)
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: SCFonts.f16,
            fontWeight: FontWeight.w400,
            color: SCColors.color_4285F4,),
        ),
        onPressed: () {
          leftTapAction?.call();
        },
      )
    );
  }

  /// 底部右边按钮
  Widget rightButtonItem(String title) {
    double btnWidth = (SCUtils().getScreenWidth() - 45.0) / 2.0;
    return Container(
        width: btnWidth,
        height: 40.0,
        decoration: BoxDecoration(
            color: SCColors.color_4285F4,
            borderRadius: BorderRadius.circular(4.0)),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w400,
              color: SCColors.color_FFFFFF,),
          ),
          onPressed: () {
            rightTapAction?.call();
          },
        )
    );
  }

  /// 1个底部按钮
  Widget buttonItem(String title) {
    return Container(
        width: double.infinity,
        height: 40.0,
        decoration: BoxDecoration(
            color: SCColors.color_4285F4,
            borderRadius: BorderRadius.circular(4.0)),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w400,
              color: SCColors.color_FFFFFF,),
          ),
          onPressed: () {
            tapAction?.call();
          },
        )
    );
  }
}