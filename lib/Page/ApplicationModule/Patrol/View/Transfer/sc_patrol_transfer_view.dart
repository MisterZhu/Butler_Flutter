import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import '../../../../../Constants/sc_default_value.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../MaterialEntry/Model/sc_selectcategory_model.dart';
import '../../../MaterialEntry/Model/sc_selectcategory_tree_model.dart';
import '../../../MaterialEntry/View/SelectCategoryAlert/sc_add_material_selectcategory_alert.dart';
import '../../../MaterialOutbound/Controller/sc_select_department_controller.dart';
import '../../../MaterialOutbound/Model/sc_receiver_model.dart';
import '../../Controller/sc_patrol_transfer_controller.dart';

/// 转派view

class SCPatrolTransferView extends StatefulWidget {
  /// SCPatrolTransferController
  final SCPatrolTransferController controller;

  /// SCSelectDepartmentController
  final SCSelectDepartmentController selectDepartmentController;

  const SCPatrolTransferView(
      {Key? key,
      required this.controller,
      required this.selectDepartmentController})
      : super(key: key);

  @override
  SCPatrolTransferViewState createState() => SCPatrolTransferViewState();
}

class SCPatrolTransferViewState extends State<SCPatrolTransferView> {
  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return cell1();
          } else {
            return cell2();
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10.0,
          );
        },
        itemCount: 2);
  }

  /// cell1
  Widget cell1() {
    SCUIDetailCellModel model = SCUIDetailCellModel.fromJson({
      "type": 7,
      "title": '选择部门',
      "subTitle": '',
      "content": widget.controller.department,
      "subContent": '',
      "rightIcon": SCAsset.iconArrowRight
    });
    return SCDetailCell(
      list: [model],
      detailAction: (int index) {
        selectCompany();
      },
    );
  }

  /// cell2
  Widget cell2() {
    SCUIDetailCellModel model = SCUIDetailCellModel.fromJson({
      "type": 7,
      "title": '选择人员',
      "subTitle": '',
      "content": widget.controller.user,
      "subContent": '',
      "rightIcon": SCAsset.iconArrowRight
    });
    return SCDetailCell(
      list: [model],
      detailAction: (int index) {
        selectUser();
      },
    );
  }

  /// 选择部门
  selectCompany() {
    widget.selectDepartmentController.loadDataList(
        completeHandler: (success, list) {
      widget.selectDepartmentController.initHeaderData();
      widget.selectDepartmentController.footerList = list;
      if (success) {
        SCDialogUtils().showCustomBottomDialog(
            context: context,
            isDismissible: true,
            widget: GetBuilder<SCSelectDepartmentController>(
                tag: widget.selectDepartmentController.tag,
                init: widget.selectDepartmentController,
                builder: (value) {
                  return SCSelectCategoryAlert(
                    title: '选择部门',
                    headerList: widget.selectDepartmentController.headerList,
                    footerList: widget.selectDepartmentController.footerList,
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

  /// 点击header
  headerAction(int index, SCSelectCategoryModel model) {
    if (index == 0) {
      widget.selectDepartmentController.initHeaderData();
      widget.selectDepartmentController.childrenList =
          widget.selectDepartmentController.treeList;
      List<SCSelectCategoryModel> list = [];
      for (SCSelectCategoryTreeModel subModel
          in widget.selectDepartmentController.treeList) {
        String orgName = subModel.orgName ?? '';
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
      widget.selectDepartmentController.footerList = list;
      widget.selectDepartmentController.update();
    } else {
      SCSelectCategoryModel subModel =
          widget.selectDepartmentController.headerList[index - 1];
      List list = subModel.childList ?? [];
      List<SCSelectCategoryModel> newList = [];
      for (SCSelectCategoryTreeModel childModel in list) {
        String orgName = childModel.orgName ?? '';
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

      widget.selectDepartmentController.childrenList = newTreeList;
      widget.selectDepartmentController.footerList = newList;
      widget.selectDepartmentController.headerList =
          widget.selectDepartmentController.headerList.sublist(0, index);
      SCSelectCategoryModel model = SCSelectCategoryModel.fromJson(
          {"enable": false, "title": "请选择", "id": ""});
      widget.selectDepartmentController.headerList.add(model);
      widget.selectDepartmentController.update();
    }
  }

  /// 点击footer
  footerAction(int index, SCSelectCategoryModel model) {
    SCSelectCategoryTreeModel treeModel =
        widget.selectDepartmentController.childrenList[index];
    List<SCSelectCategoryTreeModel> childrenList = treeModel.children ?? [];
    List<SCSelectCategoryModel> subList = [];

    for (SCSelectCategoryTreeModel subChildrenModel in childrenList) {
      String orgName = subChildrenModel.orgName ?? '';
      String subId = subChildrenModel.id ?? '';
      var subParams = {
        "enable": true,
        "title": orgName,
        "id": subId,
        "parentList": widget.selectDepartmentController.childrenList,
        "childList": subChildrenModel.children
      };

      SCSelectCategoryModel selectCategoryModel =
          SCSelectCategoryModel.fromJson(subParams);
      subList.add(selectCategoryModel);
    }

    model.parentList = widget.selectDepartmentController.childrenList;
    widget.selectDepartmentController.childrenList = childrenList;
    widget.selectDepartmentController.updateHeaderData(model);
    widget.selectDepartmentController.updateFooterData(subList);
  }

  /// 确定选择报损部门
  sureSelectDepartment() {
    widget.controller.updateDepartmentInfo(widget.selectDepartmentController.currentDepartmentModel);
  }

  /// 选择人
  selectUser() async {
    if (widget.controller.departmentId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectPatrolDepartment);
    } else {
      /// 转派人
      SCReceiverModel receiverModel = SCReceiverModel.fromJson({
        "personId": widget.controller.userId,
        "personName": widget.controller.user
      });
      var params = {
        'receiverModel': receiverModel,
        'orgId': widget.controller.departmentId,
        'title': '选择转派人员',
      };
      var backParams = await SCRouterHelper.pathPage(
          SCRouterPath.selectReceiverPage, params);
      if (backParams != null) {
        widget.controller.updateUserInfo(backParams['receiverModel']);
      }
    }
  }
}
