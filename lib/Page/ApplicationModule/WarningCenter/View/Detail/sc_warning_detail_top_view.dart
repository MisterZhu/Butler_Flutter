import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/Other/sc_warning_utils.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/View/Detail/sc_warning_detail_text_cell.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Network/sc_config.dart';
import '../../Controller/sc_warning_detail_controller.dart';

/// 预警详情-topView
class SCWarningDetailTopView extends StatelessWidget {
  /// SCWarningDetailController
  final SCWarningDetailController state;

  SCWarningDetailTopView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleView(),
          const SizedBox(
            height: 12.0,
          ),
          lineItem(),
          const SizedBox(
            height: 12.0,
          ),
          tagsItem(),
          nameItem(state.alertContext),
          const SizedBox(
            height: 12.0,
          ),
          SCWarningDetailTextCell(
            leftText: '预警编号',
            rightText: state.detailModel.alertCode ?? '',
          ),
          const SizedBox(
            height: 12.0,
          ),
          SCWarningDetailTextCell(
            leftText: '预警日期',
            rightText: state.detailModel.generationTime ?? '',
          ),
        ],
      ),
    );
  }

  /// title
  Widget titleView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            SCAsset.iconMaterialIcon,
            width: 18.0,
            height: 18.0,
          ),
          const SizedBox(
            width: 6.0,
          ),
          Expanded(
            child: Text(state.detailModel.ruleName ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_1B1D33)),
          ),
          const SizedBox(
            width: 20.0,
          ),
          SizedBox(
            width: 82.0,
            child: Text(state.detailModel.statusName ?? '',
                maxLines: 1,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w400,
                    color: SCWarningCenterUtils.getStatusColor(
                        state.detailModel.status ?? -1))),
          )
        ],
      ),
    );
  }

  /// lineItem
  Widget lineItem() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Container(
        height: 0.5,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  /// 标签
  Widget tagsItem() {
    List tagList = [state.detailModel.levelName ?? ''];
    if (tagList.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: SizedBox(
          height: 17.0,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return tagCell(index, tagList);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 8.0,
                );
              },
              itemCount: tagList.length),
        ),
      );
    } else {
      return const SizedBox(
        height: 0.0,
      );
    }
  }

  /// tagCell
  Widget tagCell(int index, List tagList) {
    return Container(
        height: 17.0,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: SCWarningCenterUtils.getLevelBGColor(
              state.detailModel.levelId ?? -1),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Text(
          tagList[index],
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: SCFonts.f12,
            fontWeight: FontWeight.w400,
            color: SCWarningCenterUtils.getLevelTextColor(
                state.detailModel.levelId ?? -1),
          ),
        ));
  }

  /// nameItem
  Widget nameItem(String name) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
        child: Text(
          name,
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w500,
              fontFamilyFallback: SCConfig.getPFSCForIOS(),
              color: SCColors.color_1B1D33),
        ));
  }
}
