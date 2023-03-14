import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../../Constants/sc_asset.dart';

/// 搜索框

class SCSearchView extends StatefulWidget {

  const SCSearchView({Key? key, this.searchAction}) : super(key: key);

  /// 搜索
  final Function(String text)? searchAction;

  @override
  SCSearchViewState createState() => SCSearchViewState();
}

class SCSearchViewState extends State<SCSearchView> {

  final TextEditingController controller = TextEditingController();

  final FocusNode node = FocusNode();

  bool showCancel = true;

  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      node.requestFocus();
    });
  }

  @override
  dispose() {
    controller.dispose();
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
      child: Row(
        children: [
          Expanded(child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            height: 30.0,
            decoration: BoxDecoration(
                color: SCColors.color_F2F3F5,
                borderRadius: BorderRadius.circular(15.0)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  SCAsset.iconGreySearch,
                  width: 16.0,
                  height: 16.0,
                ),
                const SizedBox(
                  width: 8.0,
                ),
                textField(),
              ],
            ),
          )),
          cancelItem()
        ],
      ),
    );
  }

  /// 取消
  Widget cancelItem() {
    return Offstage(
      offstage: !showCancel,
      child: GestureDetector(
        child: SizedBox(
          width: 44.0,
          child: Row(
            children: const [
              Expanded(child: SizedBox()),
              Text('取消', style: TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_1B1C35
              ),)
            ],
          ),
        ),
        onTap: () {
          setState(() {
            node.unfocus();
            showCancel = false;
          });
        },
      ),
    );
  }

  /// 输入框
  Widget textField() {
    return Expanded(
        child: TextField(
          controller: controller,
          maxLines: 1,
          cursorColor: SCColors.color_1B1C33,
          cursorWidth: 2,
          focusNode: node,
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_1B1C33),
          keyboardType: TextInputType.text,
          keyboardAppearance: Brightness.light,
          textInputAction: TextInputAction.search,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 4),
            hintText: "搜索采购需求单号",
            hintStyle: TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w400,
                color: SCColors.color_B0B1B8),
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
          onChanged: (value) {},
          onSubmitted: (value) {
            node.unfocus();
            widget.searchAction?.call(value);
          },
          onTap: () {
            if (!showCancel) {
              setState(() {
                showCancel = true;
              });
            }
          },
        ));
  }
}