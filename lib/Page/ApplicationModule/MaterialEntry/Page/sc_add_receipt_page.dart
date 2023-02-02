
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';

/// 新增入库page

class SCAddReceiptPage extends StatefulWidget {
  @override
  SCAddReceiptPageState createState() => SCAddReceiptPageState();
}

class SCAddReceiptPageState extends State<SCAddReceiptPage> {

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "新增入库", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: Column(
        children: [

        ],
      ),
    );
  }

}



