
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/View/Detail/sc_warning_detail_cell_item.dart';
import '../../Controller/sc_warning_detail_controller.dart';
import '../../Model/sc_warningcenter_detail_model.dart';

/// 预警详情-预警明细
class SCWarningDetailWarnDetailView extends StatelessWidget {

  /// SCWarningDetailController
  final SCWarningDetailController state;

  SCWarningDetailWarnDetailView({Key? key, required this.state})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return listview();
  }

  Widget listview() {
    return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          SCAlertDetailedVs model = state.detailModel.alertDetailedVS![index];
          return SCWarningDetailCellItem(model: model, status: state.detailModel.status,);
        },
        separatorBuilder: (BuildContext context, int index) {
          return lineItem();
        },
        itemCount: (state.detailModel.alertDetailedVS ?? []).length);
  }

  /// lineItem
  Widget lineItem() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Container(
        height: 0.5,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

}