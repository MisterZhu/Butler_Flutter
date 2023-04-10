import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../MaterialEntry/Model/sc_material_task_detail_model.dart';

/// 资产维保-统一单位或内容详情view

class SCUnifyCompanyDetailView extends StatelessWidget {
  /// 统一维保单位
  final bool unifyCompany;

  /// 维保单位
  final String? maintenanceCompany;

  /// 统一维保内容
  final bool unifyContent;

  /// 维保内容
  final String? maintenanceContent;

  const SCUnifyCompanyDetailView(
      {Key? key,
      required this.unifyCompany,
      required this.unifyContent,
      this.maintenanceCompany,
      this.maintenanceContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Offstage(
          offstage: !unifyCompany,
          child: rowCell('统一维保单位', maintenanceCompany ?? '', 10),
        ),
        Offstage(
          offstage: !unifyContent,
          child: rowCell('统一维保内容', maintenanceContent ?? '', 10),
        )
      ],
    );
  }

  /// 行cell
  Widget rowCell(String title, String content, int maxLines) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [desLabel(title), textView(maxLines, content)],
      ),
    );
  }

  /// description-label
  Widget desLabel(String text) {
    return SizedBox(
      width: 100.0,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        strutStyle: const StrutStyle(
          fontSize: SCFonts.f14,
          height: 1.25,
          forceStrutHeight: true,
        ),
        style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_5E5F66,
        ),
      ),
    );
  }

  /// 普通label
  Widget textView(int maxLines, String text) {
    return Expanded(
        child: Text(
      text,
      textAlign: TextAlign.right,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      strutStyle: const StrutStyle(
        fontSize: SCFonts.f14,
        height: 1.25,
        forceStrutHeight: true,
      ),
      style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_1B1D33),
    ));
  }
}
