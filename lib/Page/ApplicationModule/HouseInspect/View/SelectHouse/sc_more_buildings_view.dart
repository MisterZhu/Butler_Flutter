
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Utils/sc_utils.dart';

/// 更多楼幢
class SCMoreBuildingsView extends StatefulWidget {

  final List dataList;

  final Function(String value)? tapAction;

  SCMoreBuildingsView({Key? key, required this.dataList, this.tapAction,}) : super(key: key);

  @override
  SCMoreBuildingsViewState createState() => SCMoreBuildingsViewState();
}

class SCMoreBuildingsViewState extends State<SCMoreBuildingsView> {

  List selectedList = [];

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: SCUtils().getBottomSafeArea()),
      decoration: const BoxDecoration(
        color: SCColors.color_FFFFFF,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topItem(),
          gridView(),
        ]
      )
    );
  }

  /// topItem
  Widget topItem() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(child: Padding(
          padding: EdgeInsets.only(left: 16.0, top: 12.0, bottom: 12.0),
          child: Text(
            '更多楼幢',
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: SCFonts.f16,
              color: SCColors.color_1B1C35,
              fontWeight: FontWeight.w500,
            ),
          ),
        )),
        closeItem(),
      ],
    );
  }

  /// 关闭按钮
  Widget closeItem() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        width: 52.0,
        height: 46.0,
        child: Image.asset(
          SCAsset.iconMoreBuildingsClose,
          width: 20.0,
          height: 20.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// gridView
  Widget gridView() {
    ScrollPhysics physics = widget.dataList.length > 30 ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics();
    Widget gridView = StaggeredGridView.countBuilder(
        padding: const EdgeInsets.only(top: 10.0, bottom: 5.0, left: 16.0, right: 16.0),
        mainAxisSpacing: 10,
        crossAxisSpacing: 8,
        crossAxisCount: 3,
        shrinkWrap: true,
        itemCount: widget.dataList.length,
        physics: physics,
        itemBuilder: (context, index) {
          return cell(widget.dataList[index]);
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
    if (widget.dataList.length > 30) {
      return SizedBox(
        width: double.infinity,
        height: 400.0,
        child: gridView,
      );
    } else {
      return gridView;
    }
  }

  Widget cell(String name) {
    return GestureDetector(
      onTap: () {
        widget.tapAction?.call(name);
        Navigator.of(context).pop();
      },
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: SCColors.color_F7F8FA,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Text(
          name,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: SCFonts.f14,
            color: SCColors.color_5E5F66,
            fontWeight: FontWeight.w400,
          ),),),
    );
  }
}