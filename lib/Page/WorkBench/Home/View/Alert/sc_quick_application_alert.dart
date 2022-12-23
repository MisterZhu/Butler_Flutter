
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/sc_alert_header_view.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../../Application/Home/Model/sc_application_module_model.dart';

/// 快捷应用弹窗
class SCQuickApplicationAlert extends StatelessWidget {

  SCQuickApplicationAlert({Key? key,
    required this.list,
    this.tapAction,
  }) : super(key: key);

  /// 数据源
  final List<SCMenuItemModel> list;
  /// 按钮点击事件
  final Function(int id, String title)? tapAction;

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
      return DecoratedBox(
        decoration: const BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            titleItem(context),
            gridView(),
            SizedBox(
              height: SCUtils().getBottomSafeArea(),
            )
          ],
        ),
      );
  }

  /// title
  Widget titleItem(BuildContext context) {
    return SCAlertHeaderView(
      title: '快捷应用',
      closeTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  /// gridView
  Widget gridView() {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 16.0),
      mainAxisSpacing: 19,
      crossAxisSpacing: 10,
      crossAxisCount: 5,
      shrinkWrap: true,
      itemCount: list.length + 1,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == list.length) {
           return cell(id: 0,icon: SCAsset.iconHomeMoreApplication, name: '更多应用');
        } else {
          SCMenuItemModel model = list[index];
           return cell(id: model.id!, icon: model.icon?.name ?? '', name: model.name ?? '');
        }
      },
      staggeredTileBuilder: (int index) {
        return const StaggeredTile.fit(1);
      });
  }

  /// cell
  Widget cell({required int id, required String icon, required String name}) {
    return GestureDetector(
      onTap: () {
        tapAction?.call(id, name);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          iconItem(icon),
          const SizedBox(height: 6),
          nameItem(name),
        ],
      ),
    );
  }

  /// 应用图标icon
  Widget iconItem(String icon) {
    return Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      child: Image.asset(
        icon,
        width: 44,
        height: 44,
      ),
    );
  }

  /// 应用名称item
  Widget nameItem(String name) {
    return Text(
      name,
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 12, color: SCColors.color_1B1D33),
    );
  }

}