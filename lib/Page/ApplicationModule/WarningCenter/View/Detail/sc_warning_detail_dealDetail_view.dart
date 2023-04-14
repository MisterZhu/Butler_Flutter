
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/View/Detail/sc_warning_detail_text_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/View/Detail/sc_warning_detail_photos_item.dart';
import '../../Controller/sc_warning_detail_controller.dart';

/// 预警详情-处理明细
class SCWarningDetailDealDetailView extends StatelessWidget {

  /// SCWarningDetailController
  final SCWarningDetailController state;

  SCWarningDetailDealDetailView({Key? key, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        listview(),
        const SizedBox(height: 6.0,),
        SCWarningDetailPhotosItem(state: state),
      ],
    );
  }

  Widget listview() {
    List dealDetailList = [
      {'name': '处理人', 'content': state.detailModel.operatorName},
      {'name': '处理时间', 'content': state.detailModel.endTime},
      {'name': '处理结果', 'content': state.detailModel.confirmResultName},
    ];
    return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 12.0),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var dic = dealDetailList[index];
          return SCWarningDetailTextCell(
            leftText: dic['name'],
            rightText: dic['content'],
            isContact: dic['isContact'] ?? false,
            mobile: dic['mobile'],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 12.0,);
        },
        itemCount: dealDetailList.length);
  }
}