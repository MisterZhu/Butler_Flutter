import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/SelectHouse/sc_select_house_tip_view.dart';

import '../../Constant/sc_house_inspect_default.dart';

/// 选择房号-具体房号view

class SCSelectHouseRoomView extends StatelessWidget {

  const SCSelectHouseRoomView({Key? key, required this.list}) : super(key: key);

  /// 数据源
  final List list;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 12.0,
        crossAxisCount: 3,
        shrinkWrap: true,
        itemCount: list.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return cell(index);
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

  /// cell
  Widget cell(int index) {
    var map = list[index];

    /// 状态
    int status = map['status'];

    /// title
    String title = map['title'];

    /// 背景颜色
    Color bgColor =
        SCHouseInspectDefault().getDeliveryStatusCircleColor(status);

    /// title颜色
    Color textColor =
        SCHouseInspectDefault().getDeliveryStatusTextColor(status);

    return Container(
      height: 30.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(4.0)),
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: textColor),
      ),
    );
  }
}
