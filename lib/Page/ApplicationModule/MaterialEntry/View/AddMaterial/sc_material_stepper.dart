import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Utils/Keyboard/sc_keyboard.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

/// 数量步进器

class SCStepper extends StatefulWidget {
  SCStepper({Key? key, this.numChangeAction, this.num = 1, this.showDone, this.isSupportZero}) : super(key: key);

  /// 数量改变回调
  final Function(int num)? numChangeAction;

  /// 默认数量
  int? num;

  /// 是否显示完成按钮
  final bool? showDone;

  /// 是否支持输入0
  final bool? isSupportZero;

  @override
  SCStepperState createState() => SCStepperState();
}

class SCStepperState extends State<SCStepper> {
  /// textFiledController
  late TextEditingController textFiledController;

  /// focusNode
  FocusNode node = FocusNode();

  late StreamSubscription<bool> keyboardSubscription;

  @override
  initState() {
    super.initState();
    int num = widget.num ?? 1;
    textFiledController = TextEditingController();
    textFiledController.value = TextEditingValue(
        text: num.toString(),
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: num.toString().length)));
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        editCompleteAction(textFiledController.text);
      }
    });
  }

  @override
  dispose() {
    textFiledController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SCStepper oldWidget) {
    int num = widget.num ?? 1;
    textFiledController.value = TextEditingValue(
        text: num.toString(),
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: num.toString().length)));
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
      child: body(context),
    );
  }

  /// body
  Widget body(BuildContext context) {
    bool showDone = widget.showDone ?? false;
    if (showDone) {
      return KeyboardActions(
        disableScroll: true,
        bottomAvoiderScrollPhysics: const NeverScrollableScrollPhysics(),
        config: SCKeyboard.keyboardConfig(node: node, context: context),
        child: Row(
          children: [subtractView(), line(), textField(), line(), addView()],
        ),
      );
    } else {
      return Row(
        children: [subtractView(), line(), textField(), line(), addView()],
      );
    }
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
      height: 22.0,
      color: SCColors.color_D8D8D8,
    );
  }

  /// 输入框
  Widget textField() {
    bool isSupportZero = widget.isSupportZero ?? false;
    List<TextInputFormatter> formatterList = [];
    if (isSupportZero) {
      formatterList = [
        FilteringTextInputFormatter.allow(
            RegExp(SCDefaultValue.nonNegativeReg))
      ];
    } else {
      formatterList = [
        FilteringTextInputFormatter.allow(
            RegExp(SCDefaultValue.positiveNumberReg))
      ];
    }
    return Expanded(
        child: TextField(
      textAlign: TextAlign.center,
      controller: textFiledController,
      maxLines: 1,
      cursorColor: SCColors.color_5E5F66,
      cursorWidth: 2,
      focusNode: node,
      inputFormatters: formatterList,
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
      onEditingComplete: () {},
      onSubmitted: (value) {},
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
      textFiledController.value = TextEditingValue(
          text: num.toString(),
          selection: TextSelection.fromPosition(TextPosition(
              affinity: TextAffinity.downstream,
              offset: num.toString().length)));
      widget.numChangeAction?.call(num);
      widget.num = num;
    });
  }

  /// 减
  delete() {
    setState(() {
      int num = widget.num ?? 1;
      bool isSupportZero = widget.isSupportZero ?? false;
      if (num > 1 || (num == 1 && isSupportZero)) {
        num--;
        textFiledController.value = TextEditingValue(
            text: num.toString(),
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: num.toString().length)));
        widget.numChangeAction?.call(num);
        widget.num = num;
      }
    });
  }

  /// 更新输入框
  updateText(String value) {
    if (value.isNotEmpty) {
      bool isSupportZero = widget.isSupportZero ?? false;
      int num = widget.num ?? 1;
      if (SCUtils().isPositiveNumber(value) || isSupportZero) {
        num = int.parse(value);
        widget.numChangeAction?.call(num);
      }
      widget.num = num;
    }
  }

  /// 编辑完成
  editCompleteAction(String value) {
    if (value.isEmpty) {
      int num = widget.num ?? 1;
      num = 1;
      textFiledController.text = '$num';
      textFiledController.value = TextEditingValue(
          text: num.toString(),
          selection: TextSelection.fromPosition(TextPosition(
              affinity: TextAffinity.downstream,
              offset: num.toString().length)));
      widget.numChangeAction?.call(num);
      widget.num = num;
    }
  }
}
