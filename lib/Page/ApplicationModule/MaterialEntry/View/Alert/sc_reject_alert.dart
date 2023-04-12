import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Alert/sc_reject_node_alert.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../../WorkBench/Home/View/Alert/sc_alert_header_view.dart';
import '../../../HouseInspect/View/sc_bottom_button_item.dart';
import '../../../HouseInspect/View/sc_deliver_evidence_cell.dart';
import '../../../HouseInspect/View/sc_deliver_explain_cell.dart';
import '../AddEntry/sc_material_select_item.dart';

/// 驳回弹窗

class SCRejectAlert extends StatefulWidget {
  /// 标题
  final String title;

  /// 结果-title
  final String resultDes;

  /// 说明-title
  final String reasonDes;

  /// 标签list
  final List tagList;

  final bool showNode;

  /// 是否必填原因
  final bool? isRequired;

  /// 隐藏输入框底部提示标签
  final bool? hiddenTags;

  /// 确定
  final Function(int resultIndex, String explainValue, List imageList)?
      sureAction;

  SCRejectAlert({
    Key? key,
    required this.title,
    required this.resultDes,
    required this.reasonDes,
    required this.tagList,
    required this.showNode,
    this.isRequired,
    this.hiddenTags,
    this.sureAction,
  }) : super(key: key);

  @override
  SCRejectAlertState createState() => SCRejectAlertState();
}

class SCRejectAlertState extends State<SCRejectAlert> {
  late StreamSubscription<bool> keyboardSubscription;

  /// 是否弹起键盘
  bool isShowKeyboard = false;

  /// 结果index
  int resultIndex = -1;

  /// 节点
  String node = '';

  /// 输入的内容
  String input = '';

  /// 图片数组
  List photosList = [];

  @override
  initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();
    isShowKeyboard = keyboardVisibilityController.isVisible;
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        isShowKeyboard = visible;
      });
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = 395.0 +
        54.0 +
        MediaQuery.of(context).padding.bottom +
        (isShowKeyboard ? 100.0 : 0.0) +
        ((widget.tagList.isNotEmpty && ((widget.hiddenTags ?? false) == false)) ? 32 : 0.0);
    return GestureDetector(
        onTap: () {
          SCUtils().hideKeyboard(context: context);
        },
        child: Container(
          width: double.infinity,
          height: height,
          decoration: const BoxDecoration(
              color: SCColors.color_F2F3F5,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              titleItem(context),
              Expanded(child: listView()),
              const SizedBox(
                height: 20.0,
              ),
              SCBottomButtonItem(
                list: const ['取消', '确定'],
                buttonType: 1,
                leftTapAction: () {
                  Navigator.of(context).pop();
                },
                rightTapAction: () {
                  sureAction();
                },
              ),
            ],
          ),
        ));
  }

  /// listView
  Widget listView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
          decoration: BoxDecoration(
              color: SCColors.color_FFFFFF,
              borderRadius: BorderRadius.circular(4.0)),
          child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return getCell(index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: 2)),
    );
  }

  Widget getCell(int index) {
    if (index == 0) {
      return contentItem();
    } else if (index == 1) {
      return photosItem();
    } else {
      return const SizedBox(
        height: 10,
      );
    }
  }

  /// title
  Widget titleItem(BuildContext context) {
    return SCAlertHeaderView(
      title: widget.title,
      closeTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  /// contentItem
  Widget contentItem() {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nodeItem(),
          const SizedBox(
            height: 12.0,
          ),
          inputItem(),
          tagsView(),
        ]);
  }

  /// 节点item
  Widget nodeItem() {
    return Offstage(
      offstage: !widget.showNode,
      child: Column(
        children: [
          SCMaterialSelectItem(
            isRequired: true,
            title: widget.resultDes,
            content: node,
            selectAction: () {
              showNodeAlert();
            },
          ),
          line(),
        ],
      ),
    );
  }

  /// 输入框
  Widget inputItem() {
    bool needInput = widget.isRequired ?? false;
    return Container(
        padding: needInput
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: SCDeliverExplainCell(
          isRequired: needInput,
          title: widget.reasonDes,
          content: input,
          inputHeight: 92.0,
          inputAction: (String content) {
            input = content;
          },
        ));
  }

  /// 图片
  Widget photosItem() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: SCDeliverEvidenceCell(
          title: '上传照片',
          addIcon: SCAsset.iconMaterialAddPhoto,
          addPhotoType: SCAddPhotoType.all,
          files: photosList,
          updatePhoto: (List list) {
            setState(() {
              photosList = list;
            });
          },
        ));
  }

  /// tagsView
  Widget tagsView() {
    if (widget.tagList.isNotEmpty && (widget.hiddenTags ?? false) == false) {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 7.0,
          runSpacing: 10.0,
          children: widget.tagList
              .asMap()
              .keys
              .map((index) => cell(widget.tagList[index]))
              .toList(),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  /// cell
  Widget cell(String name) {
    return GestureDetector(
      onTap: () {
        setState(() {
          input = input + name;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 24.0,
        decoration: BoxDecoration(
          color: SCColors.color_F7F8FA,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
        child: Text(
          name,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: SCFonts.f12,
            color: SCColors.color_8D8E99,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  /// 节点弹窗
  showNodeAlert() {
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCRejectNodeAlert(
            title: widget.resultDes,
            list: widget.tagList,
            currentNode: node,
            tapAction: (value, index) {
              setState(() {
                node = value;
                resultIndex = index;
              });
            },
          ));
    });
  }

  /// line
  Widget line() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.only(left: 12.0),
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  /// 确定
  sureAction() {
    bool needInput = widget.isRequired ?? false;
    if (resultIndex < 0) {
      SCToast.showTip('请选择${widget.resultDes}');
      return;
    }

    if (needInput && input.isEmpty) {
      SCToast.showTip('请输入${widget.reasonDes}');
      return;
    }
    widget.sureAction?.call(resultIndex, input, photosList);
    Navigator.of(context).pop();
  }
}
