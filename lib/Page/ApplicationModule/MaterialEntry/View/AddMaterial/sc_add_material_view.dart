import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_list_model.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../Controller/sc_add_material_controller.dart';
import '../../Controller/sc_categoryalert_controlller.dart';
import '../../Model/sc_selectcategory_model.dart';
import '../../Model/sc_selectcategory_tree_model.dart';
import '../MaterialEntry/sc_material_search_item.dart';
import '../MaterialEntry/sc_material_sift_item.dart';
import '../SelectCategoryAlert/sc_add_material_selectcategory_alert.dart';
import 'sc_add_material_listview.dart';

/// 添加物资view

class SCAddMaterialView extends StatefulWidget {
  SCAddMaterialView(
      {Key? key,
      required this.state,
      required this.categoryAlertController,
      required this.refreshController,
      required this.type,
      this.sureAction})
      : super(key: key);

  /// SCAddMaterialController
  final SCAddMaterialController state;

  /// 确定
  final Function(List<SCMaterialListModel> list)? sureAction;

  /// SCCategoryAlertController
  final SCCategoryAlertController categoryAlertController;

  /// RefreshController
  final RefreshController refreshController;

  final SCWarehouseManageType type;

  @override
  SCAddMaterialViewState createState() => SCAddMaterialViewState();
}

