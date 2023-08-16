import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:sc_tools/sc_tools.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'sc_picker_header.dart';

/// picker类型
enum SCPickerType {
  // 普通的picker
  normal,
  // 日期picker
  date
}

/// picker
class SCPickerUtils {

  SCPickerUtils({
    this.title = '请选择',
    this.titleColor = SCColors.color_1B1D33,
    this.cancelText = '取消',
    this.cancelColor = SCColors.color_4285F4,
    this.sureText = '确定',
    this.sureColor = SCColors.color_4285F4,
    this.radius = 12.0,
    this.pickerType,
    this.pickerData
  });

  /// 标题
  String? title;

  /// 标题颜色
  Color? titleColor;

  /// 取消文本
  String? cancelText;

  /// 取消文本颜色
  Color? cancelColor;

  /// 确定文本
  String? sureText;

  /// 确定文本颜色
  Color? sureColor;

  /// 圆角
  final double? radius;

  SCPickerType? pickerType;

  List? pickerData;

  Function(List selectedValues, List selecteds)? completionHandler;

  late Picker _picker;

  /// 普通picker
  showPicker(BuildContext context) {
    double itemExtent = 48.0;
    TextStyle textStyle = const TextStyle(
        color: SCColors.color_B0B1B8, fontSize: SCFonts.f16);
    TextStyle selectStyle = const TextStyle(
        color: SCColors.color_1B1C33, fontSize: SCFonts.f18);
    Picker picker = Picker(
      height: 260.0,
      adapter: PickerDataAdapter<String>(pickerData: pickerData),
      changeToFirst: false,
      textAlign: TextAlign.center,
      textStyle: textStyle,
      selectedTextStyle: selectStyle,
      selectionOverlay: Container(
        height: itemExtent,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Divider(
              color: SCColors.color_EDEDF0,
              height: 0.5,
            ),
            Divider(
              color: SCColors.color_EDEDF0,
              height: 0.5,
            ),
          ],
        ),
      ),
      builderHeader: (BuildContext context) {
        return SCPickerHeader(
          title: title,
          titleColor: titleColor,
          cancelText: cancelText,
          cancelColor: cancelColor,
          sureText: sureText,
          sureColor: sureColor,
          radius: radius,
          sureTap: () {
            confirmAction(context);
          },
          cancelTap: () {
            cancelAction(context);
          },
        );
      },
    );
    picker.showModal(context);
    _picker = picker;
  }

  /// 日历picker
  showDatePicker({required BuildContext context ,required int dateType, List<int>? columnFlex, DateTime? minValue, DateTime? maxValue}) {
    double itemExtent = 48.0;
    TextStyle textStyle = const TextStyle(
        color: SCColors.color_B0B1B8, fontSize: SCFonts.f16);
    TextStyle selectStyle = const TextStyle(
        color: SCColors.color_1B1C33, fontSize: SCFonts.f18);
    Picker picker = Picker(
      height: 260.0,
      columnPadding: EdgeInsets.zero,
      columnFlex: columnFlex,
      adapter: DateTimePickerAdapter(
          type: dateType, isNumberMonth: true, yearSuffix: '年', monthSuffix: '月', daySuffix: '日', hourSuffix: '时', minuteSuffix: '分', minValue: minValue, maxValue: maxValue),
      changeToFirst: false,
      textAlign: TextAlign.center,
      textStyle: textStyle,
      selectedTextStyle: selectStyle,
      selectionOverlay: Container(
        height: itemExtent,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Divider(
              color: SCColors.color_EDEDF0,
              height: 0.5,
            ),
            Divider(
              color: SCColors.color_EDEDF0,
              height: 0.5,
            ),
          ],
        ),
      ),
      builderHeader: (BuildContext context) {
        return SCPickerHeader(
          title: title,
          titleColor: titleColor,
          cancelText: cancelText,
          cancelColor: cancelColor,
          sureText: sureText,
          sureColor: sureColor,
          radius: radius,
          sureTap: () {
            confirmAction(context);
          },
          cancelTap: () {
            cancelAction(context);
          },
        );
      },
    );
    picker.showModal(context);
    _picker = picker;
  }

  /// 确定
  confirmAction(BuildContext context) {
    Navigator.of(context).pop();
    if(pickerType ==  SCPickerType.date) {
      completionHandler?.call([(_picker.adapter as DateTimePickerAdapter).value], _picker.selecteds);
    } else {
      completionHandler?.call(_picker.getSelectedValues(), _picker.selecteds);
    }
  }

  /// 取消
  cancelAction(BuildContext context) {
    Navigator.of(context).pop();
  }
}
