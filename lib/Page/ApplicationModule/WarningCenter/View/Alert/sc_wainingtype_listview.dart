import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

/// 类型列表

enum SCTypeListViewType { type1, type2 }

class SCTypeListView extends StatelessWidget {
  /// currentIndex
  final int currentIndex;

  /// type
  final SCTypeListViewType cellType;

  /// 数据源
  final List list;

  /// cell点击
  final Function(int index)? onTap;

  SCTypeListView(
      {Key? key,
      required this.currentIndex,
      required this.cellType,
      required this.list,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return cell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox();
        },
        itemCount: list.length);
  }

  /// cell
  Widget cell(int index) {
    Widget item;
    Color bgColor;
    String title = list[index];
    if (cellType == SCTypeListViewType.type1) {
      item = Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: SCFonts.f16,
            fontWeight: FontWeight.w400,
            color: currentIndex == index
                ? SCColors.color_4285F4
                : SCColors.color_1B1D33),
      );
      bgColor =
          currentIndex == index ? SCColors.color_FFFFFF : Colors.transparent;
    } else if (cellType == SCTypeListViewType.type2) {
      item = Row(
        children: [
          Expanded(
              child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w400,
                color: currentIndex == index
                    ? SCColors.color_4285F4
                    : SCColors.color_1B1D33),
          )),
          const SizedBox(
            width: 6.0,
          ),
          Visibility(
              visible: currentIndex == index ? true : false,
              child: Image.asset(
                SCAsset.iconSortSelected,
                width: 24.0,
                height: 24.0,
              ))
        ],
      );
      bgColor = SCColors.color_FFFFFF;
    } else {
      item = const SizedBox();
      bgColor = SCColors.color_FFFFFF;
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap?.call(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        width: double.infinity,
        height: 48.0,
        alignment: Alignment.centerLeft,
        color: bgColor,
        child: item,
      ),
    );
  }
}
