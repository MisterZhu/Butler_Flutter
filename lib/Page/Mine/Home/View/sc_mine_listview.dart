import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';
import 'package:smartcommunity/Page/Mine/Home/Model/sc_community_alert_model.dart';
import 'package:smartcommunity/Page/Mine/Home/View/SelectCommunityAlert/sc_community_alertview.dart';
import 'package:smartcommunity/Page/Mine/Home/View/sc_mine_header_item.dart';
import 'package:smartcommunity/Page/Mine/Home/View/sc_setting_cell.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import '../../../../Network/sc_config.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/JPush/sc_jpush.dart';
import '../../../../Utils/sc_utils.dart';
import '../GetXController/sc_mine_controller.dart';
import '../Model/sc_community_common_model.dart';

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

  /// controller
  final SCMineController controller;

  const SCMineListView({
    Key? key,
    required this.controller,
    this.qrCodeTapAction,
    this.settingTapAction,
    this.avatarTapAction,
    this.switchTapAction,
    this.userInfoTapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return Column(
      children: [
        SCMineHeaderItem(
          avatar: SCScaffoldManager.instance.user.headPicUri?.fileKey != null
              ? SCConfig.getImageUrl(
                  SCScaffoldManager.instance.user.headPicUri?.fileKey ?? '')
              : SCAsset.iconUserDefault,
          nickname: SCScaffoldManager.instance.user.userName ?? '',
          space: SCScaffoldManager.instance.user.tenantName ?? '',
          avatarTapAction: () {
            avatarTapAction?.call();
          },
          qrCodeTapAction: () {
            qrCodeTapAction?.call();
          },
          settingTapAction: () {
            settingTapAction?.call();
          },
          switchTapAction: () {
            switchTapAction?.call();
          },
          userInfoTapAction: () {
            userInfoTapAction?.call();
          },
        ),
        listview(context),
      ],
    );
  }

  Widget listview(BuildContext context) {
    int count = 17;
    if (SCConfig.env == SCEnvironment.production &&
        !SCConfig.isSupportProxyForProduction) {
      if (SCConfig.yycTenantId() == (SCScaffoldManager.instance.defaultConfigModel?.tenantId ?? '')) {
        count = 2;
      } else {
        count = 1;
      }
    }
    return Expanded(
        child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return getCell(index, context);
            },
            separatorBuilder: (BuildContext context, int index) {
              return line();
            },
            itemCount: count));
  }

  /// cell
  Widget getCell(int index, BuildContext context) {
    if (index == 0) {
      return SCSettingCell(
        title: '设置',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineNewSetting,
        onTap: () {
          // var message = {
          //   "aps": {
          //     "alert": {
          //       "title": "善数管理"
          //     }
          //   },
          //   "badge": "+1",
          //   "alert": "有超时待接收工单，请尽快接收！",
          //   "sound": "sound.caf",
          //   "extras": {
          //     "type": 100,
          //     "url": "https://saas.wisharetec.com/h5Manage-order/#/workOrder/orderDetail?source=my&orderId=787c83230d2210a97607c89d2c67628c"
          //   }
          // };
          // SCJPush.dealJPush(message);
          SCRouterHelper.pathPage(SCRouterPath.settingPath, null);
        },
      );
    } else if (index == 1) {
      if (SCConfig.yycTenantId() ==
          (SCScaffoldManager.instance.defaultConfigModel?.tenantId ?? '')) {
        return SCSettingCell(
          title: '报事记录',
          showLeftIcon: true,
          leftIcon: SCAsset.iconMineService,
          onTap: () {
            showCommunityAlert(context);
          },
        );
      } else {
        return SCSettingCell(
          title: '物资入库',
          showLeftIcon: true,
          leftIcon: SCAsset.iconMineService,
          onTap: () {
            SCRouterHelper.pathPage(SCRouterPath.materialEntryPage, null);
          },
        );
      }
    } else if (index == 2) {
      return SCSettingCell(
        title: '物资出库',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.materialOutboundPage, null);
        },
      );
    } else if (index == 3) {
      return SCSettingCell(
        title: '物资报损',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.materialFrmLossPage, null);
        },
      );
    } else if (index == 4) {
      return SCSettingCell(
        title: '物资调拨',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.materialTransferPage, null);
        },
      );
    } else if (index == 5) {
      return SCSettingCell(
        title: '盘点任务',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.materialCheckPage, null);
        },
      );
    } else if (index == 6) {
      return SCSettingCell(
        title: '领料出入库',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.materialRequisitionPage, null);
        },
      );
    } else if (index == 7) {
      return SCSettingCell(
        title: '资产报损',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.propertyFrmLossPage, null);
        },
      );
    } else if (index == 8) {
      return SCSettingCell(
        title: '固定资产盘点',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.fixedCheckPage, null);
        },
      );
    } else if (index == 9) {
      return SCSettingCell(
        title: '消息',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.messagePage, null);
        },
      );
    } else if (index == 10) {
      return SCSettingCell(
        title: '鹰眼服务',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.onlineMonitorPage, null);
        },
      );
    } else if (index == 11) {
      return SCSettingCell(
        title: '任务列表',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.taskPage, null);
        },
      );
    } else if (index == 12) {
      return SCSettingCell(
        title: '资产维保',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.propertyRecordPage, null);
        },
      );
    } else if (index == 13) {
      return SCSettingCell(
        title: '预警中心',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.warningCenterPage, null);
        },
      );
    } else if (index == 14) {
      return SCSettingCell(
        title: '巡查',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.patrolPage, {"pageType": 0});
        },
      );
    } else if (index == 15) {
      return SCSettingCell(
        title: '品质督查',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.patrolPage, {"pageType": 1});
        },
      );
    } else if (index == 16) {
      return SCSettingCell(
        title: '巡检',
        showLeftIcon: true,
        leftIcon: SCAsset.iconMineService,
        onTap: () {
          SCRouterHelper.pathPage(SCRouterPath.patrolPage, {"pageType": 2});
        },
      );
    } else {
      return const SizedBox(
        height: 100.0,
      );
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

  /// 选择项目弹窗
  showCommunityAlert(BuildContext context) {
    controller.loadCommunity(success: (List<SCCommunityCommonModel> titleList) {
      SCDialogUtils().showCustomBottomDialog(
          context: context,
          isDismissible: true,
          widget: SCSelectCommunityAlert(
            list: titleList,
            title: '请选择项目',
            onSure: (int index) {
              Navigator.of(context).pop();
              reportRecord(index);
            },
          ));
    });
  }

  /// 报事记录
  reportRecord(int index) {
    SCCommunityAlertModel model = controller.communityList[index];
    String url =
        '${SCConfig.BASE_URL}/h5Manage-order/#/workOrderReport/propertyList?defCommunityId=${model.id}';
    String realUrl =
        SCUtils.getWebViewUrl(url: url, title: '报事记录', needJointParams: true);
    SCRouterHelper.pathPage(SCRouterPath.webViewPath,
        {"title": '报事记录', "url": realUrl, "needJointParams": true});
  }
}
