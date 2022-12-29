import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:smartcommunity/Page/Application/Home/View/sc_application_cell_item.dart';
import '../GetXController/sc_application_controller.dart';
import '../Model/sc_application_module_model.dart';

/// 应用列表

class SCApplicationListView extends StatelessWidget {
  final List<SCApplicationModuleModel>? appList;

  /// 按钮点击事件
  final Function(String title, String url)? itemTapAction;

  /// SCApplicationController
  final SCApplicationController state;

  /// tag
  final String tag;

  SCApplicationListView({
    Key? key,
    required this.appList,
    required this.state,
    required this.tag,
    this.itemTapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          SCApplicationModuleModel moduleModel = appList![index];
          return GetBuilder<SCApplicationController>(
              tag: tag,
              init: state,
              builder: (state) {
                return SCApplicationCellItem(
                  state: state,
                  section: index,
                  moduleModel: moduleModel,
                  tapAction: (title, url) {
                    if (itemTapAction != null) {
                      itemTapAction?.call(title, url);
                    }
                  },
                );
              });
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            height: 8,
          );
        },
        itemCount: appList!.length);
  }
}
