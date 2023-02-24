
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Constants/sc_asset.dart';

/// 选择item

class SCMaterialSelectItem extends StatefulWidget {

  /// 是否必填
  bool isRequired;

  /// 标题
  final String title;

  /// 内容
  final String? content;

  /// 是否是输入内容
  final bool? isInput;

  /// 选择类型
  final Function? selectAction;

  /// 是否不可用
  final bool? disable;

  /// 输入内容
  final Function(String value)? inputNameAction;

  SCMaterialSelectItem({Key? key,
    required this.isRequired,
    required this.title,
    this.isInput = false,
    this.content,
    this.selectAction,
    this.inputNameAction,
    this.disable
  }) : super(key: key);


  @override
  SCMaterialSelectItemState createState() => SCMaterialSelectItemState();
}

class SCMaterialSelectItemState extends State<SCMaterialSelectItem> {

  TextEditingController controller = TextEditingController();
  FocusNode node = FocusNode();

  initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    Color textColor;
    String subContent = widget.content ?? '';
    bool subDisable = widget.disable ?? false;
    if (subContent.isEmpty) {
      textColor = SCColors.color_B0B1B8;
    } else {
      if (subDisable) {
        textColor = SCColors.color_B0B1B8;
      } else {
        textColor = SCColors.color_1B1D33;
      }
    }
    return GestureDetector(
      onTap: () {
        if (!subDisable) {
          widget.selectAction?.call();
        }
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 48.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 12.0,
              alignment: Alignment.centerRight,
              child: Text(
                '*',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: SCFonts.f16,
                    fontWeight: FontWeight.w400,
                    color: widget.isRequired ? SCColors.color_FF4040 : Colors.transparent)),),
            SizedBox(
              width: 100.0,
              child: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: SCFonts.f16,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_1B1D33)),
            ),
            const SizedBox(width: 12.0,),
            Expanded(child: contentItem(textColor)),
            const SizedBox(width: 12.0,),
            Image.asset(
              SCAsset.iconMineSettingArrow,
              width: 16.0,
              height: 16.0,
            ),
            const SizedBox(width: 12.0,),
          ],
        ),
      ),
    );
  }

  Widget contentItem(Color textColor) {
    if (widget.isInput == true) {
      return inputItem();
    } else {
      return Text(
          widget.content != '' ? widget.content! : '请选择',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w400,
              color: textColor));
    }
  }

  Widget inputItem() {
    return TextField(
      controller: controller,
      maxLines: null,
      style: const TextStyle(fontSize: SCFonts.f16, fontWeight:  FontWeight.w400, color: SCColors.color_1B1D33),
      cursorColor: SCColors.color_1B1C33,
      cursorWidth: 2,
      focusNode: node,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: "请填写",
        hintStyle: TextStyle(fontSize: 16, color: SCColors.color_B0B1B8),
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
        widget.inputNameAction?.call(value);

      },
      keyboardType: TextInputType.text,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.done,
    );
  }

}