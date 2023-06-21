import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Network/sc_config.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Controller/sc_check_cell_detail_controller.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';
import 'package:smartcommunity/Utils/Preview/sc_image_preview_utils.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../Constants/sc_h5.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/Router/sc_router_path.dart';
import '../../../../Utils/sc_utils.dart';

class SCCheckCellDetailPage extends StatefulWidget {
  @override
  SCCheckCellDetailPageState createState() => SCCheckCellDetailPageState();
}

class SCCheckCellDetailPageState extends State<SCCheckCellDetailPage> {
  late SCCheckCellDetailController cellDetailController;

  /// SCWarningCenterController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCCheckCellDetailPage).toString());
    cellDetailController =
        Get.put(SCCheckCellDetailController(), tag: controllerTag);
    cellDetailController.initParams(Get.arguments);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: '详情', centerTitle: true, elevation: 0, body: body());
  }

  Widget body() {
    return GetBuilder<SCCheckCellDetailController>(
        tag: controllerTag,
        init: cellDetailController,
        builder: (state) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: SCColors.color_F2F3F5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                listView(),
                Expanded(child: Container()),
              ],
            ),
          );
        });
  }

  /// listView
  Widget listView() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
      child: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return getCell(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: 3),
    );
  }

  Widget getCell(int index) {
    if (index == 0) {
      // 检查详情
      return contentItem();
    } else if (index == 1) {
      // 异常报事
      return reportList();
    } else {
      return const SizedBox(
        height: 10,
      );
    }
  }

  /// contentItem
  Widget contentItem() {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: SCColors.color_FFFFFF,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Column(
              children: [
                checkName(),
                line(),
                checkContentLabel(
                    cellDetailController.cellDetailList.checkName ?? ''),
                const SizedBox(
                  height: 12.0,
                ),
                checkState(
                    cellDetailController.cellDetailList.checkContent ?? ''),
                const SizedBox(
                  height: 12.0,
                ),
                checkStr(cellDetailController.cellDetailList.comments ?? ''),
                checkPhoto([])
              ],
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
        ]);
  }

  Widget reportList() {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: SCColors.color_FFFFFF,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        children: [
          addReort(),
          line(),
        ],
      ),
    );
  }

  Widget title(String str) {
    return Text(
      str ?? '',
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1D33),
    );
  }

  Widget addReort() {
    return Row(
      children: [titleLabel('异常报事'), addView()],
    );
  }

  Widget checkName() {
    return Row(
      children: [titleLabel('检查详情'), editView()],
    );
  }

  Widget checkState(String str) {
    return Row(
      children: [desLabel('检查结果'), textView(1, str ?? '')],
    );
  }

  Widget checkStr(String str) {
    return Row(
      children: [desLabel('意见'), textView(2, str ?? '')],
    );
  }

  Widget checkPhoto(List list) {
    if (list.isNotEmpty) {
      if (list.length == 1) {
        return Row(
          children: [desLabel('照片'), photoItem(list)],
        );
      } else {
        return Row(
          children: [desLabel('照片'), photoDoubleItem(list)],
        );
      }
    } else {
      return const SizedBox(
        height: 12.0,
      );
    }
  }

  Widget addView() {
    return Expanded(
        child: CupertinoButton(
            minSize: 22.0,
            padding: EdgeInsets.zero,
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  SCAsset.iconPatrolAdd,
                  width: 14.0,
                  height: 14.0,
                ),
                const SizedBox(
                  width: 4.0,
                ),
                const Text(
                  '新增',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: SCFonts.f14,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_4285F4),
                ),
              ],
            ),
            onPressed: () {
              SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
                "title": '快捷报事',
                "url": SCUtils.getWebViewUrl(
                    url: SCConfig.getH5Url(SCH5.quickReportUrl),
                    title: '快捷报事',
                    needJointParams: true)
              });
            }));
  }

  Widget editView() {
    return Expanded(
        child: CupertinoButton(
            minSize: 22.0,
            padding: EdgeInsets.zero,
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  SCAsset.iconPatrolEdit,
                  width: 14.0,
                  height: 14.0,
                ),
                const SizedBox(
                  width: 4.0,
                ),
                const Text(
                  '编辑',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: SCFonts.f14,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_4285F4),
                ),
              ],
            ),
            onPressed: () {}));
  }

  Widget textView(int maxLines, String text) {
    return Expanded(
        child: Text(
      text,
      textAlign: TextAlign.right,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      strutStyle: const StrutStyle(
        fontSize: SCFonts.f14,
        height: 1.25,
        forceStrutHeight: true,
      ),
      style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_1B1D33),
    ));
  }

  Widget titleLabel(String text) {
    return SizedBox(
      width: 100.0,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        strutStyle: const StrutStyle(
          fontSize: SCFonts.f16,
          height: 1.25,
          forceStrutHeight: true,
        ),
        style: const TextStyle(
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w400,
          color: SCColors.color_1B1D33,
        ),
      ),
    );
  }

  Widget checkContentLabel(String text) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        strutStyle: const StrutStyle(
          fontSize: SCFonts.f14,
          height: 1.25,
          forceStrutHeight: true,
        ),
        style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_1B1D33,
        ),
      ),
    );
  }

  Widget desLabel(String text) {
    return SizedBox(
      width: 100.0,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        strutStyle: const StrutStyle(
          fontSize: SCFonts.f14,
          height: 1.25,
          forceStrutHeight: true,
        ),
        style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_5E5F66,
        ),
      ),
    );
  }

  /// line
  Widget line() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  Widget photoItem(List list) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        GestureDetector(
            onTap: () {
              previewImage(SCConfig.getImageUrl(list[0]));
            },
            child: AspectRatio(
                aspectRatio: 1.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: SCImage(
                    url: SCConfig.getImageUrl(list[0]),
                    fit: BoxFit.cover,
                  ),
                ))),
      ],
    );
  }

  Widget photoDoubleItem(List list) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        GestureDetector(
            onTap: () {
              previewImage(SCConfig.getImageUrl(list[0]));
            },
            child: AspectRatio(
                aspectRatio: 1.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: SCImage(
                    url: SCConfig.getImageUrl(list[0]),
                    fit: BoxFit.cover,
                  ),
                ))),
        GestureDetector(
            onTap: () {
              previewImage(SCConfig.getImageUrl(list[1]));
            },
            child: Stack(
              children: [
                AspectRatio(
                    aspectRatio: 1.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: SCImage(
                        url: SCConfig.getImageUrl(list[1]),
                        fit: BoxFit.cover,
                      ),
                    )),
                Text((list.length - 2).toString())
              ],
            )),
      ],
    );
  }

  /// 图片预览
  previewImage(String url) {
    SCImagePreviewUtils.previewImage(imageList: [url]);
  }
}
