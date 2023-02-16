import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_selectcategory_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/SelectCategoryAlert/sc_selectcategory_footer_cell.dart';

import 'sc_selectcategory_header_cell.dart';

/// 选择分类footer

class SCSelectCategoryFooter extends StatefulWidget {

  const SCSelectCategoryFooter({Key? key, required this.list, this.onTap}) : super(key: key);

  /// 数据源
  final List<SCSelectCategoryModel> list;

  /// cell点击
  final Function(int index, SCSelectCategoryModel model)? onTap;

  @override
  SCSelectCategoryFooterState createState() => SCSelectCategoryFooterState();
}

class SCSelectCategoryFooterState extends State<SCSelectCategoryFooter> {

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Column(
      children: [
        headerView(),
        listView()
      ],
    );
  }

  /// header
  Widget headerView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      height: 44.0,
      child: const Text("请选择", style: TextStyle(
        fontSize: SCFonts.f14,
        fontWeight: FontWeight.w400,
        color: SCColors.color_8D8E99
      ),),
    );
  }

  /// listView
  Widget listView() {
    return Expanded(child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return cell(index);
        }, separatorBuilder: (BuildContext context, int index) {
      return line(index);
    }, itemCount: widget.list.length));
  }

  /// cell
  Widget cell(int index) {
    return SCSelectCategoryFooterCell(
      model: widget.list[index],
      onTap: () {
        widget.onTap?.call(index, widget.list[index]);
      },
    );
  }

  /// line
  Widget line(int index) {
    return const SizedBox();
  }
}