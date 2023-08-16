import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Constants/sc_asset.dart';

/// 底部全选view

class SCBottomCheckAllView extends StatefulWidget {
  SCBottomCheckAllViewState createState() => SCBottomCheckAllViewState();
}

class SCBottomCheckAllViewState extends State<SCBottomCheckAllView> {

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
          left: 8.0,
          top: 7.0,
          right: 16.0,
          bottom: bottomSafeArea + 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {

            },
            child: Container(
              width: 38.0,
              height: 38.0,
              alignment: Alignment.center,
              child: Image.asset(
                  isSelect
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

  /// 确定
  sureAction() {

  }

  /// 获取已选数量
  int getSelectedNumber() {
    int num = 0;
    return num;
  }
}