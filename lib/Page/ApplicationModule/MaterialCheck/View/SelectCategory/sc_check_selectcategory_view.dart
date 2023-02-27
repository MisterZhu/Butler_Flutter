import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialCheck/View/SelectCategory/sc_check_category_listview.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialCheck/View/SelectCategory/sc_check_selectcategory_headerview.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../Controller/sc_materialcheck_selectcategory_controller.dart';
import '../AddCheck/sc_check_category_bottom_view.dart';

/// 选择分类view

class SCCheckSelectCategoryView extends StatefulWidget {

  const SCCheckSelectCategoryView({Key? key, required this.controller}) : super(key: key);

  /// SCMaterialCheckSelectCategoryController
  final SCMaterialCheckSelectCategoryController controller;

  @override
  SCCheckSelectCategoryViewState createState() => SCCheckSelectCategoryViewState();
}

class SCCheckSelectCategoryViewState extends State<SCCheckSelectCategoryView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        headerView(),
        contentView(),
        footerView()
      ],
    );
  }

  /// header
  Widget headerView() {
    return SCCheckSelectCategoryHeaderView(list: widget.controller.headerList, onTap: (int index) {
      widget.controller.headerTap(index);
    },);
  }

  /// content
  Widget contentView() {
    return Expanded(child: SCCheckSelectCategoryListView(
        list: widget.controller.footerList,
      radioTap: (int index) {
          widget.controller.updateFooterData(index);
      },
      onTap: (int index) {
        widget.controller.updateHeaderList(index);
      },
    ));
  }

  /// footer
  Widget footerView() {
    return SCCheckCategoryBottomView(
      selectAllAction: (bool value) {
        selectAll(value);
      },
      sureAction: () {
        sure();
      },
    );
  }

  /// 全选
  selectAll(bool isSelect) {
    widget.controller.selectAllAction(isSelect);
  }

  /// 确定
  sure() {
    if (widget.controller.selectList.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectMaterialCategoryTip);
      return;
    }
    SCRouterHelper.back({"data" : List.from(widget.controller.selectList)});
  }
}
