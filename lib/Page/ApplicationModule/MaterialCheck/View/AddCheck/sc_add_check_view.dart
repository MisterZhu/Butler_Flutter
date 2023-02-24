import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
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
import '../../../MaterialEntry/Model/sc_selectcategory_model.dart';
import '../../../MaterialEntry/Model/sc_selectcategory_tree_model.dart';
import '../../../MaterialEntry/Model/sc_wareHouse_model.dart';
import '../../../MaterialEntry/View/SelectCategoryAlert/sc_add_material_selectcategory_alert.dart';
import '../../../MaterialOutbound/Controller/sc_select_department_controller.dart';
import '../../../MaterialOutbound/Model/sc_receiver_model.dart';
import '../../Controller/sc_add_check_controller.dart';

/// 盘点任务view

class SCAddCheckView extends StatefulWidget {
  /// SCAddCheckController
  final SCAddCheckController state;

  /// SCSelectDepartmentController
  final SCSelectDepartmentController selectDepartmentController;

  SCAddCheckView(
      {Key? key, required this.state, required this.selectDepartmentController})
      : super(key: key);

  @override
  SCAddCheckViewState createState() => SCAddCheckViewState();
}

class SCAddCheckViewState extends State<SCAddCheckView> {
  /// 处理人
  SCReceiverModel receiverModel = SCReceiverModel();

  late StreamSubscription<bool> keyboardSubscription;

  /// 是否弹起键盘
  bool isShowKeyboard = false;

