import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/SelectHouse/sc_house_inspect_building_view.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/SelectHouse/sc_house_inspect_room_view.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/SelectHouse/sc_house_inspect_unit_view.dart';

import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import 'sc_more_buildings_view.dart';
import 'sc_select_house_tip_view.dart';

/// 选择房号-listView

class SCSelectHouseListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: SCColors.color_FFFFFF,
      child: Column(
        children: [
          const SizedBox(
            height: 25.0,
          ),
          SCSelectHouseBuildingView(
            moreAction: () {
              moreBuildingAction();
            },
          ),
          const SizedBox(
            height: 18.0,
          ),
          body()
        ],
      ),
    );
  }

  /// body
  Widget body() {
    return Expanded(
        child: Row(
      children: [leftBody(), rightBody()],
    ));
  }

  /// leftBody
  Widget leftBody() {
    return SCSelectHouseUnitView();
  }

  /// rightBody
  Widget rightBody() {
    List list = [
      {
        "status": 1,
        "title": "101",
      },
      {
        "status": 2,
        "title": "102",
      },
      {
        "status": 3,
        "title": "103",
      },
      {
        "status": 1,
        "title": "104",
      },
      {
        "status": 2,
        "title": "105",
      },
      {
        "status": 1,
        "title": "201",
      },
      {
        "status": 2,
        "title": "202",
      },
      {
        "status": 3,
        "title": "203",
      },
      {
        "status": 1,
        "title": "204",
      },
      {
        "status": 2,
        "title": "205",
      },
      {
        "status": 1,
        "title": "301",
      },
      {
        "status": 2,
        "title": "302",
      },
      {
        "status": 3,
        "title": "303",
      },
      {
        "status": 1,
        "title": "304",
      },
      {
        "status": 2,
        "title": "305",
      }
    ];
    return Expanded(
        child: Column(
      children: [
        const SCSelectHouseStatusTipView(),
        const SizedBox(
          height: 3.0,
        ),
        Expanded(
            child: SCSelectHouseRoomView(
          list: list,
          onTap: (int index) {
            checkHouse(index);
          },
        ))
      ],
    ));
  }

  /// 入伙验房
  checkHouse(int index) {
    SCRouterHelper.pathPage(SCRouterPath.enterHouseInspectPage, null);
  }

  /// 更多楼幢
  moreBuildingAction() {
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCMoreBuildingsView(
            dataList: const [
              '1幢',
              '2幢',
              '3幢',
              '4幢',
              '5幢',
              '6幢',
              '7幢',
              '8幢',
              '9幢',
              '10幢',
              '11幢',
              '12幢',
              '13幢',
              '14幢',
              '15幢',
              '16幢',
              '17幢',
              '18幢',
              '19幢',
              '20幢',
              '21幢',
              '22幢',
              '23幢',
              '24幢',
              '25幢',
              '26幢',
              '27幢',
              '28幢',
              '29幢',
              '30幢'
            ],
            tapAction: (String name) {},
          ));
    });
  }
}
