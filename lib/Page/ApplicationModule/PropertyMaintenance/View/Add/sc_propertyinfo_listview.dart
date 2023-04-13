import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/PropertyMaintenance/View/Add/sc_property_range_cell.dart';

import '../../../../../Utils/Formatter/sc_precision_limitformatter.dart';
import '../../../MaterialEntry/View/AddEntry/sc_material_select_item.dart';

/// 资产维保信息listView

class SCPropertyInfoListView extends StatelessWidget {
  /// 统一维保单位
  final bool unifyCompany;

  /// 维保单位
  final String? company;

  /// 统一维保内容
  final bool unifyContent;

  /// 维保内容
  final String? content;

  /// 费用
  final double? price;

  /// 维保费用
  final Function(double value)? priceAction;

  /// 维保单位
  final Function(String value)? companyAction;

  /// 维保内容
  final Function(String value)? contentAction;

  const SCPropertyInfoListView({
    Key? key,
    required this.unifyCompany,
    required this.unifyContent,
    this.company,
    this.content,
    this.price,
    this.companyAction,
    this.contentAction,
    this.priceAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 0),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return cell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line(index);
        },
        itemCount: list().length);
  }

  /// cell
  Widget cell(int index) {
    var map = list()[index];
    int type = map['type'];
    String title = map['title'];
    String content = map['content'];
    // 输入框
    return SCMaterialSelectItem(
      isRequired: false,
      title: title,
      isInput: true,
      content: content,
      disable: false,
      hideArrow: true,
      keyboardType: type == 0 ? TextInputType.datetime : TextInputType.text,
      inputFormatters: type == 0 ? [SCPrecisionLimitFormatter(2)] : [],
      inputNameAction: (value) {
        if (type == 0) {
          // 费用
          if (value.isNotEmpty) {
            priceAction?.call(double.parse(value));
          }
        } else if (type == 1) {
          // 单位
          companyAction?.call(value);
        } else if (type == 1) {
          // 内容
          contentAction?.call(value);
        } else {}
      },
    );
  }

  /// line
  Widget line(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Container(
        color: SCColors.color_FFFFFF,
        child: Container(
          height: 0.5,
          width: double.infinity,
          color: SCColors.color_EDEDF0,
        ),
      ),
    );
  }

  /// 数据源
  List list() {
    /// type,0-费用,1-维保单位,2-维保内容
    String priceText;
    if (price == null) {
      priceText = "";
    } else {
      priceText = price!.toString();
    }
    List list = [];
    if (unifyCompany && unifyContent == false) {
      list = [
        {'title': '费用(元)', 'content': priceText, 'type': 0},
        {'title': '维保内容', 'content': content, 'type': 2},
      ];
    } else if (unifyCompany == false && unifyContent) {
      list = [
        {'title': '费用(元)', 'content': priceText, 'type': 0},
        {'title': '维保单位', 'content': company, 'type': 1},
      ];
    } else if (unifyCompany == false && unifyContent == false) {
      list = [
        {'title': '费用(元)', 'content': priceText, 'type': 0},
        {'title': '维保单位', 'content': company, 'type': 1},
        {'title': '维保内容', 'content': content, 'type': 2},
      ];
    } else {
      list = [
        {'title': '费用(元)', 'content': priceText, 'type': 0},
      ];
    }

    return list;
  }
}
