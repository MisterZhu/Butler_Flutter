import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

/// 选择项目alert-header

class SCCommunityAlertHeader extends StatelessWidget {
  const SCCommunityAlertHeader(
      {Key? key, required this.title, this.onCancel})
      : super(key: key);

  /// title
  final String title;

  /// 取消
  final Function? onCancel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: Row(
        children: [
          const SizedBox(
            width: 48.0,
          ),
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
              child: Image.asset(
                SCAsset.iconBlackClose,
                width: 20.0,
                height: 20.0,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onCancel?.call();
              }),
        ],
      ),
    );
  }
}
