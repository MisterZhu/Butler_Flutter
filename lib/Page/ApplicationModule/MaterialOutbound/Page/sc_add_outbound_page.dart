
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../../Utils/sc_utils.dart';
import '../View/AddOutbound/sc_add_outbound_view.dart';

/// 新增出库page

class SCAddOutboundPage extends StatefulWidget {
  @override
  SCAddOutboundPageState createState() => SCAddOutboundPageState();
}

class SCAddOutboundPageState extends State<SCAddOutboundPage> {

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "新增出库",
        centerTitle: true,
        elevation: 0,
        resizeToAvoidBottomInset: false, /// 页面不会随着键盘上移
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
        child: SCAddOutboundView(),
      ),
    );
  }

}



