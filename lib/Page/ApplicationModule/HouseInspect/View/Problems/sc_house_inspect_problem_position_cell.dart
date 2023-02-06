

import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 验房-问题-位置

class SCHouseInspectProblemPositionCell extends StatefulWidget {

  SCHouseInspectProblemPositionCell({Key? key}) : super(key: key);

  @override
  SCHouseInspectProblemPositionCellState createState() => SCHouseInspectProblemPositionCellState();
}

class SCHouseInspectProblemPositionCellState extends State<SCHouseInspectProblemPositionCell> {

  String room = '';

  String position = '';

  List roomList = ['厨房', '卫生间', '主卧', '次卧', '客厅'];
  List positionList = ['墙面', '地面', '天花板', '水龙头', '水管'];

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleItem(),
          const SizedBox(height: 16.0,),
          rowItem('房间', roomList, 0),
          const SizedBox(height: 20.0,),
          rowItem('部位', positionList, 1),
        ],
      ),
    );
  }

  /// title
  Widget titleItem() {
    return const Text(
        '请选择',
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: SCFonts.f16,
          color: SCColors.color_1B1D33,
          fontWeight: FontWeight.w400,
        ),
    );
  }

  /// rowItem
  Widget rowItem(String title, List list, int section) {
    return Row(
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: SCFonts.f14,
            color: SCColors.color_1B1D33,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 14.0,),
       Expanded(child: listView(list, section)),
      ],
    );
  }

  /// listView
  Widget listView(List list, int section) {
    return SizedBox(
      height: 28.0,
      child: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return cell(list[index], section);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(width: 8.0,);
          },
          itemCount: list.length),
    );
  }

  /// cell
  Widget cell(String name, int section) {
    bool isSelected = false;
    if (section == 0) {
      if (name == room) {
        isSelected = true;
      }
    } else if (section == 1) {
      if (name == position) {
        isSelected = true;
      }
    }
    /// 背景颜色
    Color bgColor = isSelected == true ? SCColors.color_EBF2FF : SCColors.color_F7F8FA;
    /// 边框颜色
    Color borderColor = isSelected == true ? SCColors.color_4285F4 : SCColors.color_F7F8FA;
    /// title字体颜色
    Color textColor = isSelected == true ? SCColors.color_4285F4 : SCColors.color_5E5F66;

    return GestureDetector(
      onTap: () {
        if (section == 0) {
          setState(() {
            room = isSelected ? '' : name;
          });
        } else if (section == 1) {
          setState(() {
            position = isSelected ? '' : name;
          });
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(2.0),
            border: Border.all(color: borderColor, width: 1.0)
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
        child: Text(
          name,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SCFonts.f14,
            color: textColor,
            fontWeight: FontWeight.w400,
          ),),
      ),
    );
  }

}
