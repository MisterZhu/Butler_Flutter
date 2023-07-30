import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../Utils/sc_utils.dart';

/// 标题+输入框 cell
class InputItemCell extends StatefulWidget {
  /// 标题
  final String title;

  /// errorTitle
  final String errorTitle;

  /// 输入框的内容
  String? content;

  /// 输入框高度
  double inputHeight;

  /// 输入内容
  final Function(String content)? inputAction;

  /// 是否必填
  final bool? isRequired;

  InputItemCell(
      {Key? key,
        required this.title,
        this.content,
        this.inputHeight = 86.0,
        this.inputAction,
        this.errorTitle = '请输入',
        this.isRequired})
      : super(key: key);

  @override
  InputItemCellState createState() => InputItemCellState();
}

class InputItemCellState extends State<InputItemCell> {
  TextEditingController controller = TextEditingController();
  FocusNode node = FocusNode();

  /// isValueNotEmpty
  bool isValueNotEmpty = true;

  /// 字数
  int count = 0;

  @override
  initState() {
    super.initState();
    if (widget.content != null) {
      count = widget.content?.length ?? 0;
      controller.value = TextEditingValue(
          text: widget.content ?? '',
          selection: TextSelection.fromPosition(TextPosition(
              affinity: TextAffinity.downstream,
              offset: widget.content?.length ?? 0)));
    }
  }

  @override
  void didUpdateWidget(InputItemCell oldWidget) {
    if (widget.content != null) {
      count = widget.content?.length ?? 0;
      controller.value = TextEditingValue(
          text: widget.content ?? '',
          selection: TextSelection.fromPosition(TextPosition(
              affinity: TextAffinity.downstream,
              offset: widget.content?.length ?? 0)));
    }
    if(widget.content?.isEmpty ?? true){
      widget.inputHeight = 60.0;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  dispose() {
    controller.dispose();
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        titleItem(),
        const SizedBox(
          width: 12.0,
        ),
        inputItem(),
      ],
    );
  }

  /// *
  Widget requiredItem() {
    return Container(
      width: 12.0,
      alignment: Alignment.centerRight,
      child: const Text('*',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.right,
          style: TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w400,
              color: SCColors.color_FF4040)),
    );
  }

  /// title
  Widget titleItem() {
    bool showRequired = widget.isRequired ?? false;
    Widget textItem = Text(
      widget.title,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: SCFonts.f16,
        color: SCColors.color_1B1D33,
        fontWeight: FontWeight.w400,
      ),
    );
    if (showRequired) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [requiredItem(), textItem],
      );
    } else {
      return textItem;
    }
  }

  /// inputItem
  Widget inputItem() {
    bool showRequired = widget.isRequired ?? false;
    Widget item = Container(
        width: 210.0,
        height: isValueNotEmpty ? widget.inputHeight : 60.0,
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
        decoration: BoxDecoration(
            color: SCColors.color_F7F8FA,
            borderRadius: BorderRadius.circular(4.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: textField()),
            // countItem(),
          ],
        ));
    if (showRequired) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: item,
      );
    } else {
      return Expanded(child: item);
    }
  }

  /// textField
  Widget textField() {
    return TextFormField(
      controller: controller,
      maxLines: null,
      style: const TextStyle(
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w400,
          color: SCColors.color_1B1D33),
      cursorColor: SCColors.color_1B1C33,
      cursorWidth: 2,
      focusNode: node,
      inputFormatters: [
        LengthLimitingTextInputFormatter(200),
      ],
      decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: "请输入",
          hintStyle:
          const TextStyle(fontSize: 16, color: SCColors.color_B0B1B8),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.transparent)),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.transparent)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.transparent)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.transparent)),
          isCollapsed: true,
          errorText: isValueNotEmpty ? null : widget.errorTitle,
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.transparent)),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.transparent)),
          errorStyle: const TextStyle(fontSize: SCFonts.f12)),
      onChanged: (value) {
        widget.inputAction?.call(value);
        count = value.length;
        setState(() {
          isValueNotEmpty = value.isNotEmpty;
          if(isValueNotEmpty){
            setState(() {
              widget.inputHeight = 30.0;
            });
          }
        });
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: ((value) {
        if (value?.isEmpty ?? true) {
          return widget.errorTitle;
        }
        return null;
      }),
      keyboardType: TextInputType.text,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.done,
    );
  }

  /// 字数
  Widget countItem() {
    return Text(
      '$count/200',
      textAlign: TextAlign.right,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: SCFonts.f12,
        color: SCColors.color_8D8E99,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
