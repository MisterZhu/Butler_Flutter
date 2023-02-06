
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../View/Search/sc_material_search_view.dart';

/// 物资入库page

class SCMaterialSearchPage extends StatefulWidget {
  @override
  SCMaterialSearchPageState createState() => SCMaterialSearchPageState();
}

class SCMaterialSearchPageState extends State<SCMaterialSearchPage> {
  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "搜索",
        centerTitle: true,
        elevation: 0,
        resizeToAvoidBottomInset: false, /// 页面不会随着键盘上移
        body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: SCMaterialSearchView(),
    );
  }

}
