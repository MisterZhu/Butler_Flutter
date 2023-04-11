import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/View/Alert/sc_wainingtype_listview.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/View/Alert/sc_warningtype_bottomBtn.dart';

/// 预计类型弹窗

class SCWarningTypeView extends StatelessWidget {
  /// 第一列index
  final int index1;

  /// 第二列index
  final int index2;

  /// 第一列cell点击
  final Function(int index)? onTap1;

  /// 第二列cell点击
  final Function(int index)? onTap2;

  /// 重置
  final Function? resetAction;

  /// 确定
  final Function? sureAction;

  /// 关闭
  final Function? closeAction;

  SCWarningTypeView(
      {Key? key,
      required this.index1,
      required this.index2,
      this.onTap1,
      this.onTap2,
      this.resetAction,
      this.sureAction,
      this.closeAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: SCColors.color_000000.withOpacity(0.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          contentView(),
          Expanded(child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                closeAction?.call();
              }, child: Container(color: Colors.transparent,)),
          )
        ],
      ),
    );
  }

  /// contentView
  Widget contentView() {
    return Container(
      width: double.infinity,
      height: 294.0,
      color: SCColors.color_F7F8FA,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [topView(), bottomView()],
      ),
    );
  }

  /// topView
  Widget topView() {
    if (index1 < 0) {
      return Expanded(
        child: SizedBox(
          height: double.infinity,
          child: SCTypeListView(
            currentIndex: index1,
            cellType: SCTypeListViewType.type1,
            list: ['火警预警', '设备预警'],
            onTap: (int value) {
              onTap1?.call(value);
            },
          ),
        ),
      );
    } else {
      return Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: double.infinity,
                  child: SCTypeListView(
                    currentIndex: index1,
                    cellType: SCTypeListViewType.type1,
                    list: ['火警预警', '设备预警'],
                    onTap: (int value) {
                      onTap1?.call(value);
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: double.infinity,
                  color: SCColors.color_FFFFFF,
                  child: SCTypeListView(
                    currentIndex: index2,
                    cellType: SCTypeListViewType.type2,
                    list: ['一1', '二1', '三1'],
                    onTap: (int value) {
                      onTap2?.call(value);
                    },
                  ),
                ),
              )
            ],
          ));
    }
  }

  /// bottomView
  Widget bottomView() {
    return SCWarningTypeBottomBtn(
      resetAction: () {
        resetAction?.call();
      },
      sureAction: () {
        sureAction?.call();
      },
    );
  }
}
