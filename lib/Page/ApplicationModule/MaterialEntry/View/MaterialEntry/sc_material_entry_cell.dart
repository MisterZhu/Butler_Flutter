
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_entry_model.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../../Utils/sc_utils.dart';

class SCMaterialEntryCell extends StatelessWidget {

  /// 类型，0 入库，1 出库
  final SCWarehouseManageType type;

  /// model
  final SCMaterialEntryModel? model;

  /// 打电话
  final Function(String phone)? callAction;

  /// 按钮点击
  final Function? btnTapAction;

  /// 详情
  final Function? detailTapAction;

  SCMaterialEntryCell({Key? key,
    required this.type,
    this.model,
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
            nameItem(model?.materialNames ?? ''),
            const SizedBox(
              height: 4.0,
            ),
            nameItem('入库数量：${model?.materialNums}'),
            const SizedBox(
              height: 6.0,
            ),
            addressInfoView(),
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(type == SCWarehouseManageType.entry ? SCAsset.iconMaterialEntry : SCAsset.iconMaterialOutbound, width: 18.0, height: 18.0,),
          const SizedBox(width: 6.0,),
          Expanded(child: Text(
            model?.typeName ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_1B1D33)),),
          const SizedBox(width: 6.0,),
          Text(
            type == SCWarehouseManageType.entry ? SCUtils.getEntryStatusText(model?.status ?? 0) : SCUtils.getOutboundStatusText(model?.status ?? 0),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: type == SCWarehouseManageType.entry ? SCUtils.getEntryStatusTextColor(model?.status ?? 0) : SCUtils.getOutboundStatusTextColor(model?.status ?? 0),))
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
  Widget addressInfoView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Image.asset(
            SCAsset.iconAddress,
            width: 16.0,
            height: 16.0,
          ),
          const SizedBox(
            width: 4.0,
          ),
          Expanded(
              child: Text(
                type == SCWarehouseManageType.transfer ? '调入：${model?.wareHouseName}  调出：${model?.wareHouseName}' : model?.wareHouseName ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: SCFonts.f12,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_5E5F66),
              )),
          CupertinoButton(
              minSize: 16.0,
              padding: EdgeInsets.zero,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    SCAsset.iconPhone,
                    width: 16.0,
                    height: 16.0,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    model?.creatorName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: SCFonts.f12,
                        fontWeight: FontWeight.w400,
                        color: SCColors.color_5E5F66),
                  )
                ],
              ),
              onPressed: () {
                callAction?.call(model?.mobileNum ?? '');
              })
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text(
            model?.gmtCreate ?? '',
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
              offstage: model?.status == 0 ? false : true,
              child: CupertinoButton(
                  alignment: Alignment.center,
                  borderRadius: BorderRadius.circular(4.0),
                  minSize: 40.0,
                  color: SCColors.color_4285F4,
                  padding: EdgeInsets.zero,
                  child: Text(
                    SCUtils.getEntryStatusButtonText(model?.status ?? 0),
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
      )
    );
  }


}