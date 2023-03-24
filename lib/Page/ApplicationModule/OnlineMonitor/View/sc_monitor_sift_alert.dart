import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/OnlineMonitor/View/sc_select_listview.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/sc_alert_header_view.dart';
import '../../../../Constants/sc_asset.dart';
import '../../MaterialEntry/View/MaterialEntry/sc_material_search_item.dart';
import '../Controller/sc_monitor_sift_controller.dart';

/// 筛选弹窗

class SCMonitorSiftAlert extends StatefulWidget {
  SCMonitorSiftAlert({Key? key,
    required this.list,
    required this.selectIndex,
    this.closeTap,
    this.tapAction,
  }) : super(key: key);

  /// 关闭
  final Function? closeTap;

  /// 点击
  final Function(int index)? tapAction;

  /// 数据源
  final List list;

  /// 当前选中的index
  final int selectIndex;

  @override
  SCMonitorSiftAlertState createState() => SCMonitorSiftAlertState();
}

class SCMonitorSiftAlertState extends State<SCMonitorSiftAlert> {

  SCMonitorSiftController state = SCMonitorSiftController();

  final TextEditingController controller = TextEditingController();

  final FocusNode node = FocusNode();

  bool showCancel = false;

  /// 默认index
  int currentIndex = 0;

  /// 监听键盘
  late StreamSubscription<bool> keyboardSubscription;

  /// 是否显示键盘
  bool keyboardVisible = false;

  @override
  initState() {
    super.initState();
    currentIndex = widget.selectIndex;
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
          setState(() {
            keyboardVisible = visible;
          });
        });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double listViewHeight = widget.list.length > 10 ? 44.0 * 10 : 44.0 * widget.list.length;
    double height = 48.0 + 44.0 + listViewHeight + 12.0 + MediaQuery.of(context).padding.bottom;
    return Container(
      width: double.infinity,
      height: keyboardVisible ? (MediaQuery.of(context).size.height - 250.0) : height,
      decoration: const BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          titleItem(context),
          headerItem(),
          SCSelectListView(
            list: widget.list,
            selectIndex: widget.selectIndex,
            tapAction: (index) {
              widget.tapAction?.call(index);
          },),
          Container(
            color: SCColors.color_FFFFFF,
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }


  /// 搜索
  Widget headerItem() {
    return Container(
      color: SCColors.color_FFFFFF,
      height: 44.0,
      padding: EdgeInsets.only(left: 16.0, right: showCancel ? 0 : 16.0),
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

  /// 搜索框
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
            hintText: '搜索空间名称',
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
            state.updateSearchString(value);
            state.searchData(isMore: false);
            node.unfocus();
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

  /// 取消按钮
  Widget cancelBtn() {
    return Offstage(
      offstage: !showCancel,
      child: CupertinoButton(
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
            setState(() {
              showCancel = false;
            });
          }),
    );
  }

  /// title
  Widget titleItem(BuildContext context) {
    return SCAlertHeaderView(
      title: '筛选',
      closeTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}