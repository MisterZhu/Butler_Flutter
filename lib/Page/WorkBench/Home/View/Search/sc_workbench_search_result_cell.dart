import 'package:flutter/cupertino.dart';
import 'package:sc_tools/sc_tools.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../../Constants/sc_asset.dart';

/// 工作台-搜索cell

class SCWorkBenchSearchCell extends StatelessWidget {

  /// 类型,0-工单,1-居民档案
  final int type;

  /// 内容数组
  final List? contentList;

  /// 按钮点击
  final Function? moreBtnTapAction;

  /// 详情
  final Function? detailTapAction;

  SCWorkBenchSearchCell({Key? key,
    required this.type,
    this.contentList,
    this.moreBtnTapAction,
    this.detailTapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return GestureDetector(
      onTap: () {
        detailTapAction?.call();
      },
      child: Container(
          decoration: BoxDecoration(
              color: SCColors.color_FFFFFF,
              borderRadius: BorderRadius.circular(4.0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topView(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Container(
                  height: 0.5,
                  color: SCColors.color_E5E6EB,
                ),
              ),
              contentItem()
            ],
          )
      ),
    );
  }

  /// topView
  Widget topView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      height: 47.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text('居民档案',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_5E5F66))),
          const SizedBox(
            width: 20.0,
          ),
          GestureDetector(
            onTap: () {
              moreBtnTapAction?.call();
            },
            child: SizedBox(
              width: 80.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('更多',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: SCFonts.f14,
                          fontWeight: FontWeight.w400,
                          color: SCColors.color_B0B1B8)),
                  const SizedBox(width: 6.0,),
                  Image.asset(SCAsset.iconMineSettingArrow, width: 16.0, height: 16.0,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// contentItem
  Widget contentItem() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return contentCell();
        },
        separatorBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Container(
              height: 0.5,
              color: SCColors.color_E5E6EB,
            ),
          );
        },
        itemCount: 2);
  }

  /// contentCell
  Widget contentCell() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 24.0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 18.0,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: SCColors.color_FF4040.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(2.0)),
                    child: const Text(
                        '投诉',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: SCFonts.f12,
                            fontWeight: FontWeight.w400,
                            color: SCColors.color_FF4040)),
                  ),
                  const SizedBox(width: 6.0,),
                  Expanded(child: Text(
                      '待处理工单',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: SCFonts.f16,
                          fontWeight: FontWeight.w400,
                          color: SCColors.color_1B1D33)),),
                  Text(
                      '157****4566',
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: SCFonts.f14,
                          fontWeight: FontWeight.w400,
                          color: SCColors.color_1B1D33)),
                ]
            ),
          ),
          cellItem(),
        ],
      ),
    );
  }

  /// cellItem
  Widget cellItem() {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return cell('慧享小区-1幢-3单元-2201室', '业主');
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 8.0,);
        },
        itemCount: 1);
  }

  Widget cell(String leftText, String rightText) {
    return SizedBox(
      height: 22.0,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Text(
                leftText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_8D8E99)),),
            SizedBox(
              width: type == 0 ? 0.0 : 60,
              child: Text(
                  rightText,
                  maxLines: 1,
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: SCFonts.f14,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_8D8E99)),
            ),
          ]
      ),
    );
  }

}