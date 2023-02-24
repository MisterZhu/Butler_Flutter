import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

import '../../Model/sc_check_selectcategory_model.dart';

/// 分类列表listview

class SCCheckSelectCategoryListView extends StatelessWidget {
  const SCCheckSelectCategoryListView(
      {Key? key, required this.list, this.onTap, this.radioTap})
      : super(key: key);

  /// 数据源
  final List list;

  /// cell点击
  final Function(int index)? onTap;

  /// radio点击
  final Function(int index)? radioTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(4.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [listView()],
        ),
      ),
    );
  }

  /// listView
  Widget listView() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return cell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line(index);
        },
        itemCount: list.length);
  }

  /// cell
  Widget cell(int index) {
    SCCheckSelectCategoryModel model = list[index];
    String title = model.title ?? '';
    bool isSelected = model.isSelected ?? false;
    String radioPath = isSelected
        ? SCAsset.iconMaterialSelected
        : SCAsset.iconMaterialUnselect;
    bool offstage = (model.childList ?? []).isEmpty;
    return SizedBox(
      height: 48.0,
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                radioTap?.call(index);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Image.asset(
                  radioPath,
                  width: 22.0,
                  height: 22.0,
                ),
              ),
            ),
            Expanded(
                child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                detailAction(index);
              },
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_1B1D33),
                strutStyle: const StrutStyle(
                  fontSize: SCFonts.f14,
                  height: 1.55,
                  forceStrutHeight: true,
                ),
              ),
            )),
            Offstage(
              offstage: offstage,
              child: GestureDetector(
                onTap: () {
                  detailAction(index);
                },
                child: Image.asset(
                  SCAsset.iconArrowRight,
                  width: 16.0,
                  height: 16.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// line
  Widget line(int index) {
    return const Padding(
      padding: EdgeInsets.only(left: 12.0),
      child: Divider(
        height: 0.5,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  /// 详情
  detailAction(int index) {
    SCCheckSelectCategoryModel model = list[index];
    if ((model.childList ?? []).isNotEmpty) {
      onTap?.call(index);
    }
  }
}
