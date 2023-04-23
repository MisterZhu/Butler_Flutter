
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Constants/sc_asset.dart';

/// 任务详情-处理人cell

class SCOperatorCell extends StatelessWidget {

  /// 打电话
  final Function(String phone)? callAction;

  /// 删除处理人
  final Function(String id)? deleteAction;

  SCOperatorCell({Key? key,
    this.callAction,
    this.deleteAction
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0)),
      child: Column(
        children: [
          topItem(),
          const SizedBox(height: 12.0,),
          listview(),
        ],
      )
    );
  }

  /// topItem
  Widget topItem() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CupertinoButton(
        minSize: 22.0,
        padding: EdgeInsets.zero,
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text(
                  '处理人：张小华',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: SCFonts.f14,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_1B1D33),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Image.asset(
                  SCAsset.iconContactPhone,
                  width: 20.0,
                  height: 20.0,
                ),
              ],
            )
          ],
        ),
        onPressed: () {
          callAction?.call('');
        }),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            color: SCColors.color_E3FFF1,
            borderRadius: BorderRadius.circular(2.0)),
          child: const Text(
            '转派申请中',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: SCFonts.f12,
              fontWeight: FontWeight.w400,
              color: SCColors.color_00C365,
            ),
          ),
        )
      ],
    );
  }

  /// listview
  Widget listview() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
            color: SCColors.color_F7F8FA,
            borderRadius: BorderRadius.circular(4.0)),
        child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return cell();
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10.0,);
        },
        itemCount: 5));
  }

  Widget cell() {
    return Container(
      height: 22.0,
    );
  }

}