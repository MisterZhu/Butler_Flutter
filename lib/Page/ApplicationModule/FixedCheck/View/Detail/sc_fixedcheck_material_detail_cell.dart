import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_entry_model.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../../Utils/sc_utils.dart';

/// 物资详情cell

enum SCFixedCheckMaterialDetailCellType {
  using,

  /// 使用中
  reportedLoss

  /// 已报损
}

class SCFixedCheckMaterialDetailCell extends StatelessWidget {
  /// cell类型
  final SCFixedCheckMaterialDetailCellType cellType;

  /// model
  final SCMaterialEntryModel? model;

  /// 打电话
  final Function(String phone)? callAction;

  /// 按钮点击
  final Function? btnTapAction;

  /// 详情
  final Function? detailTapAction;

  final bool? hideBtn;

  final String? btnText;

  SCFixedCheckMaterialDetailCell({
    Key? key,
    required this.cellType,
    this.model,
    this.hideBtn,
    this.btnText,
    this.callAction,
    this.btnTapAction,
    this.detailTapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return GestureDetector(
      onTap: () {
        detailTapAction?.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(4.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleView(),
            const SizedBox(
              height: 12.0,
            ),
            nameItem('物资1'),
            const SizedBox(
              height: 4.0,
            ),
            const SizedBox(
              height: 6.0,
            ),
            infoView('使用部门：开发部', '使用人：周小善'),
            Offstage(
              offstage: cellType == SCFixedCheckMaterialDetailCellType.using ? true : false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 6.0,
                  ),
                  infoView('报损原因：丢失报损', '')
                ],
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            line(),
            const SizedBox(
              height: 12.0,
            ),
            bottomItem()
          ],
        ),
      ),
    );
  }

  /// title
  Widget titleView() {
    String statusDesc = SCUtils.getEntryStatusText(0);
    Color statusColor = SCUtils.getEntryStatusTextColor(0);
    statusDesc = SCUtils.getEntryStatusText(0);
    statusColor = SCUtils.getEntryStatusTextColor(0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text('资产编号：ZCC789899',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_1B1D33)),
          ),
        ],
      ),
    );
  }

  /// nameItem
  Widget nameItem(String name) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w500,
              color: SCColors.color_1B1D33),
        ));
  }

  /// 地址等信息
  Widget infoView(String title1, String title2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Text(
                title1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: SCFonts.f12,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_5E5F66),
              )),
          Expanded(
              flex: 1,
              child: Text(
                title2,
                maxLines: 1,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: SCFonts.f12,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_5E5F66),
              ))
        ],
      ),
    );
  }

  /// 横线
  Widget line() {
    return const Padding(
      padding: EdgeInsets.only(left: 12.0),
      child: Divider(
        height: 0.5,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  /// bottomItem
  Widget bottomItem() {
    bool showBtn = true;

    String btnTitle = '报损';
    if (cellType == SCFixedCheckMaterialDetailCellType.using) {
      btnTitle = '报损';
    } else {
      btnTitle = '取消报损';
    }
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Text(
              '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_5E5F66),
            )),
            SizedBox(
              width: 100.0,
              height: 40.0,
              child: Offstage(
                offstage: !showBtn,
                child: CupertinoButton(
                    alignment: Alignment.center,
                    borderRadius: BorderRadius.circular(4.0),
                    minSize: 40.0,
                    color: SCColors.color_4285F4,
                    padding: EdgeInsets.zero,
                    child: Text(
                      btnTitle,
                      style: const TextStyle(
                          fontSize: SCFonts.f16,
                          fontWeight: FontWeight.w400,
                          color: SCColors.color_FFFFFF),
                    ),
                    onPressed: () {
                      btnTapAction?.call();
                    }),
              ),
            )
          ],
        ));
  }
}
