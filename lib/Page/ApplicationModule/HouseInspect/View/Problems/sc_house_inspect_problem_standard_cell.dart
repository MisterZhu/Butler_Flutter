
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 验房-问题-验房标准

class SCHouseInspectProblemStandardCell extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '验房标准：',
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: SCFonts.f16,
              color: SCColors.color_1B1D33,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 6.0,),
          Text(
            '1、详细检查房屋质量，有无开裂现象。\n2、检查墙体平整度，是否渗水，是否有裂缝。\n3、仔细检查地面有无空壳开裂情况',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: SCFonts.f14,
              color: SCColors.color_5E5F66,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}



