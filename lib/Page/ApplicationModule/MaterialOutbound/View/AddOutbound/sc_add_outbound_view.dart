import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_list_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/AddEntry/sc_basic_info_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/AddEntry/sc_material_info_cell.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../../WorkBench/Home/Model/sc_home_task_model.dart';
import '../../../../WorkBench/Home/View/Alert/sc_task_module_alert.dart';
import '../../../HouseInspect/View/sc_bottom_button_item.dart';
import '../../../MaterialEntry/Model/sc_entry_type_model.dart';
import '../../../MaterialEntry/Model/sc_selectcategory_model.dart';
import '../../../MaterialEntry/Model/sc_selectcategory_tree_model.dart';
import '../../../MaterialEntry/Model/sc_wareHouse_model.dart';
import '../../../MaterialEntry/View/SelectCategoryAlert/sc_add_material_selectcategory_alert.dart';
import '../../Controller/sc_add_outbound_controller.dart';
import '../../Controller/sc_select_department_controller.dart';
import '../../Model/sc_receiver_model.dart';

/// 新增出库view

class SCAddOutboundView extends StatefulWidget {
  /// SCAddOutboundController
  final SCAddOutboundController state;

  /// SCSelectDepartmentController
  final SCSelectDepartmentController selectDepartmentController;

  SCAddOutboundView(
      {Key? key, required this.state, required this.selectDepartmentController})
      : super(key: key);

  @override
  SCAddOutboundViewState createState() => SCAddOutboundViewState();
}

class SCAddOutboundViewState extends State<SCAddOutboundView> {
  /// 领用人
  SCReceiverModel receiverModel = SCReceiverModel();

  late StreamSubscription<bool> keyboardSubscription;

