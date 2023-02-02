import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/Signature/sc_house_inspect_signature_view.dart';

import '../../../../Utils/sc_utils.dart';
import '../View/Signature/sc_signature.dart';

/// 签名page

class SCHouseInspectSignaturePage extends StatefulWidget {
  @override
  SCHouseInspectSignaturePageState createState() => SCHouseInspectSignaturePageState();
}

class SCHouseInspectSignaturePageState extends State<SCHouseInspectSignaturePage> {

  late SignatureController controller;

  @override
  initState() {
    super.initState();
    SCUtils().hideTopStatusBar();
    controller = SignatureController(
      penStrokeWidth: 3,
      penColor: SCColors.color_1B1D33,
      exportBackgroundColor: Colors.transparent,
      exportPenColor: SCColors.color_1B1D33,
      onDrawStart: () => {},
      onDrawEnd: () => {},
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RotatedBox(quarterTurns: 0, child: Container(
        width: double.infinity,
        height: double.infinity,
        child: SCSignatureView(
          controller: controller,
        ),
      )),
    );
  }
}