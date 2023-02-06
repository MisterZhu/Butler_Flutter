

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../../Constants/sc_asset.dart';

/// 物资搜索view

class SCMaterialSearchView extends StatefulWidget {

  @override
  SCMaterialSearchViewState createState() => SCMaterialSearchViewState();
}

class SCMaterialSearchViewState extends State<SCMaterialSearchView> {

  final TextEditingController controller = TextEditingController();

  /// focusNode
  final FocusNode node = FocusNode();

  @override
  Widget build(BuildContext context) {
    showKeyboard(context);
    return body();
  }

  /// 弹出键盘
  showKeyboard(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100),(){
      node.requestFocus();
    });
  }

  /// body
  Widget body() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerItem(),
          Expanded(child: listView())
        ]
    );
  }

  /// 搜索
  Widget headerItem() {
    return Container(
      color: SCColors.color_FFFFFF,
      height: 44.0,
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: searchItem()),
          cancelBtn(),
        ],
      ),
    );
  }

  Widget searchItem() {
    return Container(
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
          hintText: "搜索物资名称",
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
        onChanged: (value) {

        },
        onSubmitted: (value) {
          node.unfocus();
        },
    ));
  }

  /// 取消按钮
  Widget cancelBtn() {
    return CupertinoButton(
      minSize: 64.0,
      padding: EdgeInsets.zero,
      child: const Text(
        '取消',
        style: TextStyle(
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w400,
          color: SCColors.color_1B1D33),
        ),
        onPressed: () {
          node.unfocus();
        });
  }

  /// 结果列表
  Widget listView() {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10.0,);
        },
        itemCount: 4);
  }

  Widget getCell(int index) {
    return Container(color: SCColors.color_FFFFFF, height: 60,);
  }
}