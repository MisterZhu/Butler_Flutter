
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/View/Detail/sc_warning_detail_text_cell.dart';
import '../../Controller/sc_warning_detail_controller.dart';

/// 预警详情-空间信息
class SCWarningDetailSpaceInfoView extends StatelessWidget {

  /// SCWarningDetailController
  final SCWarningDetailController state;

  SCWarningDetailSpaceInfoView({Key? key, required this.state})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return listview();
  }

  /// body
  Widget listview() {
    return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var dic = state.spaceInfoList[index];
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
        itemCount: state.spaceInfoList.length);
  }
}