
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:smartcommunity/Page/Application/Home/View/sc_application_cell_item.dart';
import '../Model/sc_application_module_model.dart';

/// 应用列表-第一套皮肤

class SCApplicationListView extends StatelessWidget {

  final List<SCApplicationModuleModel>? appList;

  /// 按钮点击事件
  final Function(String title)? itemTapAction;

  SCApplicationListView({Key? key, required this.appList, this.itemTapAction}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          SCApplicationModuleModel moduleModel = appList![index];
          return SCApplicationCellItem(
            section: index,
            moduleModel: moduleModel,
            tapAction: (title){
              if (itemTapAction != null) {
                itemTapAction?.call(title);
              }
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(height: 8,);
        },
        itemCount: appList!.length);
  }

}