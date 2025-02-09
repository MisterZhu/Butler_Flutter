import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';

import '../../../../../Constants/sc_asset.dart';
import '../../../../../Constants/sc_default_value.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../Controller/sc_add_material_controller.dart';
import '../../Controller/sc_purchase_selectmaterial_controller.dart';
import '../../Model/sc_material_list_model.dart';
import '../AddMaterial/sc_add_material_listview.dart';
import '../Detail/sc_material_cell.dart';

/// 采购单-选择物资view

class SCPurchaseSelectMaterialView extends StatefulWidget {
  SCPurchaseSelectMaterialView({
    Key? key,
    required this.state,
  }) : super(key: key);

  /// SCPurchaseSelectMaterialController
  final SCPurchaseSelectMaterialController state;

  @override
  SCPurchaseSelectMaterialViewState createState() =>
      SCPurchaseSelectMaterialViewState();
}

class SCPurchaseSelectMaterialViewState
    extends State<SCPurchaseSelectMaterialView> {
  /// 全选
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
    return ListView.separated(
        padding: const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line(index);
        },
        itemCount: widget.state.allMaterialList.length);
  }

  /// cell
  Widget getCell(int index) {
    SCMaterialListModel model = widget.state.allMaterialList[index];
    return SCMaterialCell(
      hideMaterialNumTextField: true,
      model: model,
      type: scMaterialCellTypeRadio,
      check: false,
      radioTap: (bool value) {
        model.isSelect = value;
      },
    );
  }

  /// line
  Widget line(int index) {
    return const SizedBox(
      height: 10.0,
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
                for (SCMaterialListModel model in widget.state.allMaterialList) {
                  model.isSelect = allSelected;
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
    for (SCMaterialListModel model in widget.state.allMaterialList) {
      bool isSelect = model.isSelect ?? false;
      if (isSelect) {
        num += 1;
      }
    }
    return num;
  }

  /// 确定
  sureAction() {
    List<SCMaterialListModel> list = [];
    for (SCMaterialListModel model in widget.state.allMaterialList) {
      bool isSelect = model.isSelect ?? false;
      if (isSelect) {
        list.add(model);
      }
    }
    if (list.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectMaterialTip);
    } else {
      SCRouterHelper.back({"materialList" : list});
    }
  }
}
