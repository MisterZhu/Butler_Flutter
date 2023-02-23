import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';

import '../../../../Utils/sc_utils.dart';
import '../View/SelectCategory/sc_check_selectcategory_view.dart';

/// 盘点任务-选择分类page

class SCMaterialCheckSelectCategoryPage extends StatefulWidget {
  @override
  SCMaterialCheckSelectCategoryPageState createState() => SCMaterialCheckSelectCategoryPageState();
}

class SCMaterialCheckSelectCategoryPageState extends State<SCMaterialCheckSelectCategoryPage> {

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "选择分类",
        centerTitle: true,
        elevation: 0,
        resizeToAvoidBottomInset: true,
        body: body()
    );
  }

  /// body
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
        child: SCCheckSelectCategoryView(),
      ),
    );
  }
}