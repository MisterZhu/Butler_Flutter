
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/Mine/Home/View/sc_mine_header_item.dart';
import 'package:smartcommunity/Page/Mine/Home/View/sc_setting_cell.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import '../../../../Network/sc_config.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';

/// 我的listview

class SCMineListView extends StatelessWidget {

  /// 点击二维码
  final Function? qrCodeTapAction;

  /// 点击设置
  final Function? settingTapAction;

  /// 点击头像、昵称
  final Function? avatarTapAction;

  /// 点击切换
  final Function? switchTapAction;

  /// 点击个人资料
  final Function? userInfoTapAction;

  const SCMineListView({Key? key,
    this.qrCodeTapAction,
    this.settingTapAction,
    this.avatarTapAction,
    this.switchTapAction,
    this.userInfoTapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Column(
      children: [
        SCMineHeaderItem(
          avatar: SCScaffoldManager.instance.user.headPicUri?.fileKey != null ? SCConfig.getImageUrl(SCScaffoldManager.instance.user.headPicUri?.fileKey ?? '') : SCAsset.iconUserDefault,
          nickname: SCScaffoldManager.instance.user.userName ?? '',
          space: SCScaffoldManager.instance.user.tenantName ?? '',
          avatarTapAction: () {
            avatarTapAction?.call();
        }, qrCodeTapAction: () {
            qrCodeTapAction?.call();
        }, settingTapAction: () {
            settingTapAction?.call();
        }, switchTapAction: () {
            switchTapAction?.call();
        }, userInfoTapAction: () {
            userInfoTapAction?.call();
        },),
        listview(),
      ],
    );
  }

  Widget listview() {
    return Expanded(child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line();
        },
        itemCount: 1));
  }

  /// cell
  Widget getCell(int index) {
    if (index == 0) {
      return SCSettingCell(
        title: '设置',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineNewSetting,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.settingPath, null);
        },);
    } else if (index == 1) {
      return SCSettingCell(
        title: '物资入库',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.materialEntryPage, null);
      },);
    } else if (index == 2) {
      return SCSettingCell(
        title: '物资出库',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.materialOutboundPage, null);
        },);
    } else if (index == 3) {
      return SCSettingCell(
        title: '物资报损',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.materialFrmLossPage, null);
        },);
    } else if (index == 4) {
      return SCSettingCell(
        title: '物资调拨',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.materialTransferPage, null);
        },);
    } else if (index == 5) {
      return SCSettingCell(
        title: '盘点任务',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.materialCheckPage, null);
        },);
    } else if (index == 6) {
      return SCSettingCell(
        title: '领料出入库',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.materialRequisitionPage, null);
        },);
    }else {
      return const SizedBox(height: 100.0,);
    }
  }

  /// line
  Widget line() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

}
