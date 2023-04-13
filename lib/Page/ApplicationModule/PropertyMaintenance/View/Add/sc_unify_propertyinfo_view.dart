import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/PropertyMaintenance/View/Add/sc_property_range_cell.dart';

import '../../../MaterialEntry/View/AddEntry/sc_material_select_item.dart';

/// 统一资产维保信息view

class SCUnifyPropertyInfoView extends StatelessWidget {
  /// 统一维保单位
  final bool unifyCompany;

  /// 维保单位
  final String? company;

  /// 统一维保内容
  final bool unifyContent;

  /// 维保内容
  final String? content;

  /// 是否统一维保单位
  final Function(bool value)? unifyCompanyAction;

  /// 是否统一维保内容
  final Function(bool value)? unifyContentAction;

  /// 统一维保内容
  final Function(String value)? companyAction;

  /// 维保内容
  final Function(String value)? contentAction;

  const SCUnifyPropertyInfoView(
      {Key? key,
      required this.unifyCompany,
      required this.unifyContent,
      this.company,
      this.content,
      this.companyAction,
      this.contentAction,
      this.unifyCompanyAction,
      this.unifyContentAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 0),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if (index == list().length) {
            return const SizedBox();
          }
          return cell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line(index);
        },
        itemCount: list().length + 1);
  }

  /// cell
  Widget cell(int index) {
    var map = list()[index];
    int type = map['type'];
    String title = map['title'];
    String content = map['content'];
    bool select = map['select'];
    if (type == 0) {
      // 单选框
      return SCPropertyRangeCell(
        title: title,
        disableEditRange: false,
        rangeValue: select ? 0 : 1,
        rangeList: const ['是', '否'],
        selectRangeAction: (int value) {
          if (index == 0) {
            unifyCompanyAction?.call(value == 0 ? true : false);
          } else {
            unifyContentAction?.call(value == 0 ? true : false);
          }
        },
      );
    } else if (type == 1) {
      // 输入框
      return SCMaterialSelectItem(
        isRequired: false,
        title: title,
        isInput: true,
        content: content,
        disable: false,
        hideArrow: true,
        keyboardType: TextInputType.text,
        inputFormatters: [],
        inputNameAction: (value) {
          if (index == 1) {
            companyAction?.call(value);
          } else {
            contentAction?.call(value);
          }
        },
      );
    } else {
      return const SizedBox();
    }
  }

  /// line
  Widget line(int index) {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.only(left: 12.0),
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  /// 数据源
  List list() {
    /// type,0-单选框, 1-输入框
    List list = [];
    if (unifyCompany && unifyContent == false) {
      list = [
        {
          'type': 0,
          'title': '统一维保单位',
          'content': '',
          'select': unifyCompany,
        },
        {'type': 1, 'title': '维保单位', 'content': '', 'select': false},
        {'type': 0, 'title': '统一维保内容', 'content': '', 'select': unifyContent},
      ];
    } else if (unifyCompany == false && unifyContent) {
      list = [
        {'type': 0, 'title': '统一维保单位', 'content': '', 'select': unifyCompany},
        {'type': 0, 'title': '统一维保内容', 'content': '', 'select': unifyContent},
        {'type': 1, 'title': '维保内容', 'content': '', 'select': false},
      ];
    } else if (unifyCompany == false && unifyContent == false) {
      list = [
        {'type': 0, 'title': '统一维保单位', 'content': '', 'select': unifyCompany},
        {'type': 0, 'title': '统一维保内容', 'content': '', 'select': unifyContent},
      ];
    } else {
      list = [
        {'type': 0, 'title': '统一维保单位', 'content': '', 'select': unifyCompany},
        {'type': 1, 'title': '维保单位', 'content': '', 'select': false},
        {'type': 0, 'title': '统一维保内容', 'content': '', 'select': unifyContent},
        {'type': 1, 'title': '维保内容', 'content': '', 'select': false},
      ];
    }

    return list;
  }
}
