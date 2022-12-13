import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Constants/sc_asset.dart';

/// 弹窗-header

class SCAlertHeaderView extends StatelessWidget {
  const SCAlertHeaderView({Key? key, this.closeTap, this.title})
      : super(key: key);

  /// 关闭
  final Function? closeTap;

  /// title
  final String? title;

  @override
  Widget build(BuildContext context) {
    return titleItem();
  }

  /// header
  Widget titleItem() {
    String titleText = title ?? '';
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 16.0),
      height: 48.0,
      child: Row(
        children: [
          Expanded(
            child: Text(
              titleText,
              maxLines: 1,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: SCFonts.f16,
                  fontWeight: FontWeight.w500,
                  color: SCColors.color_1B1D33),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          SizedBox(
            width: 52.0,
            height: 48.0,
            child: SizedBox.expand(
              child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: 48.0,
                  child: Image.asset(
                    SCAsset.iconHomeAlertClose,
                    width: 20.0,
                    height: 20.0,
                  ),
                  onPressed: () {
                    closeTap?.call();
                  }),
            ),
          )
        ],
      ),
    );
  }
}
