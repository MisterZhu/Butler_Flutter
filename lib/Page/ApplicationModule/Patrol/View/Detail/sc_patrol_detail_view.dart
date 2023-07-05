import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Alert/check_cell_alert.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_patrol_detail_model.dart';
import '../../../../../Constants/sc_h5.dart';
import '../../../../../Constants/sc_type_define.dart';
import '../../../../../Network/sc_config.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../Controller/sc_patrol_detail_controller.dart';

/// 巡查详情view

class SCPatrolDetailView extends StatefulWidget {
  /// SCPatrolDetailController
  final SCPatrolDetailController state;

  const SCPatrolDetailView({Key? key, required this.state}) : super(key: key);

  @override
  SCPatrolDetailViewState createState() => SCPatrolDetailViewState();
}

class SCPatrolDetailViewState extends State<SCPatrolDetailView> {
  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index: index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10.0,
          );
        },
        itemCount: widget.state.dataList.length);
  }

  /// cell
  Widget getCell({required int index}) {
    int type = widget.state.dataList[index]['type'];
    List list = widget.state.dataList[index]['data'];
    if (type == SCTypeDefine.SC_PATROL_TYPE_TITLE) {
      return cell1(list);
    } else if (type == SCTypeDefine.SC_PATROL_TYPE_LOG) {
      return logCell(list);
    } else if (type == SCTypeDefine.SC_PATROL_TYPE_CHECK) {
      return checkCell(list);
    } else if (type == SCTypeDefine.SC_PATROL_TYPE_INFO) {
      return cell1(list);
    } else {
      return const SizedBox();
    }
  }

  /// cell1
  Widget cell1(List list) {
    return SCDetailCell(
      list: list,
      leftAction: (String value, int index) {},
      rightAction: (String value, int index) {},
      imageTap: (int imageIndex, List imageList, int index) {
        // SCImagePreviewUtils.previewImage(imageList: [imageList[index]]);
      },
    );
  }

  /// 任务日志cell
  Widget logCell(List list) {
    return SCDetailCell(
      list: list,
      leftAction: (String value, int index) {},
      rightAction: (String value, int index) {},
      imageTap: (int imageIndex, List imageList, int index) {
        // SCImagePreviewUtils.previewImage(imageList: [imageList[index]]);
      },
      detailAction: (int subIndex) {
        // 任务日志
        SCRouterHelper.pathPage(
            SCRouterPath.taskLogPage, {'bizId': widget.state.procInstId});
      },
    );
  }

  /// 检查项cell
  Widget checkCell(List list) {
    return SCDetailCell(
      list: list,
      leftAction: (String value, int index) {},
      rightAction: (String value, int index) {},
      imageTap: (int imageIndex, List imageList, int index) {},
      detailAction: (int subIndex) {
        if (widget.state.model.customStatusInt! >= 40) {
          return;
        }
        // if (widget.state.model.isScanCode == false) {// 任务扫码前，不可对检查项进行报事
        //   SCToast.showTip('请先扫码');
        //   return;
        // }
        var checkItem =
        widget.state.model.formData?.checkObject!.checkList![subIndex];
        SCUIDetailCellModel detailCellModel = list[subIndex];
        SCPatrolDetailModel model = widget.state.model;
        if ((checkItem?.evaluateResult ?? '').isEmpty) {
          SCDialogUtils().showCustomBottomDialog(
              isDismissible: true,
              context: context,
              widget: CheckCellAlert(
                title: '检查',
                resultDes: '检查结果',
                reasonDes: '意见',
                isRequired: true,
                checkName: detailCellModel.title ?? '',
                hiddenTags: true,
                sureAction: (int index, String value, List imageList,String type) {
                  widget.state
                      .loadData(checkItem?.id.toString() ?? '', model, imageList,value,type);
                },
              ));
        } else {
          widget.state.loadCheckCellDetailData(widget.state.model,checkItem?.id.toString() ?? '');
        }
        // if (widget.state.model.customStatusInt! >= 40) {//已完成的任务，不能进行报事
        //   return;
        // }
        // if (widget.state.model.isScanCode == false) {// 任务扫码前，不可对检查项进行报事
        //   SCToast.showTip('请先扫码');
        //   return;
        // }
        // SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
        //   "title": '快捷报事',
        //   "url": SCUtils.getWebViewUrl(
        //       url: SCConfig.getH5Url(SCH5.quickReportUrl),
        //       title: '快捷报事',
        //       needJointParams: true)
        // });
      },
    );
  }
}
