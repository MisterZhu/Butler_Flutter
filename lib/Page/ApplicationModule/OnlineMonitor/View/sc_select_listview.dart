
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Utils/sc_utils.dart';

/// 选择弹窗

class SCSelectListView extends StatefulWidget {

  final List list;

  final int selectIndex;

  /// 点击
  final Function(int index)? tapAction;


  SCSelectListView({Key? key, required this.list, required this.selectIndex, this.tapAction}) : super(key: key);

  @override
  SCSelectListViewState createState() => SCSelectListViewState();
}

class SCSelectListViewState extends State<SCSelectListView> {

  late int currentIndex;

  /// 最大数量
  int maxCount = 10;

  /// cell高度
  double cellHeight = 48.0;

  @override
  initState() {
    super.initState();
    currentIndex = widget.selectIndex;
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    ScrollPhysics physics = widget.list.length > maxCount ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics();
    Widget listview = Container(
        color: SCColors.color_FFFFFF,
        child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            shrinkWrap: true,
            physics: physics,
            itemBuilder: (BuildContext context, int index) {
              return cell(index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 0.0,);
            },
            itemCount: widget.list.length));
    if (widget.list.length > maxCount) {
      return SizedBox(
        height: cellHeight * maxCount + 12.0,
        child: listview,
      );
    } else {
      return listview;
    }
  }

  Widget cell(int index) {
    return GestureDetector(
      onTap: () {
        if (index != widget.selectIndex) {
          currentIndex = index;
          widget.tapAction?.call(index);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48.0,
        color: SCColors.color_FFFFFF,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.list[index],
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: SCFonts.f16,
                color: currentIndex == index ? SCColors.color_4285F4 : SCColors.color_1B1D33,
                fontWeight: FontWeight.w400,
              ),),
            const SizedBox(width: 10.0,),
            currentIndex == index ? Image.asset(SCAsset.iconFrmLossReasonSelected, width: 22.0, height: 22.0) : const SizedBox(),
          ],
        ),
      ),
    );
  }
}