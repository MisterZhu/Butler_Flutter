import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import '../../../../../Network/sc_config.dart';
import '../../../../../Utils/Preview/sc_image_preview_utils.dart';
import '../../../MaterialEntry/Model/sc_material_task_detail_model.dart';

/// 资产维保详情信息cell

class SCMaintenanceDetailInfoCell extends StatelessWidget {
  /// model
  final SCMaterialTaskDetailModel? model;

  /// 打电话
  final Function(String phone)? callAction;

  /// 复制粘贴板
  final Function(String value)? pasteAction;

  SCMaintenanceDetailInfoCell(
      {Key? key, this.model, this.callAction, this.pasteAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: SCColors.color_FFFFFF,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            entryNumView(),
            const SizedBox(
              height: 12.0,
            ),
            operatorView(),
            const SizedBox(
              height: 12.0,
            ),
            maintenanceUserView(),
            const SizedBox(
              height: 12.0,
            ),
            maintenanceTypeView(),
            const SizedBox(
              height: 12.0,
            ),
            departmentView(),
            const SizedBox(
              height: 12.0,
            ),
            startTimeView(),
            const SizedBox(
              height: 12.0,
            ),
            endTimeView(),
            SizedBox(
              height: model?.remark == "" || model?.remark == null ? 0.0 : 12.0,
            ),
            entryRemarkView(),
            attachmentView(),
            photosItem()
          ],
        ),
      ),
    );
  }

  /// 单号
  Widget entryNumView() {
    return Row(
      children: [desLabel('单号'), numView(model?.number ?? '')],
    );
  }

  /// 操作人view
  Widget operatorView() {
    return Row(
      children: [
        desLabel('操作人'),
        contactView('${model?.reportUserName}', model?.reportManMobileNum ?? '')
      ],
    );
  }

  /// 维保负责人view
  Widget maintenanceUserView() {
    return Row(
      children: [
        desLabel('维保负责人'),
        contactView('${model?.reportUserName}', model?.reportManMobileNum ?? '')
      ],
    );
  }

  /// 维保类型view
  Widget maintenanceTypeView() {
    return Row(
      children: [desLabel('维保类型'), textView(1, model?.reportOrgName ?? '')],
    );
  }

  /// 维保部门
  Widget departmentView() {
    return Row(
      children: [desLabel('维保部门'), textView(1, model?.dealStartTime ?? '')],
    );
  }

  /// 开始时间
  Widget startTimeView() {
    return Row(
      children: [desLabel('开始时间'), textView(1, model?.reportTime ?? '')],
    );
  }

  /// 结束时间
  Widget endTimeView() {
    return Row(
      children: [desLabel('结束时间'), textView(1, model?.reportTime ?? '')],
    );
  }

  /// 备注
  Widget entryRemarkView() {
    return Offstage(
      offstage: model?.remark == "" || model?.remark == null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [desLabel('备注'), textView(100, '${model?.remark}')],
      ),
    );
  }

  /// 附件
  Widget attachmentView() {
    List<Widget> itemList = [];
    for (int i=0; i<3; i++) {
      itemList.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [desLabel(i == 0 ? '附件' : ''), textView(100, '附件${i+1}')],
      ));
    }
    return Offstage(
      offstage: false,
      child: Column(
        children: itemList,
      ),
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
        strutStyle: const StrutStyle(
          fontSize: SCFonts.f14,
          height: 1.25,
          forceStrutHeight: true,
        ),
        style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_5E5F66,
        ),
      ),
    );
  }

  /// 联系人
  Widget contactView(String name, String mobile) {
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
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: SCFonts.f14,
                          fontWeight: FontWeight.w400,
                          color: SCColors.color_1B1D33),
                    ),
                    SizedBox(
                      width: name.isEmpty ? 0.0 : 8.0,
                    ),
                    Offstage(
                      offstage: name.isEmpty,
                      child: Image.asset(
                        SCAsset.iconContactPhone,
                        width: 20.0,
                        height: 20.0,
                      ),
                    ),
                  ],
                )
              ],
            ),
            onPressed: () {
              callAction?.call(mobile);
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
                  width: 4.0,
                ),
                Image.asset(
                  SCAsset.iconMaterialCopy,
                  width: 12.0,
                  height: 12.0,
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
      strutStyle: const StrutStyle(
        fontSize: SCFonts.f14,
        height: 1.25,
        forceStrutHeight: true,
      ),
      style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_1B1D33),
    ));
  }

  /// photosItem
  Widget photosItem() {
    if (model?.files != null) {
      return StaggeredGridView.countBuilder(
          padding: const EdgeInsets.only(
            top: 16.0,
          ),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          crossAxisCount: 4,
          shrinkWrap: true,
          itemCount: model?.files?.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return photoItem(index);
          },
          staggeredTileBuilder: (int index) {
            return const StaggeredTile.fit(1);
          });
    } else {
      return const SizedBox();
    }
  }

  /// 图片
  Widget photoItem(int index) {
    Files? file = model?.files?[index];
    String fileKey = file?.fileKey ?? '';
    String url = SCConfig.getImageUrl(fileKey);
    return GestureDetector(
      onTap: () {
        previewImage(url);
      },
      child: SizedBox(
          width: 79.0,
          height: 79.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: SCImage(
              url: url,
              width: 79.0,
              height: 79.0,
              fit: BoxFit.fill,
            ),
          )),
    );
  }

  /// 图片预览
  previewImage(String url) {
    SCImagePreviewUtils.previewImage(imageList: [url]);
  }
}
