
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/View/Detail/sc_warning_detail_text_cell.dart';
import '../../Controller/sc_warning_detail_controller.dart';
import '../../Model/sc_warning_emergencycontacts_model.dart';

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
    List spaceInfoList = [
      {'name': '空间名称', 'content': state.spaceModel.name, 'isContact': false},
      {'name': '空间类型', 'content': state.spaceModel.typeNameFlag, 'isContact': false},
      {'name': '地址', 'content': state.spaceModel.address, 'isContact': false},
      // {'name': '联系人', 'content': state.spaceModel.contacts, 'isContact': false},
      // {'name': '联系人电话', 'content': state.spaceModel.contactsPhone, 'isContact': true, 'mobile': state.spaceModel.contactsPhone},
    ];

    if (state.emergencyContactsList.isNotEmpty) {
      for (int i = 0; i < state.emergencyContactsList.length; i++) {
        SCWarningEmergencyContactsModel model = state.emergencyContactsList[i];
        String des = '';
        if (i == 0) {
           des = '一级联系人';
        } else if (i == 1) {
          des = '二级联系人';
        } else if (i == 2) {
          des = '三级联系人';
        } else if (i == 3) {
          des = '四级联系人';
        } else if (i == 4) {
          des = '五级联系人';
        } else if (i == 5) {
          des = '六级联系人';
        } else if (i == 6) {
          des = '七级联系人';
        } else if (i == 7) {
          des = '八级联系人';
        } else if (i == 8) {
          des = '九级联系人';
        } else if (i == 9) {
          des = '十级联系人';
        } else {
          des = '${i+1}级联系人';
        }
        var params = {'name': des, 'content': model.userInfo?.userName, 'isContact': true, 'mobile': model.userInfo?.mobileNum};
        spaceInfoList.add(params);
      }
    }

    return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var dic = spaceInfoList[index];
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
        itemCount: spaceInfoList.length);
  }
}