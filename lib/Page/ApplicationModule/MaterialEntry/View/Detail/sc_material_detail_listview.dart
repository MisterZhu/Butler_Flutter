import 'package:flutter/material.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_material_approveflow_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_material_info_cell.dart';

import 'sc_allmaterial_cell.dart';

/// 入库详情-listview
class SCMaterialDetailListView extends StatelessWidget {

  const SCMaterialDetailListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        itemBuilder: (BuildContext context, int index){
      return cell(index);
    }, separatorBuilder: (BuildContext context, int index){
      return line(index);
    }, itemCount: 3);
  }

  /// cell
  Widget cell(int index) {
    if (index == 0) {// 所有物资
      return SCAllMaterialCell();
    } else if(index == 1) {// 审批流程
      return SCMaterialApproveFlowCell(title: '审批流程', onTap: () {
        
      },);
    } else {// 入库信息
      return SCMaterialEntryInfoCell();
    }
  }

  /// line
  Widget line(int index) {
    return const SizedBox(
      height: 10.0,
    );
  }
}