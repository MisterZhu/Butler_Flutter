import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../Model/sc_material_entry_detail_model.dart';

/// 入库信息cell

class SCMaterialEntryInfoCell extends StatelessWidget {
  /// model
  final SCMaterialEntryDetailModel? model;

  /// type=entry入库详情，type=outbound出库详情
  final SCWarehouseManageType type;

  /// 打电话
  final Function(String phone)? callAction;

  /// 复制粘贴板
  final Function(String value)? pasteAction;

  SCMaterialEntryInfoCell({Key? key, this.model, required this.type, this.callAction, this.pasteAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(decoration: BoxDecoration(
      color: SCColors.color_FFFFFF,
      borderRadius: BorderRadius.circular(4.0),
    ), child: Padding(padding: const EdgeInsets.all(12.0), child: Column(
      children: [
        entryNumView(),
        const SizedBox(
          height: 10.0,
        ),
        entryUserView(),
        const SizedBox(
          height: 10.0,
        ),
        entryTimeView(),
        const SizedBox(
          height: 10.0,
        ),
        receiveView(),
        entryRemarkView()
      ],
    ),),);
  }

  Widget receiveView() {
    if (type == SCWarehouseManageType.outbound && model?.typeName == '领料出库') {
      // 领料出库才显示领用人
      return Column(
          children: [
            userView(),
            const SizedBox(
              height: 10.0,
            ),
            userDepartmentView(),
            const SizedBox(
              height: 10.0,
            ),
          ]
      );
    } else {
      return const SizedBox();
    }
  }

  /// 领用人view
  Widget userView() {
    return Row(
      children: [
        desLabel('领用人'),
        contactView(model?.fetchUserName ?? '')
      ],
    );
  }

  /// 领用部门view
  Widget userDepartmentView() {
    return Row(
      children: [
        desLabel('领用部门'),
        textView(1, model?.fetchOrgName ?? '')
      ],
    );
  }

  /// 操作人view
  Widget entryUserView() {
    return Row(
      children: [
        desLabel('操作人'),
        contactView('${model?.creatorName}')
      ],
    );
  }

  /// 单号
  Widget entryNumView() {
    return Row(
      children: [
        desLabel('单号'),
        numView('${model?.number}')
      ],
    );
  }

  /// 操作时间
  Widget entryTimeView() {
    return Row(
      children: [
        desLabel('操作时间'),
        textView(1, '${model?.gmtCreate}')
      ],
    );
  }

  /// 备注
  Widget entryRemarkView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [desLabel('备注'), textView(10, '${model?.remark}')],
    );
  }

  /// description-label
  Widget desLabel(String text) {
    return SizedBox(
      width: 100.0,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: SCColors.color_5E5F66),
      ),
    );
  }

  /// 联系人
  Widget contactView(String name) {
    return Expanded(
        child: CupertinoButton(
            minSize: 22.0,
            padding: EdgeInsets.zero,
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Offstage(
                      offstage: name.isEmpty,
                      child: Image.asset(
                        SCAsset.iconPhone,
                        width: 20.0,
                        height: 20.0,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: SCFonts.f14,
                          fontWeight: FontWeight.w400,
                          color: SCColors.color_1B1D33),
                    )
                  ],
                )
              ],
            ),
            onPressed: () {
              callAction?.call(model?.mobileNum ?? '');
            }));
  }

  /// 单号
  Widget numView(String num) {
    return Expanded(
        child: CupertinoButton(
            minSize: 22.0,
            padding: EdgeInsets.zero,
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  num,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: SCFonts.f14,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_1B1D33),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Image.asset(
                  SCAsset.iconMaterialCopy,
                  width: 20.0,
                  height: 20.0,
                ),
              ],
            ),
            onPressed: () {
              pasteAction?.call(num);
            }));
  }

  /// 普通label
  Widget textView(int maxLines, String text) {
    return Expanded(
        child: Text(
      text,
      textAlign: TextAlign.right,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_1B1D33),
    ));
  }
}
