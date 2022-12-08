import 'package:flutter/cupertino.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

/// 工作台-切换空间

class SCWorkBenchSwitchSpaceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(SCAsset.iconUserDefault, width: 32.0, height: 32.0,)
      ],
    );
  }
}
