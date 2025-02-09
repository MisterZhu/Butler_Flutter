import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

import '../../../../../Constants/sc_asset.dart';

/// 底部通用按钮

/// 默认样式按钮，白色背景，边框蓝色按钮
const int scMaterialBottomViewTypeNormal = 0;

/// 白色背景，边框蓝色按钮
const int scMaterialBottomViewType1 = 1;

/// 蓝色背景按钮
const int scMaterialBottomViewType2 = 2;

/// 自定义按钮
const int scMaterialBottomViewTypeCustom = 3;

/// 更多按钮
const int scMaterialBottomViewTypeMore = 4;

class SCMaterialDetailBottomView extends StatelessWidget {

  const SCMaterialDetailBottomView({Key? key, required this.list, this.onTap}) : super(key: key);

  /// 数据源 [{"type" : 0, "title" : "确定", "widget" : Container()}]
  final List list;

  /// 点击
  final Function(String value)? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 54.0 + MediaQuery.of(context).padding.bottom,
      color: SCColors.color_FFFFFF,
      child: Container(
        height: 54.0,
        alignment: Alignment.centerLeft,
        child: Row(
          children: bottomViewList(),
        ),
      ),
    );
  }

  /// bottomView
  List<Widget> bottomViewList() {
    List<Widget> widgetList = [];
    for (int i=0; i<list.length; i++) {
      var map = list[i];
      int type = map['type'];
      String text = map['title'];
      if (type == scMaterialBottomViewType1) {
        widgetList.add(button1(text));
      } else if (type == scMaterialBottomViewType2) {
        widgetList.add(button2(text));
      } else if (type == scMaterialBottomViewTypeCustom) {
        Widget item = map['widget'];
        widgetList.add(item);
      } else if (type == scMaterialBottomViewTypeMore) {
        widgetList.add(moreView(text));
      } else {
        widgetList.add(button1(text));
      }

      if (i != list.length - 1) {
        widgetList.add(spaceView());
      }
    }
    return widgetList;
  }

  /// 白色背景，边框蓝色
  Widget button1(String text) {
    return Expanded(
      flex: 1,
      child: Container(
      height: 40.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          border: Border.all(color: SCColors.color_4285F4, width: 1.0),
          borderRadius: BorderRadius.circular(4.0)),
      child: SizedBox.expand(child: CupertinoButton(
          minSize: 40.0,
          padding: EdgeInsets.zero,
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w400,
                color: SCColors.color_4285F4),
          ),
          onPressed: () {
            onTap?.call(text);
          }),),
    )
    );
  }

  /// 蓝色背景
  Widget button2(String text) {
    return Expanded(flex: 1, child: Container(
      height: 40.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: SCColors.color_4285F4,
          borderRadius: BorderRadius.circular(4.0)),
      child: SizedBox.expand(child: CupertinoButton(
          minSize: 40.0,
          padding: EdgeInsets.zero,
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w400,
                color: SCColors.color_FFFFFF),
          ),
          onPressed: () {
            onTap?.call(text);
          }),),
    ));
  }

  /// 更多
  Widget moreView(String text) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap?.call(text);
      },
      child: SizedBox(
        width: 48.0,
        height: 40.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(SCAsset.iconMoreBtn, width: 22.0, height: 22.0,),
            Text(text, maxLines: 1, overflow: TextOverflow.ellipsis, style:const  TextStyle(
                fontSize: SCFonts.f12,
                fontWeight: FontWeight.w400,
                color: SCColors.color_8D8E99
            ),)
          ],
        ),
      ),
    );
  }

  /// 间距view
  Widget spaceView() {
    return const SizedBox(width: 8.0,);
  }
}
