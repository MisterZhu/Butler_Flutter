import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Utils/sc_utils.dart';

/// 任务详情-处理弹窗

class SCDealAlert extends StatelessWidget {

  /// list
  final List list;

  /// 点击
  final Function(String name)? tapAction;

  SCDealAlert({
    Key? key,
    required this.list,
    this.tapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: SCColors.color_F7F8FA,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          gridView(),
          const SizedBox(
            height: 6.0,
          ),
          bottomView(context),
        ],
      ),
    );
  }

  /// gridView
  Widget gridView() {
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 21.0),
        mainAxisSpacing: 16,
        crossAxisSpacing: 10,
        crossAxisCount: 4,
        shrinkWrap: true,
        itemCount: list.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var dic = list[index];
          return cell(icon: dic['icon'] ?? '', name: dic['name'] ?? '', context: context);
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

  /// cell
  Widget cell({required String icon, required String name, required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        tapAction?.call(name);
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
      width: 60,
      height: 60,
      alignment: Alignment.center,
      child: Image.asset(
        icon,
        width: 60,
        height: 60,
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
      style: const TextStyle(
        fontSize: SCFonts.f12,
        fontWeight: FontWeight.w400,
        color: SCColors.color_5E5F66,),
    );
  }

  /// 底部取消按钮
  Widget bottomView(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.0 + SCUtils().getBottomSafeArea(),
      color: SCColors.color_FFFFFF,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(bottom: SCUtils().getBottomSafeArea()),
      child: SizedBox(
        width: double.infinity,
        height: 48.0,
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text(
            '取消',
            style: TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w400,
              color: SCColors.color_1B1D33,),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      )
    );
  }

}