  List rangeList = ['全盘', '物资分类', '物资名称'];

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
        )
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
        itemCount: 3);
  }

  Widget getCell(int index) {
    if (index == 0) {
      return SCBasicInfoCell(
        list: getBaseInfoList(),
        requiredRemark: false,
        requiredPhotos: false,
        rangeList: rangeList,
        selectRangeAction: (index) {
          print('盘点范围==========$index');
          widget.state.range = index;
          widget.state.update();
        },
        inputNameAction: (value) {
          // 任务名称
          widget.state.taskName = value;
        },
        selectAction: (index) async {
          if (index == 1) {
            // 开始时间
            showTimeAlert(context, 0);
          } else if (index == 2) {
            // 结束时间
            showTimeAlert(context, 1);
          } else if (index == 3) {
            // 仓库名称
            List list = widget.state.wareHouseList.map((e) => e.name).toList();
            showAlert(1, '仓库名称', list);
          } else if (index == 4) {
            // 部门
            showSelectDepartmentAlert();
          } else if (index == 5) {
            // 处理人
            selectUser();
          }
        },
      );
    } else if (index == 1) {
      if (widget.state.range == 0) {
        return const SizedBox();
      } else {
        return SCMaterialInfoCell(
          title: widget.state.range == 1 ? '物资分类' : '物资名称',
          materialType: widget.state.range == 1 ? 1 : 0,
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
      }
    } else {
      return const SizedBox(
        height: 10,
      );
    }
  }

  /// 弹出弹窗
  showAlert(int index, String title, List list) {
    List<SCHomeTaskModel> modelList = [];
    for (int i = 0; i < list.length; i++) {
      modelList.add(SCHomeTaskModel.fromJson(
          {"name": list[i], "id": "$i", "isSelect": false}));
    }
    int currentIndex = -1;
    if (index == 1) {
      // 仓库名称
      currentIndex = widget.state.nameIndex;
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
                if (index == 1) {
                  // 仓库名称
                  SCWareHouseModel subModel =
                      widget.state.wareHouseList[selectIndex];
                  widget.state.nameIndex = selectIndex;
                  widget.state.wareHouseName = model.name ?? '';
                  widget.state.wareHouseId = subModel.id ?? '';
                }
              });
            },
          ));
    });
  }

  /// 报损日期弹窗
  showTimeAlert(BuildContext context, int timeIndex) {
    DateTime now = DateTime.now();
    SCPickerUtils pickerUtils = SCPickerUtils();
    pickerUtils.title = timeIndex == 0 ? '开始时间' : '结束时间';
    pickerUtils.cancelText = '上一步';
    pickerUtils.pickerType = SCPickerType.date;
    pickerUtils.completionHandler = (selectedValues, selecteds) {
      DateTime value = selectedValues.first;
      setState(() {
        if (timeIndex == 0) {
          widget.state.startTimeStr =
              formatDate(value, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn]);
          widget.state.startTime = formatDate(
              value, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]);
        } else if (timeIndex == 1) {
          widget.state.endTimeStr =
              formatDate(value, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn]);
          widget.state.endTime = formatDate(
              value, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]);
        }
      });
    };
    pickerUtils.showDatePicker(
        context: context,
        dateType: PickerDateTimeType.kYMDHM,
        minValue: DateTime(now.year - 1, 1, 1, 00, 00),
        maxValue: DateTime(now.year + 1, 12, 31, 23, 59));
  }

  /// 获取基础信息
  List getBaseInfoList() {
    /// 基础信息数组
    List baseInfoList = [
      {
        'isRequired': true,
        'title': '任务名称',
        'content': widget.state.taskName,
        'isInput': true
      },
      {
        'isRequired': true,
        'title': '开始时间',
        'content': widget.state.startTimeStr
      },
      {'isRequired': true, 'title': '结束时间', 'content': widget.state.endTimeStr},
      {
        'isRequired': true,
        'title': '仓库名称',
        'content': widget.state.wareHouseName
      },
      {'isRequired': true, 'title': '部门', 'content': widget.state.orgName},
      {
        'isRequired': true,
        'title': '处理人',
        'content': widget.state.operatorName
      },
    ];
    return baseInfoList;
  }

  /// 添加物资
  addAction() async {
    if (widget.state.wareHouseId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectWareHouseNameTip);
      return;
    }
    if (widget.state.range == 1) {
      var list =
          await SCRouterHelper.pathPage(SCRouterPath.checkSelectCategoryPage, {
        'data': widget.state.selectedCategoryList,
        'wareHouseId': widget.state.wareHouseId
      });
      if (list != null) {
        widget.state.updateSelectedMaterial(list);
      }
    } else if (widget.state.range == 2) {
      if (widget.state.isEdit) {
        print("编辑-添加物资");
        addExitsMaterialAction();
      } else {
        print("添加物资");
        addMaterialAction();
      }
    }
  }

  /// 新增物资-添加物资
  addMaterialAction() async {
    var list = await SCRouterHelper.pathPage(SCRouterPath.addMaterialPage, {
      'data': widget.state.selectedList,
      'wareHouseId': widget.state.wareHouseId,
      "materialType": SCWarehouseManageType.outbound
    });
    if (list != null) {
      onlyAddMaterial(list);
    }
  }

  /// 编辑物资-添加既存物资
  addExitsMaterialAction() async {
    var list = await SCRouterHelper.pathPage(SCRouterPath.addMaterialPage, {
      'data': widget.state.selectedList,
      'wareHouseId': widget.state.wareHouseId,
      'isEdit': true,
      "materialType": SCWarehouseManageType.outbound
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
    if (widget.state.taskName.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectTaskName);
      return;
    }
    if (widget.state.startTimeStr.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectStartTime);
      return;
    }

    if (widget.state.endTimeStr.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectEndTime);
      return;
    }

    if (widget.state.wareHouseId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectWareHouseNameTip);
      return;
    }

    if (widget.state.operatorName.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectOperatorName);
      return;
    }

    if (widget.state.range != 0 && widget.state.selectedList.isEmpty) {
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
      "wareHouseName": widget.state.wareHouseName,
      "wareHouseId": widget.state.wareHouseId,
      "taskName": widget.state.taskName,
      "startTime": widget.state.startTime,
      "endTime": widget.state.endTime,
      "operatorName": widget.state.operatorName,
      "operator": widget.state.operator,
      "range": widget.state.range,
      "materialList": materialList
    };
    widget.state.addTransfer(status: status, data: params);
  }

  /// 选择部门
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

  /// 确定选择部门
  sureSelectDepartment() {
    bool enable =
        widget.selectDepartmentController.currentDepartmentModel.enable ??
            false;
    if (enable) {
      if (widget.state.orgId !=
          (widget.selectDepartmentController.currentDepartmentModel.id ?? '')) {
        widget.state.operator = '';
        widget.state.operatorName = '';
        widget.state.orgId =
            widget.selectDepartmentController.currentDepartmentModel.id ?? '';
        widget.state.orgName =
            widget.selectDepartmentController.currentDepartmentModel.title ??
                '';
        widget.state.update();
      }
    } else {
      // 未选择数据
    }
  }

  /// 选择处理人
  selectUser() async {
    if (widget.state.orgId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectFrmLossDepartment);
    } else {
      var params = {
        'receiverModel': receiverModel,
        'orgId': widget.state.orgId,
        'title': '选择处理人',
      };
      var backParams = await SCRouterHelper.pathPage(
          SCRouterPath.selectReceiverPage, params);
      if (backParams != null) {
        setState(() {
          receiverModel = backParams['receiverModel'];
          widget.state.operator = receiverModel.personId ?? '';
          widget.state.operatorName = receiverModel.personName ?? '';
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
    if (widget.state.taskName.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectTaskName);
      return;
    }
    if (widget.state.startTimeStr.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectStartTime);
      return;
    }

    if (widget.state.endTimeStr.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectEndTime);
      return;
    }

    if (widget.state.wareHouseId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectWareHouseNameTip);
      return;
    }

    if (widget.state.operatorName.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectOperatorName);
      return;
    }

    if (widget.state.range != 0 && widget.state.selectedList.isEmpty) {
      SCToast.showTip(SCDefaultValue.addMaterialInfoTip);
      return;
    }
    var params = {
      "wareHouseName": widget.state.wareHouseName,
      "wareHouseId": widget.state.wareHouseId,
      "taskName": widget.state.taskName,
      "startTime": widget.state.startTime,
      "endTime": widget.state.endTime,
      "operatorName": widget.state.operatorName,
      "operator": widget.state.operator,
      "range": widget.state.range,
      "id": widget.state.editId
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
}
