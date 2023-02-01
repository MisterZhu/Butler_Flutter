import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/Constant/sc_house_inspect_default.dart';

/// 选择房号状态提示view

class SCSelectHouseStatusTipView extends StatelessWidget {
  const SCSelectHouseStatusTipView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.0,
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: viewList(),
      ),
    );
  }

  /// 状态list
  List<Widget> viewList() {
    List list = statusDesList();
    List<Widget> widgetList = [];
    for (int i = 0; i < list.length; i++) {
      widgetList.add(cell(i));
      widgetList.add(separator(i == list.length - 1 ? 15.0 : 12.0));
    }
    return widgetList;
  }

  /// cell
  Widget cell(int index) {
    List list = statusDesList();

    var map = list[index];

    /// 状态
    int status = map['status'];

    /// title
    String title = map['title'];

    /// 圆圈颜色
    Color circleColor =
        SCHouseInspectDefault().getDeliveryStatusCircleColor(status);

    /// title颜色
    Color textColor =
        SCHouseInspectDefault().getDeliveryStatusTextColor(status);

    /// 圆圈大小
    double circleSize = 9.0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
              color: circleColor,
              borderRadius: BorderRadius.circular(circleSize / 2.0)),
        ),
        const SizedBox(
          width: 8.0,
        ),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: SCFonts.f12,
              fontWeight: FontWeight.w400,
              color: textColor),
        )
      ],
    );
  }

  /// 间距
  Widget separator(double width) {
    return SizedBox(
      width: width,
    );
  }

  /// 状态描述数据源
  List statusDesList() {
    return [
      {
        "title": "已交付",
        "status": SCHouseInspectDefault.deliveryStatusSuccess,
      },
      {
        "title": "待交付",
        "status": SCHouseInspectDefault.deliveryStatusWait,
      },
      {
        "title": "交付中",
        "status": SCHouseInspectDefault.deliveryStatusDoing,
      }
    ];
  }
}
