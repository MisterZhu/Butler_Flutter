
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 标题+输入框 cell
class SCDeliverExplainCell extends StatefulWidget {

  /// 标题
  final String title;

  /// 输入框的内容
  final String? content;

  final double inputHeight;
  /// 输入内容
  final Function(String content)? inputAction;

  SCDeliverExplainCell({ Key? key, required this.title, this.content, this.inputHeight = 86.0, this.inputAction}) : super(key: key);

  @override
  SCDeliverExplainCellState createState() => SCDeliverExplainCellState();
}

class SCDeliverExplainCellState extends State<SCDeliverExplainCell> {

  TextEditingController controller = TextEditingController();
  FocusNode node = FocusNode();

  @override
  initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    if (widget.content != null) {
      controller.value = controller.value.copyWith(
        text: widget.content,
        selection: TextSelection(baseOffset: widget.content?.length ?? 0, extentOffset: widget.content?.length ?? 0),
        composing: TextRange.empty,
      );
    }
    return body();
  }

  /// body
  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        titleItem(),
        const SizedBox(height: 12.0,),
        inputItem(),
      ],
    );
  }

  /// title
  Widget titleItem() {
    return Text(
        widget.title,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: SCFonts.f16,
          color: SCColors.color_1B1D33,
          fontWeight: FontWeight.w500,
        ),
    );
  }

  /// inputItem
  Widget inputItem() {
    return Container(
      width: double.infinity,
      height: widget.inputHeight,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: SCColors.color_F7F8FA, borderRadius: BorderRadius.circular(4.0)),
      child: textField(),
    );
  }

  /// textField
  Widget textField() {
    return TextField(
      controller: controller,
      maxLines: null,
      style: const TextStyle(fontSize: SCFonts.f14, fontWeight:  FontWeight.w400, color: SCColors.color_1B1D33),
      cursorColor: SCColors.color_1B1C33,
      cursorWidth: 2,
      focusNode: node,
      inputFormatters: [
        LengthLimitingTextInputFormatter(200),
      ],
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: "请输入内容",
        hintStyle: TextStyle(fontSize: 14, color: SCColors.color_B0B1B8),
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
        widget.inputAction?.call(value);
      },
      keyboardType: TextInputType.text,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.done,
    );
  }

}