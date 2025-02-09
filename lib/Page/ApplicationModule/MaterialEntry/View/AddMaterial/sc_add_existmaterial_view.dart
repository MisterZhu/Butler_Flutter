import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_list_model.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../PropertyFrmLoss/Model/sc_property_list_model.dart';
import '../../Controller/sc_add_material_controller.dart';
import 'sc_add_material_listview.dart';

/// 添加物资view

class SCAddExitsMaterialView extends StatefulWidget {
  SCAddExitsMaterialView(
      {Key? key,
      required this.state,
      required this.refreshController,
      this.sureAction})
      : super(key: key);

  /// SCAddMaterialController
  final SCAddMaterialController state;

  /// 确定
  final Function(List<SCMaterialListModel> list)? sureAction;

  /// RefreshController
  final RefreshController refreshController;

  @override
  SCAddExitsMaterialViewState createState() => SCAddExitsMaterialViewState();
}

class SCAddExitsMaterialViewState extends State<SCAddExitsMaterialView> {
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
        Expanded(child: listview(context)),
        bottomItem(),
      ],
    );
  }

  /// listview
  Widget listview(BuildContext context) {
    return SCAddMaterialListView(
      state: widget.state,
      refreshController: widget.refreshController,
      list: widget.state.materialList,
      propertyList: widget.state.propertyList,
      radioTap: () {
        setState(() {});
      },
    );
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
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                allSelected = !allSelected;
                if (widget.state.isProperty == true) {
                  for (SCMaterialListModel model in widget.state.propertyList) {
                    model.isSelect = allSelected;
                  }
                } else {
                  for (SCMaterialListModel model in widget.state.materialList) {
                    model.isSelect = allSelected;
                  }
                }
                widget.state.update();
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
            children: [
              const Text('全选',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: SCFonts.f14,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_1B1D33)),
              Text('已选${getSelectedNumber()}项',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
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
                onPressed: () {
                  sureAction();
                },
              ))
        ],
      ),
    );
  }

  /// 获取已选数量
  int getSelectedNumber() {
    int num = 0;
    for (SCMaterialListModel model in widget.state.materialList) {
      bool isSelect = model.isSelect ?? false;
      if (isSelect) {
        num += 1;
      }
    }
    return num;
  }

  /// 确定
  sureAction() {
    // List<SCMaterialListModel> list = [];
    // for (SCMaterialListModel model in widget.state.materialList) {
    //   bool isSelect = model.isSelect ?? false;
    //   if (isSelect) {
    //     list.add(model);
    //   }
    // }
    // if (list.isEmpty) {
    //   SCToast.showTip(SCDefaultValue.selectMaterialTip);
    // } else {
    //   widget.sureAction?.call(list);
    // }
  }
}
