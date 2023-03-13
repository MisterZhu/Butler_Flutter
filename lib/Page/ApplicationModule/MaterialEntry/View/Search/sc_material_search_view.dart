import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/sc_bottom_button_item.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Constants/sc_default_value.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../PropertyFrmLoss/Model/sc_property_list_model.dart';
import '../../Controller/sc_material_search_controller.dart';
import '../../Model/sc_material_list_model.dart';
import '../Detail/sc_material_cell.dart';

/// 物资搜索view

class SCMaterialSearchView extends StatefulWidget {
  /// SCMaterialSearchController
  final SCMaterialSearchController state;

  final bool? isProperty;

  SCMaterialSearchView({Key? key, required this.state, this.isProperty}) : super(key: key);

  @override
  SCMaterialSearchViewState createState() => SCMaterialSearchViewState();
}

class SCMaterialSearchViewState extends State<SCMaterialSearchView> {
  final TextEditingController controller = TextEditingController();

  final FocusNode node = FocusNode();

  bool showCancel = true;

  /// RefreshController
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    super.initState();
    showKeyboard(context);
  }

  @override
  void dispose() {
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
    Future.delayed(const Duration(milliseconds: 100), () {
      node.requestFocus();
    });
  }

  /// body
  Widget body() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [headerItem(), Expanded(child: contentView()), bottomView()]);
  }

  /// 底部按钮
  Widget bottomView() {
    return SCBottomButtonItem(
      list: const ['确定'],
      buttonType: 0,
      tapAction: () {
        sureAction();
      },
    );
  }

  /// 确定
  sureAction() {
    if (widget.isProperty == true) {
      List<SCPropertyListModel> list = [];
      for (SCPropertyListModel model in widget.state.propertyList) {
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
    } else {
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
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
        hintText: widget.isProperty == true? '搜索资产名称' : "搜索物资名称",
        hintStyle: const TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: SCColors.color_B0B1B8),
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
      onChanged: (value) {},
      onSubmitted: (value) {
        widget.state.updateSearchString(value);
        if (widget.state.isProperty == true) {
          widget.state.searchPropertyData();
        } else {
          widget.state.searchData();
        }
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
    if (widget.isProperty == true) {
      if (widget.state.propertyList.isNotEmpty) {
        return listview();
      } else {
        return emptyItem();
      }
    } else {
      if (widget.state.materialList.isNotEmpty) {
        return listview();
      } else {
        return emptyItem();
      }
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
        onRefresh: onRefresh,
        onLoading: loadMore,
        child: ListView.separated(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 11.0),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              if (widget.isProperty == true) {
                SCPropertyListModel model = widget.state.propertyList[index];
                return propertyCell(model);
              } else {
                SCMaterialListModel model = widget.state.materialList[index];
                return cell(model);
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10.0,
              );
            },
            itemCount: widget.isProperty == true ? widget.state.propertyList.length : widget.state.materialList.length));
  }

  Widget cell(SCMaterialListModel model) {
    return SCMaterialCell(
      hideMaterialNumTextField: widget.state.hideNumTextField,
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

  Widget propertyCell(SCPropertyListModel model) {
    return SCMaterialCell(
      hideMaterialNumTextField: widget.state.hideNumTextField,
      propertyModel: model,
      type: scPropertyCellTypeRadio,
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
      child: Text(widget.state.tips,
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
    if (widget.isProperty == true) {
      widget.state.searchPropertyData(isMore: false,
          completeHandler: (bool success, bool last) {
            refreshController.refreshCompleted();
            refreshController.loadComplete();
          });
    } else {
      widget.state.searchData(
          isMore: false,
          completeHandler: (bool success, bool last) {
            refreshController.refreshCompleted();
            refreshController.loadComplete();
          });
    }
  }

  /// 上拉加载
  void loadMore() async {
    if (widget.isProperty == true) {

    } else {
      widget.state.searchData(
          isMore: true,
          completeHandler: (bool success, bool last) {
            if (last) {
              refreshController.loadNoData();
            } else {
              refreshController.loadComplete();
            }
          });
      }
    }

}