  /// 是否弹起键盘
  bool isShowKeyboard = false;

  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();
    isShowKeyboard = keyboardVisibilityController.isVisible;
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        isShowKeyboard = visible;
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
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: listview(context)),
        Offstage(
          offstage: isShowKeyboard,
          child: SCBottomButtonItem(
            list: bottomButtonList(),
            buttonType: widget.state.isEdit ? 0 : 1,
            leftTapAction: () {
              /// 保存
              save();
            },
            rightTapAction: () {
              /// 提交
              submit();
            },
            tapAction: () {
              /// 编辑
              editAction();
            },
          ),
        ),
      ],
    );
  }

  /// listview
  Widget listview(BuildContext context) {
    return ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox();
        },
        itemCount: 4);
  }

  Widget getCell(int index) {
    if (index == 0) {
      return SCBasicInfoCell(
        list: getBaseInfoList(),
        requiredRemark: true,
        requiredPhotos: widget.state.isEdit ? false : true,
        remark: widget.state.remark,
        files: widget.state.files,
        selectAction: (index, title) async {
          if (index == 0) {
            // 仓库名称
            List list = widget.state.wareHouseList.map((e) => e.name).toList();
            showAlert(0, '仓库名称', list);
          } else if (index == 1) {
            // 类型
            List list = widget.state.typeList.map((e) => e.name).toList();
            showAlert(1, '类型', list);
          } else if (index == 2) {
            // 领用部门
            showSelectDepartmentAlert();
          } else if (index == 3) {
            selectRecipient();
          }
        },
        inputAction: (content) {
          widget.state.remark = content;
        },
        updatePhoto: (list) {
          widget.state.files = list;
          widget.state.update();
        },
      );
    } else if (index == 1) {
      return SCMaterialInfoCell(
        title: '物资信息',
        showAdd: true,
        list: widget.state.selectedList,
        addAction: () {
          addAction();
        },
        deleteAction: (int subIndex) {
          deleteAction(subIndex);
        },
        updateNumAction: (int index, int value) {
          widget.state.update();
          editOneMaterial(index);
        },
      );
    } else {
      return const SizedBox(
        height: 10,
      );
    }
  }

  /// 弹出类型弹窗
  showAlert(int index, String title, List list) {
    List<SCHomeTaskModel> modelList = [];
    for (int i = 0; i < list.length; i++) {
      modelList.add(SCHomeTaskModel.fromJson(
          {"name": list[i], "id": "$i", "isSelect": false}));
    }
    int currentIndex = -1;
    if (index == 0) {
      // 仓库名称
      currentIndex = widget.state.nameIndex;
    } else if (index == 1) {
      // 类型
      currentIndex = widget.state.typeIndex;
    }
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCTaskModuleAlert(
            title: title,
            list: modelList,
            currentIndex: currentIndex,
            radius: 2.0,
            tagHeight: 32.0,
            columnCount: 3,
            mainSpacing: 8.0,
            crossSpacing: 8.0,
            topSpacing: 8.0,
            closeTap: (SCHomeTaskModel model, int selectIndex) {
              setState(() {
                if (index == 0) {
                  // 仓库名称
                  if (widget.state.nameIndex == selectIndex) {
                    /// 选择同一个仓库，不刷新页面
                  } else {
                    /// 选择不同的仓库，清空选中的物资，刷新页面
                    SCWareHouseModel subModel = widget.state.wareHouseList[selectIndex];
                    widget.state.nameIndex = selectIndex;
                    widget.state.wareHouseName = model.name ?? '';
                    widget.state.wareHouseId = subModel.id ?? '';
                    /// 清空选中的物资
                    widget.state.updateSelectedMaterial([]);
                  }
                } else if (index == 1) {
                  // 类型
                  SCEntryTypeModel subModel = widget.state.typeList[selectIndex];
                  widget.state.typeIndex = selectIndex;
                  widget.state.type = model.name ?? '';
                  widget.state.typeID = subModel.code ?? 0;
                }
              });
            },
          ));
    });
  }

  /// 获取基础信息
  List getBaseInfoList() {
    /// 基础信息数组
    List baseInfoList = [
      {'isRequired': true, 'title': '仓库名称', 'content': widget.state.wareHouseName, 'disable' : widget.state.isEdit},
      {'isRequired': true, 'title': '类型', 'content': widget.state.type, 'disable' : widget.state.isLL},
    ];

    List orgList = [
      {'isRequired': true, 'title': '领用部门', 'content': widget.state.fetchOrgName, 'disable' : widget.state.isEdit},
      {'isRequired': true, 'title': '领用人', 'content': widget.state.fetchUserName, 'disable' : widget.state.isEdit},
    ];
    if (widget.state.type == '领料出库' || widget.state.type == '维修领料' || widget.state.type == '资产领用出库') {
      baseInfoList.addAll(orgList);
    }
    return baseInfoList;
  }

  /// 添加物资
  addAction() async {
    if (widget.state.wareHouseId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectWarehouseTip);
      return;
    }
    if (widget.state.typeID <= 0) {
      SCToast.showTip(SCDefaultValue.selectWareHouseTypeTip);
      return;
    }

    if (widget.state.isEdit) {
      print("编辑-添加物资");
      addExitsMaterialAction();
    } else {
      print("添加物资");
      addMaterialAction();
    }
  }

  /// 新增物资-添加物资
  addMaterialAction() async{
    var list = await SCRouterHelper.pathPage(SCRouterPath.addMaterialPage, {
      'data': widget.state.selectedList,
      'wareHouseId': widget.state.wareHouseId,
      'outType': widget.state.typeID,
      "materialType" : SCWarehouseManageType.outbound,
      "isLL" : widget.state.isLL
    });
    if (list != null) {
      onlyAddMaterial(list);
    }
  }

  /// 编辑物资-添加既存物资
  addExitsMaterialAction() async{
    var list = await SCRouterHelper.pathPage(SCRouterPath.addMaterialPage, {
      'data': widget.state.selectedList,
      'wareHouseId': widget.state.wareHouseId,
      'outType': widget.state.typeID,
      'isEdit': true,
      "materialType" : SCWarehouseManageType.outbound
    });
    if (list != null) {
      editAddMaterial(list);
    }
  }

  /// 删除物资
  deleteAction(int index) {
    if (widget.state.isEdit) {
      SCMaterialListModel model = widget.state.selectedList[index];
      print("物资id===${model.id}");
      widget.state.deleteMaterial(index);
      widget.state.editDeleteMaterial(materialInRelationId: model.id ?? '');
    } else {
      widget.state.deleteMaterial(index);
    }
  }

  /// 暂存
  save() {
    checkMaterialData(0);
  }

  /// 提交
  submit() {
    checkMaterialData(1);
  }

  /// 检查物资数据
  checkMaterialData(int status) {
    if (widget.state.wareHouseId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectWareHouseNameTip);
      return;
    }

    if (widget.state.typeID <= 0) {
      SCToast.showTip(SCDefaultValue.selectWareHouseTypeTip);
      return;
    }

    if (widget.state.type == '领料出库' || widget.state.type == '维修领料' || widget.state.type == '资产领用出库') {
      if (widget.state.fetchOrgId.isEmpty) {
        SCToast.showTip(SCDefaultValue.selectDepartmentTip);
        return;
      }

      if (widget.state.fetchUserId.isEmpty) {
        SCToast.showTip(SCDefaultValue.selectUserTip);
        return;
      }
    }

    if (widget.state.selectedList.isEmpty) {
      SCToast.showTip(SCDefaultValue.addMaterialInfoTip);
      return;
    }

    List materialList = [];
    for (SCMaterialListModel model in widget.state.selectedList) {
      var params = model.toJson();
      params['num'] = model.localNum;
      materialList.add(params);
    }

    var params = {
      "files": widget.state.files,
      "wareHouseName" : widget.state.wareHouseName,
      "wareHouseId" : widget.state.wareHouseId,
      "typeName" : widget.state.type,
      "typeId" : widget.state.typeID,
      "remark" : widget.state.remark,
      "materialList" : materialList
    };
    widget.state.addOut(status: status, data: params);
  }

  /// 选择领用部门
  showSelectDepartmentAlert() {
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
      widget.selectDepartmentController.childrenList = widget.selectDepartmentController.treeList;
      List<SCSelectCategoryModel> list = [];
      for(SCSelectCategoryTreeModel subModel in widget.selectDepartmentController.treeList) {
        String orgName = subModel.orgName ?? '';
        String subId = subModel.id ?? '';
        var subParams = {
          "enable" : true,
          "title" : orgName,
          "id" : subId,
          "parentList" : [],
          "childList" :subModel.children
        };
        SCSelectCategoryModel selectCategoryModel = SCSelectCategoryModel.fromJson(subParams);
        list.add(selectCategoryModel);
      }
      widget.selectDepartmentController.footerList = list;
      widget.selectDepartmentController.update();
    } else {
      SCSelectCategoryModel subModel = widget.selectDepartmentController.headerList[index - 1];
      List list = subModel.childList ?? [];
      List<SCSelectCategoryModel> newList = [];
      for (SCSelectCategoryTreeModel childModel in list) {
        String orgName = childModel.orgName ?? '';
        String subId = childModel.id ?? '';
        var subParams = {
          "enable" : true,
          "title" : orgName,
          "id" : subId,
          "parentList" : [],
          "childList" :childModel.children
        };
        SCSelectCategoryModel selectCategoryModel = SCSelectCategoryModel.fromJson(subParams);
        newList.add(selectCategoryModel);
      }

      List treeList = subModel.childList ?? [];
      List<SCSelectCategoryTreeModel> newTreeList = [];
      for (SCSelectCategoryTreeModel treeModel in treeList) {
        newTreeList.add(treeModel);
      }

      widget.selectDepartmentController.childrenList = newTreeList;
      widget.selectDepartmentController.footerList = newList;
      widget.selectDepartmentController.headerList = widget.selectDepartmentController.headerList.sublist(0,index);
      SCSelectCategoryModel model = SCSelectCategoryModel.fromJson({"enable" : false, "title" : "请选择", "id" : ""});
      widget.selectDepartmentController.headerList.add(model);
      widget.selectDepartmentController.update();

    }
  }

  /// 点击footer
  footerAction(int index, SCSelectCategoryModel model) {
    SCSelectCategoryTreeModel treeModel = widget.selectDepartmentController.childrenList[index];
    List<SCSelectCategoryTreeModel> childrenList = treeModel.children ?? [];
    List<SCSelectCategoryModel> subList = [];

    for(SCSelectCategoryTreeModel subChildrenModel in childrenList) {
      String orgName = subChildrenModel.orgName ?? '';
      String subId = subChildrenModel.id ?? '';
      var subParams = {
        "enable" : true,
        "title" : orgName,
        "id" : subId,
        "parentList" : widget.selectDepartmentController.childrenList,
        "childList" :subChildrenModel.children
      };

      SCSelectCategoryModel selectCategoryModel = SCSelectCategoryModel.fromJson(subParams);
      subList.add(selectCategoryModel);
    }

    model.parentList = widget.selectDepartmentController.childrenList;
    widget.selectDepartmentController.childrenList = childrenList;
    widget.selectDepartmentController
        .updateHeaderData(model);
    widget.selectDepartmentController
        .updateFooterData(subList);
  }

  /// 确定选择领用部门
  sureSelectDepartment() {
    bool enable = widget.selectDepartmentController.currentDepartmentModel.enable ?? false;
    if (enable) {
      if (widget.state.fetchOrgId != (widget.selectDepartmentController.currentDepartmentModel.id ?? '')) {
        widget.state.fetchUserId = '';
        widget.state.fetchUserName = '';
        widget.state.fetchOrgId = widget.selectDepartmentController.currentDepartmentModel.id ?? '';
        widget.state.fetchOrgName = widget.selectDepartmentController.currentDepartmentModel.title ?? '';
        widget.state.update();
      }
    } else {// 未选择数据
    }
  }

  /// 选择领用人
  selectRecipient() async{
    if (widget.state.fetchOrgId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectDepartmentTip);
    } else {
      var params = {
        'receiverModel': receiverModel,
        'orgId': widget.state.fetchOrgId,
        'title': '选择领用人',
      };
      var backParams = await SCRouterHelper.pathPage(SCRouterPath.selectReceiverPage, params);
      if (backParams != null) {
        setState(() {
          receiverModel = backParams['receiverModel'];
          widget.state.fetchUserId = receiverModel.personId ?? '';
          widget.state.fetchUserName =  receiverModel.personName ?? '';
        });
      }
    }
  }

  /// 底部按钮
  List<String> bottomButtonList() {
    if (widget.state.isEdit) {
      return ["确定"];
    } else {
      return ['暂存', '提交'];
    }
  }

  /// 编辑
  editAction() {
    print("编辑");
    if (widget.state.wareHouseId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectWareHouseNameTip);
      return;
    }

    if (widget.state.typeID <= 0) {
      SCToast.showTip(SCDefaultValue.selectWareHouseTypeTip);
      return;
    }

    if (widget.state.type == '领料出库' || widget.state.type == '维修领料' || widget.state.type == '资产领用出库') {
      if (widget.state.fetchOrgId.isEmpty) {
        SCToast.showTip(SCDefaultValue.selectDepartmentTip);
        return;
      }

      if (widget.state.fetchUserId.isEmpty) {
        SCToast.showTip(SCDefaultValue.selectUserTip);
        return;
      }
    }

    if (widget.state.selectedList.isEmpty) {
      SCToast.showTip(SCDefaultValue.addMaterialInfoTip);
      return;
    }

    var params = {
      "wareHouseName" : widget.state.wareHouseName,
      "wareHouseId" : widget.state.wareHouseId,
      "typeName" : widget.state.type,
      "typeId" : widget.state.typeID,
      "remark" : widget.state.remark,
      "id" : widget.state.editId
    };
    widget.state.editMaterialBaseInfo(data: params);
  }

  /// 新增物资-添加
  onlyAddMaterial(List<SCMaterialListModel> list) {
    widget.state.updateSelectedMaterial(list);
  }

  /// 新增物资-编辑
  editAddMaterial(List<SCMaterialListModel> list) {
    print("原始数据===${widget.state.selectedList}");

    print("添加===$list");
    // 编辑的物资
    List<SCMaterialListModel> editList = [];
    // 新增的物资
    List<SCMaterialListModel> addList = [];
    for (SCMaterialListModel model in list) {
      // 是否存在
      bool contains = false;
      // 是否需要更新
      bool needUpdate = false;
      SCMaterialListModel tempModel = SCMaterialListModel();

      for (SCMaterialListModel subModel in widget.state.selectedList) {
        if (model.materialId == subModel.materialId) {
          contains = true;
          tempModel = SCMaterialListModel.fromJson(subModel.toJson());
          if (model.localNum == subModel.localNum) {
            needUpdate = false;
          } else {
            tempModel.localNum = model.localNum;
            subModel.localNum = model.localNum;
            needUpdate = true;
          }
          break;
        } else {
          contains = false;
        }
      }

      if (contains) {
        if (needUpdate) {
          editList.add(tempModel);
        }
      } else {
        addList.add(model);
      }
    }

    for (SCMaterialListModel model in editList) {
      print("编辑的物资===${model.toJson()}");
    }

    List<SCMaterialListModel> newList = widget.state.selectedList;
    List addJsonList = [];
    for (SCMaterialListModel model in addList) {
      model.inId = widget.state.editId;
      newList.add(model);
      var subParams = model.toJson();
      subParams['materialId'] = model.materialId;
      subParams['materialName'] = model.materialName;
      subParams['num'] = model.localNum;
      subParams['inId'] = widget.state.editId;
      addJsonList.add(subParams);
      print("新增的物资===${subParams}");
    }

    if (editList.isNotEmpty) {
      widget.state.editMaterial(list: editList);
    }

    if (addList.isNotEmpty) {
      widget.state.editAddMaterial(list: addJsonList);
    }

    widget.state.updateSelectedMaterial(newList);
  }

  /// 编辑单条物资
  editOneMaterial(int index) {
    if (widget.state.isEdit) {
      List<SCMaterialListModel> list = [widget.state.selectedList[index]];
      widget.state.editMaterial(list: list);
    } else {
      widget.state.update();
    }
  }
}
