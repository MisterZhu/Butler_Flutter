
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/View/Detail/sc_warning_detail_text_cell.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../Controller/sc_warning_detail_controller.dart';

/// 预警详情-预警明细-cell
class SCWarningDetailCellItem extends StatefulWidget {

  /// SCWarningDetailController
  final SCWarningDetailController state;

  SCWarningDetailCellItem({Key? key, required this.state})
      : super(key: key);


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
            Image.asset(unfold == true ? SCAsset.iconWarningArrowDown : SCAsset.iconWarningArrowRight, width: 16.0, height: 16.0,),
            const SizedBox(width: 4.0,),
            Text(
                '设备名称2',
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
    return Offstage(
      offstage: !unfold,
      child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 12.0),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            var dic = widget.state.warnDetailList[index];
            return SCWarningDetailTextCell(
              leftText: dic['name'],
              rightText: dic['content'],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 12.0,);
          },
          itemCount: widget.state.warnDetailList.length),
    );
  }

}
