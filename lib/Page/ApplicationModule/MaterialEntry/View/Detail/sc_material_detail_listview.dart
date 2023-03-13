import 'package:flutter/material.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_material_info_cell.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../Controller/sc_material_entry_detail_controller.dart';
import 'sc_allmaterial_cell.dart';

/// 入库详情-listview
class SCMaterialDetailListView extends StatelessWidget {

  /// SCMaterialEntryDetailController
  final SCMaterialEntryDetailController state;

  /// 类型，type=entry入库详情，type=outbound出库详情
  final SCWarehouseManageType type;

  /// 是否至资产
  final bool? isProperty;

  SCMaterialDetailListView({Key? key, required this.state, required this.type, this.isProperty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        itemBuilder: (BuildContext context, int index){
      return cell(index);
    }, separatorBuilder: (BuildContext context, int index){
      return line(index);
    }, itemCount: 2);
  }

  /// cell
  Widget cell(int index) {
    if (index == 0) {// 所有物资
      return SCAllMaterialCell(state: state, type: type, model: state.model, remainingTime: state.remainingTime, isProperty: isProperty,);
    // } else if(index == 1) {// 审批流程
    //   return SCMaterialApproveFlowCell(title: '审批流程', onTap: () {
    //
    //   },);
    } else {// 入库信息
      return SCMaterialEntryInfoCell(model: state.model, type: type, callAction: (String phone) {
        callAction(phone);
      }, pasteAction: (String value) {
        pasteAction(value);
      },);
    }
  }

  /// 打电话
  callAction(String phone) {
    SCUtils.call(phone);
  }

  /// 复制粘贴板
  pasteAction(String value) {
    SCUtils.pasteData(value);
  }

  /// line
  Widget line(int index) {
    return const SizedBox(
      height: 10.0,
    );
  }
}