import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../../Utils/Date/sc_date_utils.dart';
import '../../../../WorkBench/Home/View/PageView/sc_workbench_time_view.dart';
import '../../../MaterialEntry/Model/sc_material_task_detail_model.dart';

/// 盘点详情定时器view

class SCCheckDetailTimerView extends StatefulWidget {

  const SCCheckDetailTimerView({Key? key, required this.model, required this.remainingTime}) : super(key: key);

  /// 盘点详情model
  final SCMaterialTaskDetailModel model;

  /// 盘点剩余时间
  final int remainingTime;

  @override
  SCCheckDetailTimerViewState createState() => SCCheckDetailTimerViewState();
}

class SCCheckDetailTimerViewState extends State<SCCheckDetailTimerView>{
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('剩余时间', style: TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_5E5F66
        ),),
        const SizedBox(width: 6.0,),
        SCWorkBenchTimeView(time: widget.remainingTime),
        const Expanded(child: Text('盘点中', textAlign: TextAlign.right, style: TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: SCColors.color_0849B5
        ),))
      ],
    );
  }

}