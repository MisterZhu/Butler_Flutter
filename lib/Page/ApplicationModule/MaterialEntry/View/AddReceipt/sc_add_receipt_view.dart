
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

/// 新增入库view

class SCAddReceiptView extends StatefulWidget {

  @override
  SCAddReceiptViewState createState() => SCAddReceiptViewState();
}

class SCAddReceiptViewState extends State<SCAddReceiptView> {

  /// 基础信息数组
  List baseInfoList = [
    {'isRequired': true, 'title': '仓库名称', 'content': ''},
    {'isRequired': true, 'title': '类型', 'content': ''}];

  /// 类型index
  int typeIndex = -1;

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
        list: baseInfoList,
        selectAction: (index) {
          if (index == 0) {
            //仓库名称
          } else if (index == 1) {
            //类型
            showTypeAlert();
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
                baseInfoList[1]['content'] = model.name!;
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
