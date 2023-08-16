import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

/// 切换空间alert-header

class SCChangeSpaceAlertHeader extends StatelessWidget {
  const SCChangeSpaceAlertHeader(
      {Key? key, required this.title, this.onCancel, this.onSure})
      : super(key: key);

  /// title
  final String title;

  /// 取消
  final Function? onCancel;

  /// 确定
  final Function? onSure;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: Row(
        children: [
          CupertinoButton(
              minSize: 48.0,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset(
                SCAsset.iconBlackClose,
                width: 20.0,
                height: 20.0,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onCancel?.call();
              }),
          Expanded(
              child: Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w500,
                color: SCColors.color_1B1C35),
          )),
          CupertinoButton(
              minSize: 48.0,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                '确定',
                style: TextStyle(
                    fontSize: SCFonts.f15,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_4285F4),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onSure?.call();
              }),
        ],
      ),
    );
  }
}
