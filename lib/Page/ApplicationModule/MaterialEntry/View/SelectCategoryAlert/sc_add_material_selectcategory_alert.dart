import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/SelectCategoryAlert/sc_selectcategory_footer.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/SelectCategoryAlert/sc_selectcategory_header.dart';

import '../../../../../Utils/sc_utils.dart';
import '../../../../WorkBench/Home/View/Alert/SwitchSpace/sc_workbench_changespace_header.dart';
import '../../Model/sc_selectcategory_model.dart';

/// 选择分类弹窗

class SCSelectCategoryAlert extends StatefulWidget {

  SCSelectCategoryAlert({Key? key, required this.headerList, required this.footerList, this.headerTap, this.footerTap, this.onSure, this.onCancel}) : super(key: key);

  List<SCSelectCategoryModel> headerList;

  List<SCSelectCategoryModel> footerList;

  /// header点击
  final Function(int index, SCSelectCategoryModel model)? headerTap;

  /// footer点击
  final Function(int index, SCSelectCategoryModel model)? footerTap;

  /// 取消
  final Function? onCancel;

  /// 确定
  final Function? onSure;

  @override
  SCSelectCategoryAlertState createState() => SCSelectCategoryAlertState();
}

class SCSelectCategoryAlertState extends State<SCSelectCategoryAlert> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: SCUtils().getScreenHeight() - 130.0,
      padding: EdgeInsets.only(bottom: SCUtils().getBottomSafeArea()),
      decoration: const BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      child: Column(
        children: [
          headerView(),
          topView(),
          line(),
          bottomView()
        ],
      ),
    );
  }

  /// header
  Widget headerView() {
    return SCChangeSpaceAlertHeader(
      title: '选择分类',
      onCancel: () {
        widget.onCancel?.call();
      },
      onSure: () {
        widget.onSure?.call();
      },
    );
  }

  /// top-已选择的分类
  Widget topView() {
    return SCSelectCategoryHeader(list: getHeaderList(), onTap: (index, model) {
      widget.headerTap?.call(index, model);
    },);
  }

  /// line
  Widget line() {
    return Padding(padding: const EdgeInsets.only(left: 16.0), child: Container(
      height: 0.5,
      width: double.infinity,
      color: SCColors.color_D9D9D9,
    ),);
  }

  /// bottom-分类列表
  Widget bottomView() {
    return Expanded(child: SizedBox(
      width: double.infinity,
      child: SCSelectCategoryFooter(list: getFooterList(), onTap: (int index, SCSelectCategoryModel model) {
        widget.footerTap?.call(index, model);
      },),
    ), );
  }

  /// header数据源
  List<SCSelectCategoryModel> getHeaderList() {
    if (widget.headerList.isEmpty) {
      SCSelectCategoryModel model = SCSelectCategoryModel.fromJson({"enable" : false, "title" : "请选择", "id" : ""});
      return [model];
    } else {
      return widget.headerList;
    }
  }

  /// footer数据源
  List<SCSelectCategoryModel> getFooterList() {
    if (widget.footerList.isEmpty) {
      return [];
    } else {
      return widget.footerList;
    }
  }

}