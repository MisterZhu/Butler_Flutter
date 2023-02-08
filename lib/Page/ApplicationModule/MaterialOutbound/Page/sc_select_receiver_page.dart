
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../../Utils/sc_utils.dart';
import '../View/AddOutbound/sc_receiver_listview.dart';

/// 选择领用人page

class SCSelectReceiverPage extends StatefulWidget {
  @override
  SCSelectReceiverPageState createState() => SCSelectReceiverPageState();
}

class SCSelectReceiverPageState extends State<SCSelectReceiverPage> {

  int receiverIndex = -1;

  @override
  initState() {
    super.initState();
    var arguments = Get.arguments;
    if (arguments != null) {
      receiverIndex = arguments['receiverIndex'];
    }
  }

  List list = ['张三', '旺旺'];

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "选择领用人",
        centerTitle: true,
        elevation: 0,
        body: body());
  }

  Widget body() {
    return GestureDetector(
      onTap: () {
        SCUtils().hideKeyboard(context: context);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: SCColors.color_F2F3F5,
        child: SCReceiverListView(
          currentIndex: receiverIndex, list: list, tapAction: (index) {
            receiverIndex = index;
            SCRouterHelper.back({'receiver': list[index], 'receiverIndex': index});
        },),
      ),
    );
  }

}



