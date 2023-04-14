import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/View/Detail/sc_warning_detail_text_cell.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../Controller/sc_warning_detail_controller.dart';
import '../../Model/sc_warningcenter_detail_model.dart';

/// 预警详情-预警明细-cell
class SCWarningDetailCellItem extends StatefulWidget {
  /// model
  final SCAlertDetailedVs model;

  SCWarningDetailCellItem({Key? key, required this.model}) : super(key: key);

  @override
  SCWarningDetailCellItemState createState() => SCWarningDetailCellItemState();
}

class SCWarningDetailCellItemState extends State<SCWarningDetailCellItem> {
  /// 是否展开，默认展开
  bool unfold = true;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          topItem(),
          listview(),
        ],
      ),
    );
  }

  Widget topItem() {
    return GestureDetector(
      onTap: () {
        setState(() {
          unfold = !unfold;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        height: 22.0,
        child: Row(
          children: [
            Image.asset(
              unfold == true
                  ? SCAsset.iconWarningArrowDown
                  : SCAsset.iconWarningArrowRight,
              width: 16.0,
              height: 16.0,
            ),
            const SizedBox(
              width: 4.0,
            ),
            Text(widget.model.alertSource ?? '',
                maxLines: 1,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w500,
                    color: SCColors.color_1B1D33))
          ],
        ),
      ),
    );
  }

  Widget listview() {
    List warnDetailList = [
      {'name': '网关编号', 'content': widget.model.deviceCode},
      {'name': '回路号', 'content': widget.model.loopCode},
      {'name': '地址号', 'content': widget.model.addressCode},
      {'name': '设备位置', 'content': widget.model.position},
      {'name': '预警事件', 'content': widget.model.eventName},
      {'name': '处理时间', 'content': widget.model.nowAlertTime},
    ];
    return Offstage(
      offstage: !unfold,
      child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 12.0),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            var dic = warnDetailList[index];
            return SCWarningDetailTextCell(
              leftText: dic['name'],
              rightText: dic['content'],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 12.0,
            );
          },
          itemCount: warnDetailList.length),
    );
  }
}
