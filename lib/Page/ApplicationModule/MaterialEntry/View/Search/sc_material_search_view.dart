
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Constants/sc_default_value.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../Controller/sc_material_search_controller.dart';
import '../../Model/sc_material_list_model.dart';
import '../Detail/sc_material_bottom_view.dart';
import '../Detail/sc_material_cell.dart';

/// 物资搜索view

class SCMaterialSearchView extends StatefulWidget {

  /// SCMaterialSearchController
  final SCMaterialSearchController state;

  SCMaterialSearchView({Key? key, required this.state}) : super(key: key);

  @override
  SCMaterialSearchViewState createState() => SCMaterialSearchViewState();
}

class SCMaterialSearchViewState extends State<SCMaterialSearchView> {

  final TextEditingController controller = TextEditingController();

  final FocusNode node = FocusNode();

  bool showCancel = true;

  /// RefreshController
  RefreshController refreshController = RefreshController(initialRefresh: false);

  late StreamSubscription<bool> keyboardSubscription;

  /// 是否弹起键盘
  //bool isShowKeyboard = true;

  @override
  void initState() {
    super.initState();
    showKeyboard(context);
    // var keyboardVisibilityController = KeyboardVisibilityController();
    // isShowKeyboard = keyboardVisibilityController.isVisible;
    // keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
    //   setState(() {
    //     isShowKeyboard = visible;
    //   });
    // });
  }

  @override
  void dispose() {
    //keyboardSubscription.cancel();
    controller.dispose();
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          Expanded(child: contentView()),
          bottomView()
        ]
    );
  }

  /// 底部按钮
  Widget bottomView() {
    return Container(
        width: double.infinity,
        height: 54.0 + SCUtils().getBottomSafeArea(),
        color: SCColors.color_FFFFFF,
        padding: EdgeInsets.only(
            left: 16.0,
            top: 7.0,
            right: 16.0,
            bottom: SCUtils().getBottomSafeArea() + 7.0),
        decoration: BoxDecoration(
            color: SCColors.color_4285F4,
            borderRadius: BorderRadius.circular(4.0)),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text(
            '确定',
            style: const TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w400,
              color: SCColors.color_FFFFFF,),
          ),
          onPressed: () {
            sureAction();
          },
        )
    );
  }

  /// 确定
  sureAction() {
    List<SCMaterialListModel> list = [];
    for (SCMaterialListModel model in widget.state.materialList) {
      bool isSelect = model.isSelect ?? false;
      if (isSelect) {
        list.add(model);
      }
    }
    if (list.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectMaterialTip);
    } else {
      SCRouterHelper.back({'list': list});
    }
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
          widget.state.updateSearchString(value);
          widget.state.searchData();
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

  /// contentView
  Widget contentView() {
    if (widget.state.materialList.isNotEmpty) {
      return listview();
    } else {
      return emptyItem();
    }
  }

  /// listview
  Widget listview() {
    return SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: true,
        header: const SCCustomHeader(
        style: SCCustomHeaderStyle.noNavigation,
    ),
    onRefresh: onRefresh, onLoading: loadMore, child: ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 11.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          SCMaterialListModel model = widget.state.materialList[index];
          return cell(model);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10.0,);
        },
        itemCount: widget.state.materialList.length));
  }

  Widget cell(SCMaterialListModel model) {
    return SCMaterialCell(
      model: model,
      type: scMaterialCellTypeRadio,
      numChangeAction: (int value) {
        model.localNum = value;
      },
      radioTap: (bool value) {
        setState(() {
          model.isSelect = value;
        });
      },
    );
  }

  /// 无搜索结果
  Widget emptyItem() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 104.0),
      child: Text(
          widget.state.tips,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_8D8E99)),
    );
  }

  /// 下拉刷新
  Future onRefresh() async {
    widget.state.searchData(isMore: false, completeHandler: (bool success, bool last){
      refreshController.refreshCompleted();
      refreshController.loadComplete();
    });
  }

  /// 上拉加载
  void loadMore() async{
    widget.state.searchData(isMore: true, completeHandler: (bool success, bool last){
      if (last) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    });
  }
}