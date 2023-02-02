
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Constants/sc_asset.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../../Utils/sc_utils.dart';
import '../View/sc_material_entry_listview.dart';
import '../View/sc_material_search_item.dart';
import '../View/sc_material_sift_item.dart';

/// 物资入库page

class SCMaterialEntryPage extends StatefulWidget {
  @override
  SCMaterialEntryPageState createState() => SCMaterialEntryPageState();
}

class SCMaterialEntryPageState extends State<SCMaterialEntryPage> {

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "物资入库", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: Column(
        children: [
          SCMaterialSearchItem(),
          SCMaterialSiftItem(),
          Expanded(child: contentItem())
        ],
      ),
    );
  }

  /// contentItem
  Widget contentItem() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        SCMaterialEntryListView(),
        addItem(),
      ],
    );
  }

  /// 新增入库按钮
  Widget addItem() {
    return Padding(
      padding: EdgeInsets.only(right: 16.0, bottom: SCUtils().getBottomSafeArea() + 40),
      child: Container(
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(color: SCColors.color_E3E3E5, width: 0.5)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(SCAsset.iconAddReceipt, width: 20.0, height: 20.0,),
            const SizedBox(width: 2.0,),
            const Text(
                '新增入库',
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SCFonts.f11,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_1B1D33)),
          ],
        ),
      ),
    );
  }
}
