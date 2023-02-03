
import 'package:flutter/cupertino.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/AddReceipt/sc_material_info_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/AddReceipt/sc_pickup_info_cell.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../HouseInspect/View/sc_bottom_button_item.dart';

/// 新增入库listview

class SCAddReceiptListView extends StatelessWidget {

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
        SCBottomButtonItem(list: const ['保存', '提交'], buttonType: 1, leftTapAction: () {
          /// 保存
          //SCRouterHelper.pathPage(SCRouterPath.houseInspectFormPage, null);
        }, rightTapAction: () {
          /// 提交
          //SCRouterHelper.pathPage(SCRouterPath.houseInspectProblemPage, null);
        },),
      ],
    );
  }

  /// listview
  Widget listview(BuildContext context) {
    return ListView.separated(
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
      return SCPickupInfoCell();
    } else if (index == 1) {
      return SCMaterialInfoCell(addAction: () {
        SCRouterHelper.pathPage(SCRouterPath.addMaterialPage, null);
      },);
    } else {
      return const SizedBox(height: 10,);
    }
  }

}
