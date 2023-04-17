
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Utils/sc_utils.dart';

/// 预警详情-textcell
class SCWarningDetailTextCell extends StatelessWidget {

  final String leftText;

  final String? rightText;

  final String? mobile;

  final bool? isContact;

  /// 打电话
  final Function(String phone)? callAction;

  SCWarningDetailTextCell({Key? key,
    required this.leftText,
    this.rightText,
    this.mobile,
    this.isContact,
    this.callAction}): super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.0,
            child: Text(
                leftText,
                maxLines: 1,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_5E5F66)),
          ),
          const SizedBox(width: 10.0,),
          Expanded(child: rightItem(),),
        ],
      ),
    );
  }

  Widget rightItem() {
    if (isContact == true) {
      return CupertinoButton(
          minSize: 22.0,
          padding: EdgeInsets.zero,
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    rightText ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: SCFonts.f14,
                        fontWeight: FontWeight.w400,
                        color: SCColors.color_1B1D33),
                  ),
                  SizedBox(
                    width: rightText == null ? 0.0 : 8.0,
                  ),
                  Offstage(
                    offstage: rightText == null,
                    child: Image.asset(
                      SCAsset.iconContactPhone,
                      width: 20.0,
                      height: 20.0,
                    ),
                  ),
                ],
              )
            ],
          ),
          onPressed: () {
            //callAction?.call(mobile ?? '');
            SCUtils.call(mobile ?? '');
          });
    } else {
      return Text(
          rightText ?? '',
          maxLines: 2,
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_1B1D33));
    }
  }

}

