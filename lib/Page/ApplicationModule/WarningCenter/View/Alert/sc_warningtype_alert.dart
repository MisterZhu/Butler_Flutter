import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/View/Alert/sc_wainingtype_listview.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/View/Alert/sc_warningtype_bottomBtn.dart';

import '../../Model/sc_warning_dealresult_model.dart';

/// 预计类型弹窗

class SCWarningTypeView extends StatefulWidget {

  /// 数据源
  final List<SCWarningDealResultModel> list;

  /// 第一列index
  final int index1;

  /// 第二列index
  final int index2;

  /// 重置
  final Function? resetAction;

  /// 确定
  final Function(int index1, int index2)? sureAction;

  /// 关闭
  final Function? closeAction;

  SCWarningTypeView(
      {Key? key,
        required this.list,
        required this.index1,
        required this.index2,
        this.resetAction,
        this.sureAction,
        this.closeAction})
      : super(key: key);

  @override
  SCWarningTypeViewState createState() => SCWarningTypeViewState();
}

class SCWarningTypeViewState extends State<SCWarningTypeView> {

  int currentIndex1 = -1;

  int currentIndex2 = -1;

  @override
  initState() {
    super.initState();
    currentIndex1 = widget.index1;
    currentIndex2 = widget.index2;
  }

  @override
  void didUpdateWidget(SCWarningTypeView oldWidget) {
    currentIndex1 = widget.index1;
    currentIndex2 = widget.index2;
    super.didUpdateWidget(oldWidget);
  }

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
                widget.closeAction?.call();
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
    if (currentIndex1 < 0) {
      return Expanded(
        child: SizedBox(
          height: double.infinity,
          child: SCTypeListView(
            currentIndex: currentIndex1,
            cellType: SCTypeListViewType.type1,
            list: getList1(),
            onTap: (int value) {
              setState(() {
                currentIndex1 = value;
              });
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
                    currentIndex: currentIndex1,
                    cellType: SCTypeListViewType.type1,
                    list: getList1(),
                    onTap: (int value) {
                      setState(() {
                        currentIndex1 = value;
                      });
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
                    currentIndex: currentIndex2,
                    cellType: SCTypeListViewType.type2,
                    list: getList2(),
                    onTap: (int value) {
                      setState(() {
                        currentIndex2 = value;
                      });
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
        widget.resetAction?.call();
      },
      sureAction: () {
        widget.sureAction?.call(currentIndex1, currentIndex2);
      },
    );
  }

  /// 第一列数据
  List getList1() {
    List subList = [];
    for (SCWarningDealResultModel model in widget.list) {
      subList.add(model.name);
    }
    return subList;
  }

  /// 第二列数据
  List getList2() {
    List subList = [];
    if (currentIndex1 >=0) {
      SCWarningDealResultModel model = widget.list[currentIndex1];
      for (SCWarningDealResultModel subModel in (model.pdictionary ?? [])) {
        subList.add(subModel.name);
      }
    }
    return subList;
  }
}
