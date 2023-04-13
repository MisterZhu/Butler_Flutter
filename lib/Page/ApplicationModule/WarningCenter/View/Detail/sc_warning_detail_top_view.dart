
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/View/Detail/sc_warning_detail_text_cell.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Network/sc_config.dart';
import '../../Controller/sc_warning_detail_controller.dart';

/// 预警详情-topView
class SCWarningDetailTopView extends StatelessWidget {

  /// SCWarningDetailController
  final SCWarningDetailController state;

  SCWarningDetailTopView({Key? key, required this.state}): super(key: key);

  List tagList = ['严重'];

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
          nameItem('正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正测试标题11111111'),
          const SizedBox(
            height: 12.0,
          ),
          SCWarningDetailTextCell(leftText: '预警编号', rightText: 'YJ20230308000406',),
          const SizedBox(
            height: 12.0,
          ),
          SCWarningDetailTextCell(leftText: '预警日期', rightText: '2023-02-21 18:00:00',),
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
          Image.asset(SCAsset.iconWarningTypeOrange, width: 18.0, height: 18.0,),
          const SizedBox(width: 6.0,),
          const Expanded(child: Text(
              '火警预警',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_1B1D33)),),
          const SizedBox(width: 20.0,),
          SizedBox(
            width: 82.0,
            child: Text(
                '处理中',
                maxLines: 1,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_4285F4)),
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
                return tagCell(index);
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
      return const SizedBox(height: 0.0,);
    }
  }

  Widget tagCell(int index) {
    return Container(
        height: 17.0,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: SCColors.color_F2F3F5,
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Text(
          tagList[index],
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: SCFonts.f12,
            fontWeight: FontWeight.w400,
            color: SCColors.color_5E5F66,
          ),
        )
    );
  }

  /// nameItem
  Widget nameItem(String name) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
        child: Text(
          name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w500,
              fontFamilyFallback: SCConfig.getPFSCForIOS(),
              color: SCColors.color_1B1D33),
        ));
  }
}
