

import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../Constants/sc_asset.dart';

/// 消息cell

class SCMessageCell extends StatelessWidget {

  /// 类型
  final int type;

  /// 打电话
  final Function(String phone)? callAction;

  /// 按钮点击
  final Function? btnTapAction;

  /// 详情
  final Function? detailTapAction;

  SCMessageCell({Key? key,
    required this.type,
    this.callAction,
    this.btnTapAction,
    this.detailTapAction,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return body();
  }


  Widget body() {
    return GestureDetector(
      onTap: () {
        detailTapAction?.call();
      },
      child: Container(
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
          ],
        ),
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
          Image.asset(SCAsset.iconMaterialIcon, width: 18.0, height: 18.0,),
          const SizedBox(width: 6.0,),
          Expanded(child: Text(
              '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_1B1D33)),),
          const SizedBox(width: 6.0,),
          Text(
              '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_1B1D33))
        ],
      ),
    );
  }


}