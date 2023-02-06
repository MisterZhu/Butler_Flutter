
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Constants/sc_asset.dart';

/// 选择item

class SCMaterialSelectItem extends StatelessWidget {

  /// 标题
  final String title;

  /// 内容
  final String? content;

  /// 选择类型
  final Function? selectAction;

  SCMaterialSelectItem({Key? key,
    required this.title,
    this.content,
    this.selectAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return GestureDetector(
      onTap: () {
        selectAction?.call();
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 48.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 6.0,),
            const Text(
                '*',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SCFonts.f16,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_FF4040)),
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
                    color: content != '' ? SCColors.color_1B1D33 : SCColors.color_B0B1B8)),),
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