
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../../WorkBench/Home/View/Alert/sc_alert_header_view.dart';

/// 驳回节点弹窗

class SCRejectNodeAlert extends StatefulWidget {

  /// 节点数组
  final List list;

  /// 当前节点
  final String? currentNode;

  /// title
  final String? title;

  /// 点击
  final Function(String node, int index)? tapAction;

  SCRejectNodeAlert({Key? key, required this.list, this.currentNode, this.tapAction, this.title}) : super(key: key);

  @override
  SCRejectNodeAlertState createState() => SCRejectNodeAlertState();
}

class SCRejectNodeAlertState extends State<SCRejectNodeAlert> {

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 395.0 + 54.0 + SCUtils().getBottomSafeArea(),
        padding: EdgeInsets.only(bottom: SCUtils().getBottomSafeArea()),
        decoration: const BoxDecoration(
          color: SCColors.color_F2F3F5,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0))
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              titleItem(context),
              Expanded(child: listView()),
            ]
        )
    );
  }

  /// titleItem
  Widget titleItem(BuildContext context) {
    return SCAlertHeaderView(
      title: widget.title ?? '',
      rightText: '上一步',
      rightTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  /// listView
  Widget listView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return cell(widget.list[index], index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10.0,);
        },
        itemCount: widget.list.length));
  }

  /// cell
  Widget cell(String name, int index) {
    return GestureDetector(
      onTap: () {
        widget.tapAction?.call(name, index);
        Navigator.of(context).pop();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48.0,
        padding: const EdgeInsets.only(left: 12.0, right: 13.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: SCColors.color_FFFFFF,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 17,
                color: SCColors.color_1B1D33,
                fontWeight: FontWeight.w400,
              ),),
            Container(
              width: 38.0,
              height: 38.0,
              alignment: Alignment.center,
              child: Image.asset(widget.currentNode == name ? SCAsset.iconMaterialSelected : SCAsset.iconMaterialUnselect, width: 22.0, height: 22.0),
            ),
          ],
        ),
      ),
    );
  }
}