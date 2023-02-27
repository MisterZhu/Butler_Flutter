import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../../Constants/sc_asset.dart';

/// 物资分类底部全选view

class SCCheckCategoryBottomView extends StatefulWidget {
  const SCCheckCategoryBottomView(
      {Key? key, this.selectAllAction, this.sureAction})
      : super(key: key);

  /// 全选
  final Function(bool isSelect)? selectAllAction;

  /// 确定
  final Function? sureAction;

  SCCheckCategoryBottomViewState createState() =>
      SCCheckCategoryBottomViewState();
}

class SCCheckCategoryBottomViewState extends State<SCCheckCategoryBottomView> {
  /// 全选
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    double bottomSafeArea = MediaQuery.of(context).padding.bottom;
    return Container(
      width: double.infinity,
      height: 54.0 + bottomSafeArea,
      color: SCColors.color_FFFFFF,
      padding: EdgeInsets.only(
          left: 17.0, top: 7.0, right: 16.0, bottom: bottomSafeArea + 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              selectAllAction();
            },
            child: Container(
              width: 70.0,
              height: 38.0,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Image.asset(
                      isSelect
                          ? SCAsset.iconMaterialSelected
                          : SCAsset.iconMaterialUnselect,
                      width: 22.0,
                      height: 22.0),
                  const SizedBox(
                    width: 9.0,
                  ),
                  const Text('全选',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: SCFonts.f14,
                          fontWeight: FontWeight.w400,
                          color: SCColors.color_1B1D33))
                ],
              ),
            ),
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

  /// 全选
  selectAllAction() {
    setState(() {
      isSelect = !isSelect;
      widget.selectAllAction?.call(isSelect);
    });
  }

  /// 确定
  sureAction() {
    widget.sureAction?.call();
  }
}
