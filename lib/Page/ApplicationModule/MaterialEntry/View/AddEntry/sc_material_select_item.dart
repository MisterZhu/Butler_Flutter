
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Constants/sc_asset.dart';

/// 选择item

class SCMaterialSelectItem extends StatelessWidget {

  /// 是否必填
  bool isRequired;

  /// 标题
  final String title;

  /// 内容
  final String? content;

  /// 选择类型
  final Function? selectAction;

  /// 是否不可用
  final bool? disable;

  SCMaterialSelectItem({Key? key,
    required this.isRequired,
    required this.title,
    this.content,
    this.selectAction,
    this.disable
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    Color textColor;
    String subContent = content ?? '';
    bool subDisable = disable ?? false;
    if (subContent.isEmpty) {
      textColor = SCColors.color_B0B1B8;
    } else {
      if (subDisable) {
        textColor = SCColors.color_B0B1B8;
      } else {
        textColor = SCColors.color_1B1D33;
      }
    }
    return GestureDetector(
      onTap: () {
        if (!subDisable) {
          selectAction?.call();
        }
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 48.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 12.0,
              alignment: Alignment.centerRight,
              child: Text(
                '*',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: SCFonts.f16,
                    fontWeight: FontWeight.w400,
                    color: isRequired ? SCColors.color_FF4040 : Colors.transparent)),),
            SizedBox(
              width: 100.0,
              child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: SCFonts.f16,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_1B1D33)),
            ),
            const SizedBox(width: 12.0,),
            Expanded(child: Text(
                content != '' ? content! : '请选择',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SCFonts.f16,
                    fontWeight: FontWeight.w400,
                    color: textColor)),),
            const SizedBox(width: 12.0,),
            Image.asset(
              SCAsset.iconMineSettingArrow,
              width: 16.0,
              height: 16.0,
            ),
            const SizedBox(width: 12.0,),
          ],
        ),
      ),
    );
  }

}