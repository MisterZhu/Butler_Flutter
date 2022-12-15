
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../GetXController/sc_personal_info_controller.dart';
import '../View/sc_personal_info_listview.dart';

/// 个人资料page

class SCPersonalInfoPage extends StatefulWidget {
  @override
  SCPersonalInfoPageState createState() => SCPersonalInfoPageState();
}

class SCPersonalInfoPageState extends State<SCPersonalInfoPage> {

  SCPersonalInfoController state = Get.put(SCPersonalInfoController());

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "个人资料", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCPersonalInfoController>(builder: (state){
        return SCPersonalInfoListView(
          userHeadPicUrl: state.userHeadPicUrl,
        );
      }),
    );
  }
}