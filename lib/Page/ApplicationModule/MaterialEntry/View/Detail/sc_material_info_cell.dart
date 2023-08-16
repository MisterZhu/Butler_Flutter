import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../../Network/sc_config.dart';
import '../../../../../Utils/Preview/sc_image_preview_utils.dart';
import '../../Model/sc_material_task_detail_model.dart';

/// 入库信息cell

class SCMaterialEntryInfoCell extends StatelessWidget {
  /// model
  final SCMaterialTaskDetailModel? model;

  /// type=entry入库详情，type=outbound出库详情
  final SCWarehouseManageType type;

  /// 是否是领料出入库
  final bool? isLL;

  /// 打电话
  final Function(String phone)? callAction;

  /// 复制粘贴板
  final Function(String value)? pasteAction;

  SCMaterialEntryInfoCell(
      {Key? key,
      this.model,
      required this.type,
      this.isLL,
      this.callAction,
      this.pasteAction})
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
            middleView(),
            SizedBox(
              height: model?.remark == "" || model?.remark == null ? 0.0 : 12.0,
            ),
            entryRemarkView(),
            photosItem()
          ],
        ),
      ),
    );
  }

  Widget middleView() {
    if (type == SCWarehouseManageType.check) {
      // 盘点任务，显示任务开始时间、结束时间、盘点时间、仓库名称
      return Column(children: [
        dealUserNameView(),
        const SizedBox(
          height: 12.0,
        ),
        dealOrgNameView(),
        const SizedBox(
          height: 12.0,
        ),
        taskStartTimeView(),
        const SizedBox(
          height: 12.0,
        ),
        taskEndTimeView(),
        SizedBox(
          height: model?.dealStartTime == null ? 0.0 : 12.0,
        ),
        dealTimeView(),
        const SizedBox(
          height: 12.0,
        ),
        wareHouseView(),
      ]);
    } else {
      return Column(
        children: [
          entryUserView(),
          const SizedBox(
            height: 12.0,
          ),
          entryTimeView(),
          receiveView(),
        ],
      );
    }
  }

  Widget receiveView() {
    if (isLL == true) {
      if (model?.workOrderNumber != null) {
        return Column(children: [
          const SizedBox(
            height: 10.0,
          ),
          workOrderNumberView()
        ]);
      } else {
        return const SizedBox();
      }
    } else {
      if (type == SCWarehouseManageType.outbound) {
        // 领料出库才显示领用人
        if ( model?.typeName == '领料出库' ||  model?.typeName == '维修领料' ||  model?.typeName == '资产领用出库') {
          return Column(children: [
            const SizedBox(
              height: 10.0,
            ),
            userView(),
            const SizedBox(
              height: 10.0,
            ),
            userDepartmentView(),
          ]);
        } else {
          return const SizedBox();
        }
      } else if (type == SCWarehouseManageType.transfer) {
        // 物料调拨，显示调入仓库、调出仓库
        return Column(children: [
          const SizedBox(
            height: 10.0,
          ),
          inWareHouseView(),
          const SizedBox(
            height: 10.0,
          ),
          outWareHouseView(),
        ]);
      } else if (type == SCWarehouseManageType.frmLoss) {
        // 物料调拨，显示报损人、报损部门、报损时间
        return Column(children: [
          const SizedBox(
            height: 10.0,
          ),
          frmLossUserView(),
          const SizedBox(
            height: 10.0,
          ),
          frmLossDepartmentView(),
          const SizedBox(
            height: 10.0,
          ),
          frmLossTimeView(),
        ]);
      } else {
        return const SizedBox();
      }
    }
  }
  /// 盘点人
  Widget dealUserNameView() {
    return Row(
      children: [desLabel('盘点人'), textView(1, model?.dealUserName ?? '')],
    );
  }
  /// 盘点部门
  Widget dealOrgNameView() {
    return Row(
      children: [desLabel('盘点部门'), textView(1, model?.dealOrgName ?? '')],
    );
  }

  /// 任务开始时间
  Widget taskStartTimeView() {
    return Row(
      children: [desLabel('任务开始时间'), textView(1, model?.taskStartTime ?? '')],
    );
  }

  /// 任务结束时间
  Widget taskEndTimeView() {
    return Row(
      children: [desLabel('任务结束时间'), textView(1, model?.taskEndTime ?? '')],
    );
  }

  /// 盘点时间
  Widget dealTimeView() {
    return Offstage(
      offstage: model?.dealStartTime == null,
      child: Row(
        children: [desLabel('盘点时间'), textView(1, model?.dealStartTime ?? '')],
      ),
    );
  }

  /// 仓库名称view
  Widget wareHouseView() {
    return Row(
      children: [desLabel('仓库名称'), textView(1, model?.wareHouseName ?? '')],
    );
  }


  /// 报损部门view
  Widget frmLossDepartmentView() {
    return Row(
      children: [desLabel('报损部门'), textView(1, model?.reportOrgName ?? '')],
    );
  }

  /// 报损人view
  Widget frmLossUserView() {
    return Row(
      children: [
        desLabel('报损人'),
        contactView('${model?.reportUserName}', model?.reportManMobileNum ?? '')
      ],
    );
  }

  /// 报损时间
  Widget frmLossTimeView() {
    return Row(
      children: [desLabel('报损时间'), textView(1, model?.reportTime ?? '')],
    );
  }

  /// 调入仓库view
  Widget inWareHouseView() {
    return Row(
      children: [desLabel('调入仓库'), textView(1, model?.inWareHouseName ?? '')],
    );
  }

  /// 调出仓库view
  Widget outWareHouseView() {
    return Row(
      children: [desLabel('调出仓库'), textView(1, model?.outWareHouseName ?? '')],
    );
  }

  /// 领用人view
  Widget userView() {
    return Row(
      children: [
        desLabel('领用人'),
        contactView(model?.fetchUserName ?? '', model?.fetchUserMobileNum ?? '')
      ],
    );
  }

  /// 领用部门view
  Widget userDepartmentView() {
    return Row(
      children: [desLabel('领用部门'), textView(1, model?.fetchOrgName ?? '')],
    );
  }

  /// 操作人view
  Widget entryUserView() {
    return Row(
      children: [
        desLabel('操作人'),
        contactView('${model?.creatorName}', model?.mobileNum ?? '')
      ],
    );
  }

  /// 单号
  Widget entryNumView() {
    return Row(
      children: [desLabel('单号'), numView(model?.number ?? '')],
    );
  }

  /// 工单编号
  Widget workOrderNumberView() {
    return Row(
      children: [desLabel('工单编号'), numView(model?.workOrderNumber ?? '')],
    );
  }

  /// 操作时间
  Widget entryTimeView() {
    return Row(
      children: [desLabel('操作时间'), textView(1, model?.gmtCreate ?? '')],
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
          padding: const EdgeInsets.only(top: 16.0,),
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
          height:  79.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: SCImage(
              url: url,
              width: 79.0,
              height: 79.0,
              fit: BoxFit.fill,),
          )
      ),
    );
  }

  /// 图片预览
  previewImage(String url) {
    SCImagePreviewUtils.previewImage(imageList: [url]);
  }
}
