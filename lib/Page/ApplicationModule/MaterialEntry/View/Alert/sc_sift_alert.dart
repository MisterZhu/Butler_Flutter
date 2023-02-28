
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Alert/sc_tag_select_view.dart';

/// 筛选弹窗-单选

class SCSiftAlert extends StatefulWidget {

  final String title;
  final List list;
  final int selectIndex;

  /// 点击
  final Function(int selectIndex)? tapAction;

  /// 弹窗收起
  final Function()? closeAction;

  SCSiftAlert({Key? key,
    required this.title,
    required this.list,
    required this.selectIndex,
    this.closeAction,
    this.tapAction}) : super(key: key);

  @override
  SCSiftAlertState createState() => SCSiftAlertState();
}

class SCSiftAlertState extends State<SCSiftAlert> {

  @override
  initState() {
    super.initState();
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
          contentView(),
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

  /// contentView
  Widget contentView() {
    print("index========${widget.selectIndex}");
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: SCFonts.f14,
              color: SCColors.color_5E5F66,
              fontWeight: FontWeight.w400,
            ),),
          const SizedBox(height: 8.0,),
          SCTagSelectView(list: widget.list, currentIndex: widget.selectIndex, tapAction: (value) {
            widget.tapAction?.call(value);
          },)
        ],
      ));
  }

}