import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/sc_deliver_evidence_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/sc_deliver_explain_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_material_bottom_view.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Controller/sc_check_cell_controller.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/PageView/sc_workbench_empty_view.dart';
import 'package:smartcommunity/Utils/Community/sc_selectcommunity_utils.dart';
import 'package:smartcommunity/common/component/comm_deliver_evidence_cell.dart';
import 'package:smartcommunity/common/component/common_info_fold_view.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../Mine/Home/Model/sc_community_alert_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_search_item.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_sift_item.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../MaterialEntry/View/Alert/sc_sift_alert.dart';
import '../../../MaterialEntry/View/Alert/sc_sort_alert.dart';
import '../../../WarningCenter/Model/sc_warning_dealresult_model.dart';
import '../../../WarningCenter/View/Alert/sc_warningtype_alert.dart';
import '../../Controller/sc_patrol_controller.dart';
import '../../Model/sc_patrol_task_model.dart';
import '../../Other/sc_patrol_utils.dart';

/// 巡查view

class SCCheckCellView extends StatefulWidget {
  final SCCheckCellController state;

  SCCheckCellView({Key? key, required this.state}) : super(key: key);

  @override
  SCCheckCellViewState createState() => SCCheckCellViewState();
}

class SCCheckCellViewState extends State<SCCheckCellView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return GestureDetector(
      onTap: () {
        SCUtils().hideKeyboard(context: context);
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          listView(),
          Expanded(child: Container()),
          bottomView(),
        ],
      ),
    );
  }

  Widget listView() {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ddd();
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 10.0,
                );
              },
              itemCount: 1),
        ));
  }

  Widget ddd() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
              color: SCColors.color_FFFFFF,
              borderRadius: BorderRadius.circular(4.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.state.title ?? '',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: SCFonts.f16,
                    fontWeight: FontWeight.w500,
                    color: SCColors.color_1B1D33),
              ),
              Row(
                children: <Widget>[
                  const Text("检查结果"),
                  const SizedBox(width: 20),
                  const Text("正常"),
                  Radio(
                    value: "0",
                    groupValue: widget.state.groupValue,
                    onChanged: (value) {
                      setState(() {
                        widget.state.groupValue = value.toString();
                      });
                    },
                  ),
                  // const SizedBox(width: 10),
                  const Text("异常"),
                  Radio(
                    value: "1",
                    groupValue: widget.state.groupValue,
                    onChanged: (value) {
                      setState(() {
                        widget.state.groupValue = value.toString();
                      });
                    },
                  )
                ],
              ),
              line(),
              inputItem(),
              line(),
              photosItem(),
            ],
          ),
        ),
      ],
    );
  }

  /// 输入框
  Widget inputItem() {
    return Container(
        padding: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: SCDeliverExplainCell(
          isRequired: false,
          title: "意见",
          content: widget.state.input,
          inputHeight: 92.0,
          inputAction: (String content) {
            widget.state.input = content;
          },
        ));
  }

  /// 图片
  Widget photosItem() {
    return Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: SCDeliverEvidenceCell(
          title: '上传照片',
          addIcon: SCAsset.iconMaterialAddPhoto,
          addPhotoType: SCAddPhotoType.all,
          files: widget.state.photosList,
          isNew: false,
          updatePhoto: (List list) {
            setState(() {
              List addList = [];
              if (list.isNotEmpty) {
                for (var element in list) {
                  var fileKey = '';
                  try {
                    fileKey = element['fileKey'] ?? '';
                  } catch (e) {
                    e.toString();
                    fileKey = element;
                  }
                  addList.add(fileKey);
                }
              }
              widget.state.photosList.clear();
              widget.state.photosList.addAll(addList);
            });
          },
        ));
  }

  Widget line() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: Divider(
        height: 0.5,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  Widget bottomView() {
    List list = [
      {
        "type": scMaterialBottomViewType1,
        "title": "取消",
      },
      {
        "type": scMaterialBottomViewType2,
        "title": "确定",
      },
    ];
    return SCMaterialDetailBottomView(
        list: list,
        onTap: (value) {
          SCUtils().hideKeyboard(context: context);
          if (value == '取消') {
            SCRouterHelper.back(null);
          } else if (value == '确定') {
            widget.state.loadData(
                int.parse(widget.state.groupValue), widget.state.photosList);
          }
        });
  }
}
