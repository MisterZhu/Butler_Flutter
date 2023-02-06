import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 数量步进器

class SCStepper extends StatefulWidget {
  @override
  SCStepperState createState() => SCStepperState();
}

class SCStepperState extends State<SCStepper> {
  /// textFiledController
  late TextEditingController textFiledController;

  /// focusNode
  FocusNode node = FocusNode();

  /// 数量
  int num = 1;

  @override
  initState() {
    super.initState();
    textFiledController = TextEditingController(text: '$num');
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
      num++;
      textFiledController.text = '$num';
    });
  }

  /// 减
  delete() {
    setState(() {
      if (num > 0) {
        num--;
        textFiledController.text = '$num';
      }
    });
  }

  /// 更新输入框
  updateText(String value) {
  }
}
