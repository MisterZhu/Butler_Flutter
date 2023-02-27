import 'package:flutter/cupertino.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialCheck/View/SelectCategory/sc_bottom_checkall_view.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialCheck/View/SelectCategory/sc_check_category_listview.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialCheck/View/SelectCategory/sc_check_selectcategory_headerview.dart';

import '../../Controller/sc_materialcheck_selectcategory_controller.dart';

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
    return SCBottomCheckAllView();
  }

  /// 展开
  detailAction() {

  }
}