class SCAddMaterialViewState extends State<SCAddMaterialView> {
  bool allSelected = false;

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SCMaterialSearchItem(
          name: '搜索物资名称',
          searchAction: () {
            searchAction();
          },
        ),
        SCMaterialSiftItem(
          tagList: const ['分类'],
          tapAction: (index) {
            showCategoryAlert();
          },
        ),
        Expanded(child: listview(context)),
        bottomItem(),
      ],
    );
  }

  /// listview
  Widget listview(BuildContext context) {
    return SCAddMaterialListView(
      state: widget.state,
      refreshController: widget.refreshController,
      list: widget.state.materialList,
      radioTap: () {
        setState(() {});
      },
      loadMoreAction: () {
        loadMore();
      },
    );
  }

  Widget getCell(int index) {
    return Container(
      color: SCColors.color_FFFFFF,
      height: 40,
    );
  }

  /// bottomItem
  Widget bottomItem() {
    return Container(
      width: double.infinity,
      height: 54.0 + SCUtils().getBottomSafeArea(),
      color: SCColors.color_FFFFFF,
      padding: EdgeInsets.only(
          left: 8.0,
          top: 7.0,
          right: 16.0,
          bottom: SCUtils().getBottomSafeArea() + 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                allSelected = !allSelected;
                for (SCMaterialListModel model in widget.state.materialList) {
                  model.isSelect = allSelected;
                }
                widget.state.update();
              });
            },
            child: Container(
              width: 38.0,
              height: 38.0,
              alignment: Alignment.center,
              child: Image.asset(
                  allSelected
                      ? SCAsset.iconMaterialSelected
                      : SCAsset.iconMaterialUnselect,
                  width: 22.0,
                  height: 22.0),
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('全选',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: SCFonts.f14,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_1B1D33)),
              Text('已选${getSelectedNumber()}项',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: SCFonts.f12,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_5E5F66))
            ],
          )),
          const SizedBox(
            width: 8.0,
          ),
          Container(
              width: 120.0,
              height: 40.0,
              decoration: BoxDecoration(
                  color: SCColors.color_4285F4,
                  borderRadius: BorderRadius.circular(4.0)),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text(
                  '确定',
                  style: TextStyle(
                    fontSize: SCFonts.f16,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_FFFFFF,
                  ),
                ),
                onPressed: () {
                  sureAction();
                },
              ))
        ],
      ),
    );
  }

  /// 分类弹窗
  showCategoryAlert() {
    widget.categoryAlertController.loadMaterialSortData(
        completeHandler: (success, list) {
      print("数据源:$list");
      widget.categoryAlertController.initHeaderData();
      widget.categoryAlertController.footerList = list;
      if (success) {
        SCDialogUtils().showCustomBottomDialog(
            context: context,
            isDismissible: true,
            widget: GetBuilder<SCCategoryAlertController>(
                tag: widget.categoryAlertController.tag,
                init: widget.categoryAlertController,
                builder: (value) {
                  return SCSelectCategoryAlert(
                    title: '选择分类',
                    headerList: widget.categoryAlertController.headerList,
                    footerList: widget.categoryAlertController.footerList,
                    headerTap: (int index, SCSelectCategoryModel model) {
                      headerAction(index, model);
                    },
                    footerTap: (int index, SCSelectCategoryModel model) {
                      footerAction(index, model);
                    },
                    onSure: () {
                      sureSelectDepartment();
                    },
                  );
                }));
      }
    });
  }

  /// 获取已选数量
  int getSelectedNumber() {
    int num = 0;
    for (SCMaterialListModel model in widget.state.materialList) {
      bool isSelect = model.isSelect ?? false;
      if (isSelect) {
        num += 1;
      }
    }
    return num;
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
      widget.sureAction?.call(list);
    }
  }

  /// 搜索
  searchAction() async {
    var backParams = await SCRouterHelper.pathPage(
        SCRouterPath.materialSearchPage,
        {'wareHouseId': widget.state.wareHouseId, 'type': widget.type});
    if (backParams != null) {
      if (backParams['list'] != null) {
        List<SCMaterialListModel> list = backParams['list'] ?? [];
        widget.state.dealSearchData(list);
      }
    }
  }

  /// 点击header
  headerAction(int index, SCSelectCategoryModel model) {
    if (index == 0) {
      widget.categoryAlertController.initHeaderData();
      widget.categoryAlertController.childrenList =
          widget.categoryAlertController.treeList;
      List<SCSelectCategoryModel> list = [];
      for (SCSelectCategoryTreeModel subModel
          in widget.categoryAlertController.treeList) {
        String orgName = subModel.name ?? '';
        String subId = subModel.id ?? '';
        var subParams = {
          "enable": true,
          "title": orgName,
          "id": subId,
          "parentList": [],
          "childList": subModel.children
        };
        SCSelectCategoryModel selectCategoryModel =
            SCSelectCategoryModel.fromJson(subParams);
        list.add(selectCategoryModel);
      }
      widget.categoryAlertController.footerList = list;
      widget.categoryAlertController.update();
    } else {
      SCSelectCategoryModel subModel =
          widget.categoryAlertController.headerList[index - 1];
      List list = subModel.childList ?? [];
      List<SCSelectCategoryModel> newList = [];
      for (SCSelectCategoryTreeModel childModel in list) {
        String orgName = childModel.name ?? '';
        String subId = childModel.id ?? '';
        var subParams = {
          "enable": true,
          "title": orgName,
          "id": subId,
          "parentList": [],
          "childList": childModel.children
        };
        SCSelectCategoryModel selectCategoryModel =
            SCSelectCategoryModel.fromJson(subParams);
        newList.add(selectCategoryModel);
      }

      List treeList = subModel.childList ?? [];
      List<SCSelectCategoryTreeModel> newTreeList = [];
      for (SCSelectCategoryTreeModel treeModel in treeList) {
        newTreeList.add(treeModel);
      }

      widget.categoryAlertController.childrenList = newTreeList;
      widget.categoryAlertController.footerList = newList;
      widget.categoryAlertController.headerList =
          widget.categoryAlertController.headerList.sublist(0, index);
      SCSelectCategoryModel model = SCSelectCategoryModel.fromJson(
          {"enable": false, "title": "请选择", "id": ""});
      widget.categoryAlertController.headerList.add(model);
      widget.categoryAlertController.update();
    }
  }

  /// 点击footer
  footerAction(int index, SCSelectCategoryModel model) {
    SCSelectCategoryTreeModel treeModel =
        widget.categoryAlertController.childrenList[index];
    List<SCSelectCategoryTreeModel> childrenList = treeModel.children ?? [];
    List<SCSelectCategoryModel> subList = [];

    for (SCSelectCategoryTreeModel subChildrenModel in childrenList) {
      String orgName = subChildrenModel.name ?? '';
      String subId = subChildrenModel.id ?? '';
      var subParams = {
        "enable": true,
        "title": orgName,
        "id": subId,
        "parentList": widget.categoryAlertController.childrenList,
        "childList": subChildrenModel.children
      };

      SCSelectCategoryModel selectCategoryModel =
          SCSelectCategoryModel.fromJson(subParams);
      subList.add(selectCategoryModel);
    }

    model.parentList = widget.categoryAlertController.childrenList;
    widget.categoryAlertController.childrenList = childrenList;
    widget.categoryAlertController.updateHeaderData(model);
    widget.categoryAlertController.updateFooterData(subList);
  }

  /// 确定选择领用部门
  sureSelectDepartment() {
    bool enable =
        widget.categoryAlertController.currentDepartmentModel.enable ?? false;
    if (enable) {
      if (widget.state.classifyId !=
          (widget.categoryAlertController.currentDepartmentModel.id ?? '')) {
        widget.state.classifyId =
            widget.categoryAlertController.currentDepartmentModel.id ?? '';
        widget.state.classifyName =
            widget.categoryAlertController.currentDepartmentModel.title ?? '';
        widget.state.loadMaterialListData(isMore: false);
      } else {
        widget.state.classifyId = '';
        widget.state.classifyName = '';
        widget.state.loadMaterialListData(isMore: false);
      }
    } else {
      // 未选择数据
      widget.state.classifyId = '';
      widget.state.classifyName = '';
      widget.state.loadMaterialListData(isMore: false);
    }
  }

  /// 加载更多
  loadMore() {
    widget.state.loadMaterialListData(
        isMore: true,
        completeHandler: (bool success, bool last) {
          if (last) {
            widget.refreshController.loadNoData();
          } else {
            widget.refreshController.loadComplete();
          }
        });
  }
}
