
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../View/sc_to_be_upload_listview.dart';

/// 待上传事项page

class SCToBeUploadPage extends StatefulWidget {
  @override
  SCToBeUploadPageState createState() => SCToBeUploadPageState();
}

class SCToBeUploadPageState extends State<SCToBeUploadPage> {

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "待上传事项",
        centerTitle: true,
        elevation: 0,
        actions: [allUploadItem()],
        body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: SCToBeUploadListView(),
    );
  }

  /// 全部上传
  Widget allUploadItem() {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      minSize: 60.0,
      child: const Text(
        '全部上传',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_4285F4,
        ),
      ),
      onPressed: () {

      });
  }

}