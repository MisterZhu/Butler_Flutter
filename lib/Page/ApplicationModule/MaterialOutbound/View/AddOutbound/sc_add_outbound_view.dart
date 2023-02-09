
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/AddReceipt/sc_material_info_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/AddReceipt/sc_basic_info_cell.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../../WorkBench/Home/Model/sc_home_task_model.dart';
import '../../../../WorkBench/Home/View/Alert/sc_task_module_alert.dart';
import '../../../HouseInspect/View/sc_bottom_button_item.dart';

/// 新增出库view

class SCAddOutboundView extends StatefulWidget {

  @override
  SCAddOutboundViewState createState() => SCAddOutboundViewState();
}

class SCAddOutboundViewState extends State<SCAddOutboundView> {

  /// 仓库名称
  String warehouseName = '';
  /// 类型
  String type = '';
  /// 领用部门
  String department = '';
  /// 领用人
  String receiver = '';

  /// 领用人index
  int receiverIndex = -1;

  /// 基础信息数组
  List baseInfoList = [];

  /// 类型index
  int typeIndex = -1;


  @override
  initState() {
  }

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: listview(context)),
        SCBottomButtonItem(list: const ['暂存', '提交'], buttonType: 1, leftTapAction: () {
          /// 保存
          save();
        }, rightTapAction: () {
          /// 提交
        },),
      ],
    );
  }

  /// listview
  Widget listview(BuildContext context) {
    return ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox();
        },
        itemCount: 4);
  }

  Widget getCell(int index) {
    if (index == 0) {
      return SCBasicInfoCell(
        list: [{'isRequired': true, 'title': '仓库名称', 'content': warehouseName},
          {'isRequired': true, 'title': '类型', 'content': type},
          {'isRequired': false, 'title': '领用部门', 'content': department},
          {'isRequired': false, 'title': '领用人', 'content': receiver},
        ],
        selectAction: (index) async {
          if (index == 0) {
            //仓库名称
          } else if (index == 1) {
            //类型
            showTypeAlert();
          } else if (index == 2) {
            //领用部门
            showTypeAlert();
          } else if (index == 3) {
            //领用人
            var params = {
              'receiver': receiver,
              'receiverIndex': receiverIndex
            };
            var backParams = await SCRouterHelper.pathPage(SCRouterPath.selectReceiverPage, params);
            setState(() {
              receiver = backParams['receiver'] ?? '';
              receiverIndex = backParams['receiverIndex'] ?? -1;
            });
          }
        }, inputAction: (content) {

        }, addPhotoAction: (list) {

        },);
    } else if (index == 1) {
      return SCMaterialInfoCell(addAction: () {
        SCRouterHelper.pathPage(SCRouterPath.addMaterialPage, null);
      },);
    } else {
      return const SizedBox(height: 10,);
    }
  }

  /// 弹出类型弹窗
  showTypeAlert() {
    List typeList = ['采购入库', '调拨入库', '盘盈入库', '领料归还入库', '借用归还入库', '退货入库', '其他入库'];
    List<SCHomeTaskModel> list = [];
    for (int i = 0; i < typeList.length; i++) {
      list.add(SCHomeTaskModel.fromJson({"name" : typeList[i], "id" : "$i", "isSelect" : false}));
    }
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCTaskModuleAlert(
            title: '类型',
            list: list,
            currentIndex: typeIndex,
            radius: 2.0,
            tagHeight: 32.0,
            columnCount: 3,
            mainSpacing: 8.0,
            crossSpacing: 8.0,
            topSpacing: 8.0,
            closeTap: (SCHomeTaskModel model, int index) {
              setState(() {
                type = model.name!;
                typeIndex = index;
              });
            },
          ));
    });
  }

  /// 暂存
  save() {

  }

  /// 提交
  submit() {

  }
}
