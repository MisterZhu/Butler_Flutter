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
import '../../../../Constants/sc_key.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/Router/sc_router_path.dart';
import '../../../../Utils/sc_utils.dart';
import '../../../WorkBench/Home/View/PageView/sc_workbench_empty_view.dart';
import '../../../WorkBench/Home/View/PageView/sc_workbench_time_view.dart';
import '../Model/sc_image_model.dart';
import '../Model/sc_work_order_model.dart';
import '../View/Detail/workbench_time_view.dart';

class SCCheckCellDetailPage extends StatefulWidget {
  @override
  SCCheckCellDetailPageState createState() => SCCheckCellDetailPageState();
}

class SCCheckCellDetailPageState extends State<SCCheckCellDetailPage> {
  late SCCheckCellDetailController cellDetailController;

  /// SCWarningCenterController - tag
  String controllerTag = '';

  /// notify
  late StreamSubscription subscription;

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCCheckCellDetailPage).toString());
    cellDetailController =
        Get.put(SCCheckCellDetailController(), tag: controllerTag);
    cellDetailController.initParams(Get.arguments);

    addNotification();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: '详情', centerTitle: true, elevation: 0, body: body());
  }

  /// 通知
  addNotification() {
    subscription = SCScaffoldManager.instance.eventBus.on().listen((event) {
      String key = event['key'];
      if (key == SCKey.kRefreshCellDetailPage) {
        cellDetailController.updateData();
      } else if (key == SCKey.kRefreshCellReportPage) {
        cellDetailController.loadWorkOrderList();
      }
    });
  }

  Widget body() {
    return GetBuilder<SCCheckCellDetailController>(
        tag: controllerTag,
        init: cellDetailController,
        builder: (state) {
          return SingleChildScrollView(
            child: Container(
              padding:
                  const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
              width: double.infinity,
              color: SCColors.color_F2F3F5,
              child: Column(
                children: [
                  contentItem(),
                  reportList(),
                ],
              ),
            ),
          );
        });
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
                checkNameLabel(
                    cellDetailController.cellDetailList.checkName ?? ''),
                const SizedBox(
                  height: 12.0,
                ),
                checkContentLabel(
                    cellDetailController.cellDetailList.checkContent ?? ''),
                const SizedBox(
                  height: 12.0,
                ),
                checkState(cellDetailController.setCheckState(
                    cellDetailController.cellDetailList.evaluateResult ?? '')),
                const SizedBox(
                  height: 12.0,
                ),
                checkStr(cellDetailController.cellDetailList.comments ?? ''),
                const SizedBox(
                  height: 12.0,
                ),
                checkPhoto(
                    cellDetailController.cellDetailList.attachments ?? [])
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
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: SCColors.color_FFFFFF,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        children: [
          addReort(),
          line(),
          reportLayout(),
        ],
      ),
    );
  }

  Widget reportLayout() {
    if (cellDetailController.workOrderDetailList.isNotEmpty) {
      return ListView.separated(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return reportItem(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return line();
          },
          itemCount: cellDetailController.workOrderDetailList.length);
    } else {
      return const SizedBox(
        height: 100.0,
        child: Text(
          "暂无异常报事",
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_B0B1B8),
        ),
      );
    }
  }

  Widget reportItem(int index) {
    if (cellDetailController.workOrderDetailList.isNotEmpty) {
      WorkOrder workOrder = cellDetailController.workOrderDetailList[index];
      return Column(
        children: [
          checkNameLabel(workOrder.address ?? ''),
          const SizedBox(
            height: 8.0,
          ),
          checkContentLabel(workOrder.communityName ?? ''),
          const SizedBox(
            height: 8.0,
          ),
          orderState(workOrder),
          // line()
        ],
      );
    }
    return const SizedBox();
  }

  Widget orderState(WorkOrder workOrder) {
    return Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        height: 30,
        padding: const EdgeInsets.only(left: 10.0),
        decoration: BoxDecoration(
            color: SCColors.color_F7F8FA,
            borderRadius: BorderRadius.circular(4.0)),
        child: setRemainingTime(workOrder));
  }

  Widget setRemainingTime(WorkOrder workOrder) {
    if ((workOrder.remainingTime ?? 0) > 0) {
      return Row(mainAxisSize: MainAxisSize.min, children: [
        const Text(
          '剩余时间',
          style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_5E5F66),
        ),
        const SizedBox(
          width: 6.0,
        ),
        Expanded(
          child: SCWorkOrderTimeView(time: workOrder.remainingTime ?? 0),
        )
      ]);
    } else {
      return Row(mainAxisSize: MainAxisSize.min, children: [
        reportText(workOrder),
        const SizedBox(
          width: 6.0,
        ),
        Expanded(
          child: SCWorkOrderTimeView(time: workOrder.remainingTime ?? 0),
        )
      ]);
    }
  }

  Widget reportText(WorkOrder workOrder) {
    if (workOrder.status == 1) {
      return const Text('待接收',
          style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_5E5F66));
    } else if (workOrder.status == 2) {
      return const Text('待处理',
          style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_5E5F66));
    } else if (workOrder.status == 3) {
      return const Text('超时待接收',
          style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_FF8A00));
    } else if (workOrder.status == 4) {
      return const Text('超时待处理',
          style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_FF8A00));
    } else if (workOrder.status == 8) {
      return const Text('关闭',
          style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_5E5F66));
    }
    return const SizedBox();
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

  Widget checkPhoto(List<Attachment> list) {
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
              cellDetailController.jumpToAddReport();
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
            onPressed: () {
              cellDetailController.jumpToEdit();
            }));
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
          fontWeight: FontWeight.w700,
          color: SCColors.color_1B1D33,
        ),
      ),
    );
  }

  Widget checkNameLabel(String text) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        text,
        maxLines: 10,
        overflow: TextOverflow.ellipsis,
        strutStyle: const StrutStyle(
          fontSize: SCFonts.f14,
          height: 1.25,
          forceStrutHeight: true,
        ),
        style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w700,
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
        maxLines: 10,
        overflow: TextOverflow.ellipsis,
        strutStyle: const StrutStyle(
          fontSize: SCFonts.f14,
          height: 1.25,
          forceStrutHeight: true,
        ),
        style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_8D8E99,
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

  Widget photoItem(List<Attachment> list) {
    return Expanded(
        child: Stack(
      alignment: Alignment.topRight,
      children: [
        GestureDetector(
            onTap: () {
              previewImage();
            },
            child: SizedBox(
                width: 76.0,
                height: 76.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: SCImage(
                    url: SCConfig.getImageUrl(list[0].fileKey ?? ''),
                    fit: BoxFit.cover,
                  ),
                ))),
      ],
    ));
  }

  Widget photoDoubleItem(List list) {
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
            onTap: () {
              previewImage();
            },
            child: SizedBox(
                width: 76.0,
                height: 76.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: SCImage(
                    url: SCConfig.getImageUrl(list[0].fileKey ?? ''),
                    fit: BoxFit.cover,
                  ),
                ))),
        const SizedBox(width: 12.0),
        GestureDetector(
            onTap: () {
              previewImage();
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                    width: 76.0,
                    height: 76.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: SCImage(
                        url: SCConfig.getImageUrl(list[1].fileKey ?? ''),
                        fit: BoxFit.cover,
                      ),
                    )),
                Text(
                  (list.length - 2) == 0 ? '' : "+${(list.length - 2)}",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: SCFonts.f14,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_FFFFFF),
                )
              ],
            )),
      ],
    ));
  }

  /// 图片预览
  previewImage() {
    SCImagePreviewUtils.previewImage(
        imageList: cellDetailController.photoList, needPerfix: true);
  }
}
