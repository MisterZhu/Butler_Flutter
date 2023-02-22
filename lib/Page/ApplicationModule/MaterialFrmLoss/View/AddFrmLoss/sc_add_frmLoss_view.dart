import 'dart:async';
import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_picker/Picker.dart';
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
import '../../../MaterialOutbound/Controller/sc_select_department_controller.dart';
import '../../../MaterialOutbound/Model/sc_receiver_model.dart';
import '../../Controller/sc_add_frmLoss_controller.dart';

/// 新增调拨view

class SCAddFrmLossView extends StatefulWidget {
  /// SCAddFrmLossController
  final SCAddFrmLossController state;

  /// SCSelectDepartmentController
  final SCSelectDepartmentController selectDepartmentController;

  SCAddFrmLossView({Key? key, required this.state, required this.selectDepartmentController}) : super(key: key);
  @override
  SCAddFrmLossViewState createState() => SCAddFrmLossViewState();
}

class SCAddFrmLossViewState extends State<SCAddFrmLossView> {

  /// 报损人
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
        itemCount: 5);
  }

  Widget getCell(int index) {
    if (index == 0) {
      return SCBasicInfoCell(
        list: getBaseInfoList(),
        requiredRemark: true,
        requiredPhotos: widget.state.isEdit ? false : true,
        remark: widget.state.remark,
        files: widget.state.files,
        selectAction: (index) async {
          if (index == 0) {
            // 仓库名称
            List list = widget.state.wareHouseList.map((e) => e.name).toList();
            showAlert(0, '仓库名称', list);
          } else if (index == 1) {
            // 类型
            List list = widget.state.typeList.map((e) => e.name).toList();
            showAlert(1, '类型', list);
          } else if (index == 2) {
            // 报损部门
            showSelectDepartmentAlert();
          } else if (index == 3) {
            // 报损人
            selectFrmLossUser();
          } else if (index == 4) {
            // 报损时间
            showTimeAlert(context);
          }
        },
        inputAction: (content) {
          widget.state.remark = content;
        },
        updatePhoto: (list) {
          widget.state.files = list;
        },
      );
    } else if (index == 1) {
      return SCMaterialInfoCell(
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
      // 仓库
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
                  // 仓库
                  SCWareHouseModel subModel = widget.state.wareHouseList[selectIndex];
                  widget.state.nameIndex = selectIndex;
                  widget.state.wareHouseName = model.name ?? '';
                  widget.state.wareHouseId = subModel.id ?? '';
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

  /// 报损日期弹窗
  showTimeAlert (BuildContext context) {
    DateTime now = DateTime.now();
    SCPickerUtils pickerUtils = SCPickerUtils();
    pickerUtils.title = '报损日期';
    pickerUtils.cancelText = '上一步';
    pickerUtils.pickerType = SCPickerType.date;
    pickerUtils.completionHandler = (selectedValues, selecteds) {
      DateTime value = selectedValues.first;
      setState(() {
        widget.state.reportTimeStr = formatDate(value, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn]);
        widget.state.reportTime = formatDate(value, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]);
      });
    };
    pickerUtils.showDatePicker(
        context: context,
        dateType: PickerDateTimeType.kYMDHM,
        minValue: DateTime(now.year - 1, 1, 1, 00, 00),
        maxValue: DateTime(now.year + 9, 12, 31, 23, 59)
    );
  }

  /// 获取基础信息
  List getBaseInfoList() {
    /// 基础信息数组
    List baseInfoList = [
      {'isRequired': true,'title': '仓库名称','content': widget.state.wareHouseName},
      {'isRequired': true, 'title': '类型', 'content': widget.state.type},
      {'isRequired': true,'title': '报损部门','content': widget.state.reportOrgName},
      {'isRequired': true,'title': '报损人','content': widget.state.reportUserName},
      {'isRequired': true,'title': '报损日期','content': widget.state.reportTimeStr},

    ];
    return baseInfoList;
  }

  /// 添加物资
  addAction() async {
    if (widget.state.wareHouseId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectWarehouseTip);
      return;
    }
    var list = await SCRouterHelper.pathPage(SCRouterPath.addMaterialPage, {'data': widget.state.selectedList, 'wareHouseId': widget.state.wareHouseId});
    if (list != null) {
      widget.state.updateSelectedMaterial(list);
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

    if (widget.state.reportOrgId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectFrmLossDepartment);
      return;
    }

    if (widget.state.reportUserId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectFrmLossUser);
      return;
    }

    if (widget.state.reportTime.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectFrmLossTime);
      return;
    }

    if (widget.state.selectedList.isEmpty) {
      SCToast.showTip(SCDefaultValue.addMaterialInfoTip);
      return;
    }

    List materialList = [];
    for (SCMaterialListModel model in widget.state.selectedList) {
      var params = model.toJson();
      params['num'] = model.localNum;
      params['materialId'] = model.id;
      params['materialName'] = model.name;
      materialList.add(params);
    }

    var params = {
      "wareHouseName" : widget.state.wareHouseName,
      "wareHouseId" : widget.state.wareHouseId,
      "reportOrgId" : widget.state.reportOrgId,
      "reportOrgName" : widget.state.reportOrgName,
      "reportUserId" : widget.state.reportUserId,
      "reportUserName" : widget.state.reportUserName,
      "reportTime" : widget.state.reportTime,
      "typeName" : widget.state.type,
      "typeId" : widget.state.typeID,
      "remark" : widget.state.remark,
      "materialList" : materialList,
      "files": widget.state.files,
    };
    widget.state.addTransfer(status: status, data: params);
  }

  /// 选择报损部门
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

  /// 确定选择报损部门
  sureSelectDepartment() {
    bool enable = widget.selectDepartmentController.currentDepartmentModel.enable ?? false;
    if (enable) {
      if (widget.state.reportOrgId != (widget.selectDepartmentController.currentDepartmentModel.id ?? '')) {
        widget.state.reportUserId = '';
        widget.state.reportUserName = '';
        widget.state.reportOrgId = widget.selectDepartmentController.currentDepartmentModel.id ?? '';
        widget.state.reportOrgName = widget.selectDepartmentController.currentDepartmentModel.title ?? '';
        widget.state.update();
      }
    } else {// 未选择数据
    }
  }

  /// 选择报损人
  selectFrmLossUser() async{
    if (widget.state.reportOrgId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectFrmLossDepartment);
    } else {
      var params = {
        'receiverModel': receiverModel,
        'orgId': widget.state.reportOrgId,
      };
      var backParams = await SCRouterHelper.pathPage(SCRouterPath.selectReceiverPage, params);
      if (backParams != null) {
        setState(() {
          receiverModel = backParams['receiverModel'];
          widget.state.reportUserId = receiverModel.personId ?? '';
          widget.state.reportUserName =  receiverModel.personName ?? '';
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

    if (widget.state.reportOrgId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectFrmLossDepartment);
      return;
    }

    if (widget.state.reportUserId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectFrmLossUser);
      return;
    }

    if (widget.state.reportTime.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectFrmLossTime);
      return;
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
      "reportOrgName" : widget.state.reportOrgName,
      "reportOrgId" : widget.state.reportOrgId,
      "reportUserName" : widget.state.reportUserName,
      "reportUserId" : widget.state.reportUserId,
      "reportTime" : widget.state.reportTime,
      "remark" : widget.state.remark,
      "id" : widget.state.editId,
      "files" : widget.state.files,
    };
    widget.state.editMaterialBaseInfo(data: params);
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
