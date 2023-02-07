import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../MaterialEntry/sc_material_search_item.dart';
import '../MaterialEntry/sc_material_sift_item.dart';
import '../SelectCategoryAlert/sc_add_material_selectcategory_alert.dart';
import 'sc_add_material_listview.dart';

/// 添加物资view

class SCAddMaterialView extends StatefulWidget {
  @override
  SCAddMaterialViewState createState() => SCAddMaterialViewState();
}

class SCAddMaterialViewState extends State<SCAddMaterialView> {
  bool allSelected = false;

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SCMaterialSearchItem(
          searchAction: () {
            SCRouterHelper.pathPage(SCRouterPath.materialSearchPage, null);
          },
        ),
        SCMaterialSiftItem(
          tagList: const ['分类'],
          tapAction: (index) {
            showCategoryAlert();
          },
        ),
        Expanded(child: listview(context)),
        bottomItem(),
      ],
    );
  }

  /// listview
  Widget listview(BuildContext context) {
    return SCAddMaterialListView();
  }

  Widget getCell(int index) {
    return Container(
      color: SCColors.color_FFFFFF,
      height: 40,
    );
  }

  /// bottomItem
  Widget bottomItem() {
    return Container(
      width: double.infinity,
      height: 54.0 + SCUtils().getBottomSafeArea(),
      color: SCColors.color_FFFFFF,
      padding: EdgeInsets.only(
          left: 8.0,
          top: 7.0,
          right: 16.0,
          bottom: SCUtils().getBottomSafeArea() + 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                allSelected = !allSelected;
              });
            },
            child: Container(
              width: 38.0,
              height: 38.0,
              alignment: Alignment.center,
              child: Image.asset(
                  allSelected
                      ? SCAsset.iconMaterialSelected
                      : SCAsset.iconMaterialUnselect,
                  width: 22.0,
                  height: 22.0),
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('全选',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: SCFonts.f14,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_1B1D33)),
              Text('已选0项',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: SCFonts.f12,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_5E5F66))
            ],
          )),
          const SizedBox(
            width: 8.0,
          ),
          Container(
              width: 120.0,
              height: 40.0,
              decoration: BoxDecoration(
                  color: SCColors.color_4285F4,
                  borderRadius: BorderRadius.circular(4.0)),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text(
                  '确定',
                  style: TextStyle(
                    fontSize: SCFonts.f16,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_FFFFFF,
                  ),
                ),
                onPressed: () {},
              ))
        ],
      ),
    );
  }

  /// 分类弹窗
  showCategoryAlert() {
    SCDialogUtils().showCustomBottomDialog(
        context: context,
        isDismissible: true,
        widget: SCSelectCategoryAlert());
  }
}
