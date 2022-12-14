
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/utils/sc_utils.dart';
import '../GetXController/sc_switch_tenant_controller.dart';
import '../Model/sc_tenant_list_model.dart';

/// 切换身份listview

class SCSwitchTenantListView extends StatelessWidget {

  SCSwitchTenantController state = Get.find<SCSwitchTenantController>();

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: SCUtils().getBottomSafeArea()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleItem(),
          const SizedBox(height: 6.0,),
          tipItem(),
          Expanded(child: listview()),
          exitItem(),
        ],
      )
    );
  }

  /// body
  Widget listview() {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          SCTenantListModel model = state.dataList[index];
          return cell(model);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 12.0,);
        },
        itemCount: state.dataList.length);
  }

  /// titleItem
  Widget titleItem() {
    return const Text(
      '您已被邀请加入以下企业',
      textAlign: TextAlign.left,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: SCFonts.f18,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1D33
      ),);
  }

  /// tipItem
  Widget tipItem() {
    return const Text(
      '请选择一个企业进入',
      textAlign: TextAlign.left,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_1B1D33
      ),);
  }

  /// cell
  Widget cell(SCTenantListModel model) {
    return GestureDetector(
      onTap: () {
        state.userId = model.userId ?? '';
        state.tenantId = model.tenantId ?? '';
        state.switchTenant();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 52.0,
        decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(4.0)
        ),
        padding: const EdgeInsets.only(left: 16.0, right: 18.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(SCAsset.iconSwitchIdentityProjectIcon, width: 28.0, height: 28.0, fit: BoxFit.cover,),
            const SizedBox(width: 12.0,),
            Expanded(child: Text(
              model.tenantName ?? '',
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_1B1D33
              ),)),
            const SizedBox(width: 16.0,),
            Image.asset(SCAsset.iconSwitchIdentityArrow, width: 16.0, height: 16.0, fit: BoxFit.cover,),
          ],
        ),
      ),
    );
  }

  /// exitItem
  Widget exitItem() {
    return Container(
      height: 40.0,
      width: double.infinity,
      color: SCColors.color_F2F3F5,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          SCRouterHelper.back(null);
        },
        behavior: HitTestBehavior.opaque,
        child: const Text(
          '以上不是我的企业，我要退出',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_5E5F66
          ),),
      ),
    );
  }
}
