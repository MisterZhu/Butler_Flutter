import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../../Utils/Date/sc_date_utils.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../../WorkBench/Home/View/Alert/sc_alert_header_view.dart';
import '../../../HouseInspect/View/sc_bottom_button_item.dart';
import '../../../HouseInspect/View/sc_deliver_evidence_cell.dart';
import '../../../HouseInspect/View/sc_deliver_explain_cell.dart';
import '../../../MaterialEntry/View/AddEntry/sc_material_select_item.dart';

/// 出库确认弹窗

class SCOutboundConfirmAlert extends StatefulWidget {

  /// 确定按钮点击
  final Function(String time, String input)? sureAction;

  SCOutboundConfirmAlert({Key? key, this.sureAction,}) : super(key: key);

  @override
  SCOutboundConfirmAlertState createState() => SCOutboundConfirmAlertState();
}

class SCOutboundConfirmAlertState extends State<SCOutboundConfirmAlert> {

  /// 出库时间，页面展示
  String time = '';

  /// 输入的内容
  String input = '';

  /// 图片数组
  List photosList = [];

  /// 出库时间，出库确认接口传参需要
  String outTime = '';

  /// 监听键盘
  late StreamSubscription<bool> keyboardSubscription;

  /// 是否显示键盘
  bool keyboardVisible = false;

  @override
  initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
          setState(() {
            keyboardVisible = visible;
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
    return GestureDetector(
        onTap: () {
          SCUtils().hideKeyboard(context: context);
        },
        child: Container(
          width: double.infinity,
          height: keyboardVisible ? (MediaQuery.of(context).size.height - 160.0) : (395.0 + 54.0 + MediaQuery.of(context).padding.bottom),
          decoration: const BoxDecoration(
              color: SCColors.color_F2F3F5,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0))
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              titleItem(context),
              Expanded(child: listView()),
              const SizedBox(height: 20.0,),
              SCBottomButtonItem(list: const ['取消', '确定'], buttonType: 1, leftTapAction: () {
                Navigator.of(context).pop();
              }, rightTapAction: () {
                if (outTime.isEmpty) {
                  SCToast.showTip('请选择出库时间');
                  return;
                }
                widget.sureAction?.call(outTime, input);
                Navigator.of(context).pop();
              },),
            ],
          ),
        )
    );
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
                return const SizedBox(height: 10,);
              },
              itemCount: 1)),
    );
  }

  Widget getCell(int index) {
    if (index == 0) {
      return contentItem();
    } else if (index == 1) {
      return photosItem();
    } else {
      return const SizedBox(height: 10,);
    }
  }

  /// title
  Widget titleItem(BuildContext context) {
    return SCAlertHeaderView(
      title: '出库确认',
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
          timeItem(),
          const SizedBox(height: 12.0,),
          inputItem(),
        ]
    );
  }

  /// 出库时间
  Widget timeItem() {
    return Column(
      children: [
        SCMaterialSelectItem(isRequired: true, title: '出库时间', content: time, selectAction: () {
          showTimeAlert(context);
        },),
        line(),
      ],
    );
  }

  /// 输入框
  Widget inputItem() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: SCDeliverExplainCell(title: '备注', content: input, inputHeight: 92.0, inputAction: (String content) {
          input = content;
        },)
    );
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
            photosList = list;
          },)
    );
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
          ),),
      ),
    );
  }

  /// 出库时间弹窗
  showTimeAlert (BuildContext context) {
    DateTime now = DateTime.now();
    SCPickerUtils pickerUtils = SCPickerUtils();
    pickerUtils.title = '出库时间';
    pickerUtils.cancelText = '上一步';
    pickerUtils.pickerType = SCPickerType.date;
    pickerUtils.completionHandler = (selectedValues, selecteds) {
      DateTime value = selectedValues.first;
      setState(() {
        time = formatDate(value, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn]);
        outTime = formatDate(value, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]);
      });
    };
    pickerUtils.showDatePicker(
      context: context,
      dateType: PickerDateTimeType.kYMDHM,
      minValue: DateTime(now.year - 1, 1, 1, 00, 00),
      maxValue: DateTime(now.year + 1, 12, 31, 23, 59)
    );
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

}