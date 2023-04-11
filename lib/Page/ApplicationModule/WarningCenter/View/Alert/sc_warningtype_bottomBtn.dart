import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 底部按钮

class SCWarningTypeBottomBtn extends StatelessWidget {
  /// 重置
  final Function? resetAction;

  /// 确定
  final Function? sureAction;

  const SCWarningTypeBottomBtn(
      {Key? key, this.resetAction, this.sureAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: SCColors.color_FFFFFF,
      child: Row(
        children: [
          SizedBox(
            width: 80.0,
            height: 40.0,
            child: CupertinoButton(
                padding: EdgeInsets.zero,
                minSize: 40.0,
                color: SCColors.color_F5F5F5,
                borderRadius: BorderRadius.circular(4.0),
                child: const Text(
                  '重置',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: SCFonts.f16,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_1B1D33),
                ),
                onPressed: () {
                  resetAction?.call();
                }),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
              child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: 40.0,
                  color: SCColors.color_4285F4,
                  borderRadius: BorderRadius.circular(4.0),
                  child: const Text(
                    '确定',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: SCFonts.f16,
                        fontWeight: FontWeight.w400,
                        color: SCColors.color_FFFFFF),
                  ),
                  onPressed: () {
                    sureAction?.call();
                  }))
        ],
      ),
    );
  }
}
