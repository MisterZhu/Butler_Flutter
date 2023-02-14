import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

/// 数量步进器

class SCStepper extends StatefulWidget {

  SCStepper({Key? key, this.numChangeAction, this.num = 1}) : super(key: key);

  /// 数量改变回调
  final Function(int num)? numChangeAction;

  /// 默认数量
  int? num;

  @override
  SCStepperState createState() => SCStepperState();
}

class SCStepperState extends State<SCStepper> {
  /// textFiledController
  late TextEditingController textFiledController;

  /// focusNode
  FocusNode node = FocusNode();

  @override
  initState() {
    super.initState();
    int num = widget.num ?? 1;
    textFiledController = TextEditingController.fromValue(TextEditingValue(text: '$num', selection: TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: '$num'.length))));
  }

  @override
  dispose() {
    textFiledController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SCStepper oldWidget) {
    textFiledController.text = '${widget.num}';
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 83.0,
      height: 22.0,
      decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: SCColors.color_D8D8D8),
          borderRadius: BorderRadius.circular(2.0)),
      child: Row(
        children: [subtractView(), line(), textField(), line(), addView()],
      ),
    );
  }

  /// -
  Widget subtractView() {
    return Container(
      width: 24.0,
      height: 22.0,
      alignment: Alignment.center,
      child: CupertinoButton(
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          minSize: 22.0,
          child: const Text(
            '-',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w400,
                color: SCColors.color_5E5F66),
          ),
          onPressed: () {
            delete();
          }),
    );
  }

  /// +
  Widget addView() {
    return Container(
      width: 24.0,
      height: 22.0,
      alignment: Alignment.center,
      child: CupertinoButton(
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          minSize: 22.0,
          child: const Text(
            '+',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w400,
                color: SCColors.color_5E5F66),
          ),
          onPressed: () {
            add();
          }),
    );
  }

  /// 竖线
  Widget line() {
    return Container(
      width: 0.5,
      color: SCColors.color_D8D8D8,
    );
  }

  /// 输入框
  Widget textField() {
    return Expanded(
        child: TextField(
      textAlign: TextAlign.center,
      controller: textFiledController,
      maxLines: 1,
      cursorColor: SCColors.color_5E5F66,
      cursorWidth: 2,
      focusNode: node,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(SCDefaultValue.positiveNumberReg))
      ],
      style:
          const TextStyle(fontSize: SCFonts.f12, color: SCColors.color_5E5F66),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: "",
        hintStyle:
            TextStyle(fontSize: SCFonts.f12, color: SCColors.color_5E5F66),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        isCollapsed: true,
      ),
      onChanged: (value) {
        updateText(value);
      },
      keyboardType: TextInputType.number,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.next,
    ));
  }

  /// 加
  add() {
    setState(() {
      int num = widget.num ?? 1;
      num++;
      textFiledController.text = '$num';
      textFiledController.selection = TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: '$num'.length));
      widget.numChangeAction?.call(num);
      widget.num = num;
    });
  }

  /// 减
  delete() {
    setState(() {
      int num = widget.num ?? 1;
      if (num > 1) {
        num--;
        textFiledController.text = '$num';
        textFiledController.selection = TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: '$num'.length));
        widget.numChangeAction?.call(num);
        widget.num = num;
      }
    });
  }

  /// 更新输入框
  updateText(String value) {
    int num = widget.num ?? 1;
    if (value.isEmpty) {
      num = 1;
      textFiledController.text = '$num';
      textFiledController.selection = TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: '$num'.length));
      widget.numChangeAction?.call(num);
    } else {
      if (SCUtils().isPositiveNumber(value)) {
        num = int.parse(value);
        widget.numChangeAction?.call(num);
      }
    }
    widget.num = num;
  }
}
