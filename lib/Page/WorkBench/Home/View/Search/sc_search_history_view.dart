import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../../Constants/sc_asset.dart';

/// 工作台-搜索历史记录view

class SCSearchHistoryView extends StatelessWidget {

  /// 内容数组
  final List list;

  /// 清空按钮点击
  final Function? clearAction;


  /// 按钮点击
  final Function(String title)? tapAction;


  SCSearchHistoryView({Key? key,
    required this.list,
    this.tapAction,
    this.clearAction
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topView(),
        contentView(),
      ],
    );
  }

  /// topView
  Widget topView() {
    return Container(
      padding: const EdgeInsets.only(left: 12.0),
      height: 38.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: Text('搜索历史',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w500,
                  color: SCColors.color_1B1D33))),
          const SizedBox(
            width: 20.0,
          ),
          GestureDetector(
            onTap: () {
              clearAction?.call();
            },
            child: Container(
              width: 38.0,
              alignment: Alignment.center,
              child: Image.asset(SCAsset.iconSearchHistoryClear, width: 14.0, height: 14.0,),
            ),
          ),
        ],
      ),
    );
  }

  Widget contentView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 12.0,
        runSpacing: 12.0,
        children: list.asMap().keys.map((index) => cell(list[index])).toList(),
      ),
    );
  }

  /// cell
  Widget cell(String name) {
    return GestureDetector(
      onTap: () {
        tapAction?.call(name);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 26.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            border: Border.all(color: SCColors.color_8D8E99, width: 0.5)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        child: Text(
          name,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: SCColors.color_1B1D33,
          ),),
      ),
    );
  }

}