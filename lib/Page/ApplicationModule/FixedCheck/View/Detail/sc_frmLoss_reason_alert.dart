import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/sc_alert_header_view.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../WorkBench/Home/Model/sc_home_task_model.dart';

/// 报损原因弹窗

class SCFrmLossReasonAlert extends StatefulWidget {
  SCFrmLossReasonAlert({Key? key,
    required this.list,
    required this.selectIndex,
    this.closeTap,
    this.tapAction,
  }) : super(key: key);

  /// 关闭
  final Function? closeTap;

  /// 点击
  final Function(int index)? tapAction;

  /// 数据源
  final List list;

  /// 当前选中的index
  final int selectIndex;


  @override
  SCFrmLossReasonAlertState createState() => SCFrmLossReasonAlertState();
}

class SCFrmLossReasonAlertState extends State<SCFrmLossReasonAlert> {

  /// 默认index
  int currentIndex = 0;

  @override
  initState() {
    super.initState();
    currentIndex = widget.selectIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          titleItem(context),
          listview(),
          Container(
            color: SCColors.color_FFFFFF,
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }

  /// title
  Widget titleItem(BuildContext context) {
    return SCAlertHeaderView(
      title: '报损原因',
      closeTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget listview() {
    return Container(
        color: SCColors.color_FFFFFF,
        child: ListView.separated(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return cell(index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 1.0,);
            },
            itemCount: widget.list.length));
  }

  Widget cell(int index) {
    return GestureDetector(
      onTap: () {
        if (index != widget.selectIndex) {
          currentIndex = index;
          widget.tapAction?.call(index);
          Navigator.of(context).pop();
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 44.0,
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