import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/constants/sc_asset.dart';

/// 搜索框

class SCChangeSpaceAlertSearchBar extends StatefulWidget {
  const SCChangeSpaceAlertSearchBar({
    Key? key,
    this.onValueChanged,
  }) : super(key: key);

  final Function(String value)? onValueChanged;

  @override
  SCChangeSpaceAlertSearchBarState createState() =>
      SCChangeSpaceAlertSearchBarState();
}

class SCChangeSpaceAlertSearchBarState
    extends State<SCChangeSpaceAlertSearchBar> {
  TextEditingController searchController = TextEditingController();

  FocusNode searchNode = FocusNode();

  /// 是否正在搜索
  bool isSearching = false;

  /// 是否显示clear
  bool isShowClear = false;

  /// placeholder
  String placeholder = '请输入空间名称';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
      child: Row(
        children: [
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            height: 36.0,
            decoration: BoxDecoration(
                color: SCColors.color_F9F9F9,
                borderRadius: BorderRadius.circular(18.0)),
            child: Row(
              children: [prefixIcon(), textField(), clearIcon()],
            ),
          )),
          Visibility(visible: isSearching, child: cancelBtn())
        ],
      ),
    );
  }

  /// 搜索icon
  Widget prefixIcon() {
    return CupertinoButton(
        minSize: 30.0,
        padding: const EdgeInsets.only(left: 16.0, right: 8.0),
        child: Image.asset(
          SCAsset.iconGreySearch,
          width: 16.0,
          height: 16.0,
        ),
        onPressed: () {
          searchNode.unfocus();
        });
  }

  /// 输入框
  Widget textField() {
    return Expanded(
        child: TextField(
      controller: searchController,
      maxLines: 1,
      cursorColor: SCColors.color_1B1C33,
      cursorWidth: 2,
      focusNode: searchNode,
      style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_1B1C33),
      keyboardType: TextInputType.text,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
        hintText: placeholder,
        hintStyle: const TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: SCColors.color_8D8E99),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        border: const OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        isCollapsed: true,
      ),
      onChanged: (value) {
        bool isShow = false;
        if (value.isNotEmpty) {
          isShow = true;
        } else {
          isShow = false;
        }
        setState(() {
          isShowClear = isShow;
        });
        widget.onValueChanged?.call(value);
      },
      onSubmitted: (value) {
        searchNode.unfocus();
      },
      onTap: () {
        if (!isSearching) {
          setState(() {
            isSearching = true;
            isShowClear = searchController.text.isNotEmpty;
          });
        }
      },
    ));
  }

  /// clear按钮
  Widget clearIcon() {
    return Visibility(
        visible: isShowClear,
        child: CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            minSize: 30.0,
            child: Image.asset(
              SCAsset.iconSearchClear,
              width: 18.0,
              height: 18.0,
            ),
            onPressed: () {
              searchController.clear();
              widget.onValueChanged?.call('');
              setState(() {
                isShowClear = false;
              });
            }));
  }

  /// 输入框取消按钮
  Widget cancelBtn() {
    return CupertinoButton(
        minSize: 30.0,
        padding: const EdgeInsets.only(left: 16.0, right: 0.0),
        child: const Text(
          '取消',
          style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_1B1D33),
        ),
        onPressed: () {
          setState(() {
            searchNode.unfocus();
            isSearching = false;
            isShowClear = false;
          });
        });
  }

  @override
  dispose() {
    super.dispose();
    searchController.dispose();
    searchNode.dispose();
  }
}
