
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Application/Home/GetXController/sc_application_controller.dart';
import 'package:smartcommunity/Page/Application/Home/View/sc_application_app_item.dart';

import '../Model/sc_application_module_model.dart';

/// 单个模块应用cell
class SCApplicationCellItem extends StatelessWidget {

  final int section;

  final SCApplicationModuleModel moduleModel;

  /// 按钮点击事件
  final Function(String title, String url)? tapAction;

  SCApplicationCellItem(
      {
        Key? key,
        this.section = 0,
        required this.moduleModel,
        this.tapAction,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return GetBuilder<SCApplicationController>(builder: (state) {
      return Container(
        color: SCColors.color_FFFFFF,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            headerItem(),
            itemsCell(),
          ],
        ),
      );
    });
  }

  /// header
  Widget headerItem() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0, bottom: 6.0),
      child: SizedBox(
        width: double.infinity,
        height: 24,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            headerLeftItem(),
            headerRightItem(),
          ],
        ),
      ),
    );
  }

  /// header-left
  Widget headerLeftItem() {
    return Expanded(
      child: Text(
        moduleModel.name ?? '',
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w500,
          color: SCColors.color_000000,
        ),
    ));
  }

  /// header-right
  Widget headerRightItem() {
    return GetBuilder<SCApplicationController>(builder: (state){
      return Offstage(
        offstage: moduleModel.id == '0' ? false : true, /// 如果是常用应用显示右边的编辑
        child: CupertinoButton(
          minSize: 40.0,
          borderRadius: BorderRadius.circular(0.0),
          padding: EdgeInsets.zero,
          color: SCColors.color_FFFFFF,
          child: Text(
            state.isEditing ? '完成' : '编辑',
            maxLines: 1,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w400,
              color: SCColors.color_4285F4,
            ),),
          onPressed: (){
            state.updateEditStatus();
          },
        ),
      );
    });
  }

  /// cell
  Widget itemsCell() {
    List<SCMenuItemModel>?list = [];
    /// 是否是常用应用，暂定id=0为常用应用，后面根据接口返回的数据再定
    bool isRegularApp = moduleModel.id == '0' ? true : false;
    return GetBuilder<SCApplicationController>(builder: (state) {
      if (isRegularApp) {
        list = state.regularModuleModel.menuServerList;
      } else {
        list = moduleModel.menuServerList;
      }
      return StaggeredGridView.countBuilder(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          mainAxisSpacing: 16,
          crossAxisSpacing: 10,
          crossAxisCount: 5,
          shrinkWrap: true,
          itemCount: list?.length ?? 0,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            SCMenuItemModel model = list![index];
            return SCApplicationAppItem(
              isRegularApp: isRegularApp,
              section: section,
              model: model,
              appTapAction: (title, url) {
                if (tapAction != null) {
                  tapAction?.call(title, url);
                }
              },
            );
          },
          staggeredTileBuilder: (int index) {
            return const StaggeredTile.fit(1);
          });
    });
  }

}