
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Constants/sc_asset.dart';

/// 新增入库、新增出库按钮

class SCAddEntryButton extends StatelessWidget {

  /// 按钮点击
  final Function? tapAction;

  final String name;

  SCAddEntryButton({Key? key,
    required this.name,
    this.tapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        tapAction?.call();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(SCAsset.iconAddEntryBg, width: 71.0, height: 71.0,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 14.0,),
              Image.asset(SCAsset.iconAddReceipt, width: 20.0, height: 20.0,),
              const SizedBox(height: 2.0,),
              Text(
                  name,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: SCFonts.f11,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_1B1D33)),
            ],
          ),
        ],
      ),
    );
  }
}