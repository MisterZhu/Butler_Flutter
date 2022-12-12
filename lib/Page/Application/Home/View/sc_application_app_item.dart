
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Constants/sc_asset.dart';
import '../../../../Network/sc_config.dart';
import '../GetXController/sc_application_controller.dart';
import '../Model/sc_application_module_model.dart';

/// 单个appItem

class SCApplicationAppItem extends StatelessWidget {

  final bool isRegularApp;

  final int section;

  final Applets applets;

  /// 按钮点击事件
  final Function(String title)? appTapAction;

  const SCApplicationAppItem({
    Key? key,
    required this.isRegularApp,
    required this.section,
    required this.applets,
    this.appTapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    SCApplicationController state = Get.find<SCApplicationController>();
    bool hide = true;
    if (isRegularApp) {
      /// 如果是常用应用
      hide = state.isEditing ? false : true;
    } else {
      if (state.isEditing) {
        List<Applets>? regularApplets = state.regularModuleModel.applets;
        hide = regularApplets?.any((element) => applets.id == element.id) ?? true;
      }
    }
    return GestureDetector(
      onTap: (){
        if (!hide) {
          if (section == 0) {
            log('常用应用删除');
            state.deleteRegularApp(applets);
          } else {
            log('应用添加');
            state.addRegularApp(applets);
          }
        }
        if (!state.isEditing) {
          if (appTapAction != null) {
            appTapAction?.call(applets.name ?? '');
          }
        }
      },
      child: Container(
        color: SCColors.color_FFFFFF,
        alignment: Alignment.centerLeft,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            iconTextItem(),
            addOrDeleteIconItem(hide),
          ],
        ),
      ),
    );
  }

  Widget iconTextItem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        iconItem(),
        const SizedBox(height: 6),
        nameItem(),
      ],
    );
  }

  /// 应用图标icon
  Widget iconItem() {
    return Container(
      width: 60,
      height: 52,
      alignment: Alignment.bottomCenter,
      child: Image.asset(
        applets.icon?.name ?? '',
        width: 44,
        height: 44,
      ),
    );
  }

  /// 右上角的+/-图标
  Widget addOrDeleteIconItem(bool hide) {
    return Offstage(
      /// offstage = true（隐藏）
      offstage: hide,
      child: SizedBox(
        width: 22,
        height: 22,
        child: Image.asset(section == 0 ? SCAsset.iconEditAppDelete : SCAsset.iconEditAppAdd, width: 22.0, height: 22.0,),
      ),
    );
  }

  /// 应用名称item
  Widget nameItem() {
    return Text(
      applets.name ?? '',
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 12, color: SCColors.color_1B1D33),
    );
  }
}