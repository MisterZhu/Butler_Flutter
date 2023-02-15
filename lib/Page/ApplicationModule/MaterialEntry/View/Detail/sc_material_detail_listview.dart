import 'package:flutter/material.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_material_info_cell.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../Controller/sc_material_entry_detail_controller.dart';
import 'sc_allmaterial_cell.dart';

/// 入库详情-listview
class SCMaterialDetailListView extends StatelessWidget {

  /// SCMaterialEntryDetailController
  final SCMaterialEntryDetailController state;

  /// 类型，type=0入库详情，type=1出库详情
  final int type;

  SCMaterialDetailListView({Key? key, required this.state, required this.type}) : super(key: key);

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
      return SCAllMaterialCell(type: type, model: state.model);
    // } else if(index == 1) {// 审批流程
    //   return SCMaterialApproveFlowCell(title: '审批流程', onTap: () {
    //
    //   },);
    } else {// 入库信息
      return SCMaterialEntryInfoCell(model: state.model, callAction: (String phone) {
        callAction(phone);
      },);
    }
  }

  /// 打电话
  callAction(String phone) {
    SCUtils.call(phone);
  }

  /// line
  Widget line(int index) {
    return const SizedBox(
      height: 10.0,
    );
  }
}