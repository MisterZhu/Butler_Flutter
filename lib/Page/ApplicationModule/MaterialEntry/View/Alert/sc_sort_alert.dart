
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Utils/sc_utils.dart';

/// 排序弹窗

class SCSortAlert extends StatefulWidget {

  final int selectIndex;

  /// 点击
  final Function(int index)? tapAction;

  /// 弹窗收起
  final Function()? closeAction;

  SCSortAlert({Key? key, required this.selectIndex, this.closeAction, this.tapAction}) : super(key: key);

  @override
  SCSortAlertState createState() => SCSortAlertState();
}

class SCSortAlertState extends State<SCSortAlert> {

  List list = ['操作时间正序', '操作时间倒序'];

  late int currentIndex;
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
    return Container(
      color: SCColors.color_000000.withOpacity(0.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          listview(),
          Expanded(child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                widget.closeAction?.call();
              }, child: Container(color: Colors.transparent,)),
          )
        ],
      ),
    );
  }

  Widget listview() {
    return Container(
        color: SCColors.color_FFFFFF,
        child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return cell(index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox();
            },
            itemCount: list.length));
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
      child: SizedBox(
        height: 48.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              list[index],
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: SCFonts.f16,
                color: currentIndex == index ? SCColors.color_4285F4 : SCColors.color_1B1D33,
                fontWeight: FontWeight.w400,
              ),),
            const SizedBox(width: 10.0,),
            currentIndex == index ? Image.asset(SCAsset.iconSortSelected, width: 24.0, height: 24.0) : const SizedBox(),
          ],
        ),
      ),
    );
  }
}