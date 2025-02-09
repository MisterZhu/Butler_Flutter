import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:date_format/date_format.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/AddEntry/sc_basic_info_cell.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../../WorkBench/Home/Model/sc_home_task_model.dart';
import '../../../../WorkBench/Home/View/Alert/sc_task_module_alert.dart';
import '../../../HouseInspect/View/sc_bottom_button_item.dart';
import '../../../MaterialEntry/Model/sc_entry_type_model.dart';
import '../../../MaterialEntry/Model/sc_material_list_model.dart';
import '../../../MaterialEntry/Model/sc_selectcategory_model.dart';
import '../../../MaterialEntry/Model/sc_selectcategory_tree_model.dart';
import '../../../MaterialEntry/View/AddEntry/sc_material_info_cell.dart';
import '../../../MaterialEntry/View/SelectCategoryAlert/sc_add_material_selectcategory_alert.dart';
import '../../../MaterialOutbound/Controller/sc_select_department_controller.dart';
import '../../../MaterialOutbound/Model/sc_receiver_model.dart';
import '../../Controller/sc_add_propertymaintenance_controller.dart';

/// 新增资产维保view

class SCAddPropertyMaintenanceView extends StatefulWidget {
  /// SCAddPropertyMaintenanceController
  final SCAddPropertyMaintenanceController state;

  /// SCSelectDepartmentController
  final SCSelectDepartmentController selectDepartmentController;

  SCAddPropertyMaintenanceView(
      {Key? key, required this.state, required this.selectDepartmentController})
      : super(key: key);
  @override
  SCAddPropertyMaintenanceViewState createState() =>
      SCAddPropertyMaintenanceViewState();
}

class SCAddPropertyMaintenanceViewState
    extends State<SCAddPropertyMaintenanceView> {
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
        requiredAttachment: true,
        requiredPhotos: widget.state.isEdit ? false : true,
        remark: widget.state.remark,
        files: widget.state.files,
        attachmentsList: widget.state.attachmentsList,
        selectAction: (index, title) async {
          if (index == 0) {
            // 类型
            List list = widget.state.typeList.map((e) => e.name).toList();
            showAlert(0, '类型', list);
          } else if (index == 1) {
            // 维保部门
            showSelectDepartmentAlert(true);
          } else if (index == 2) {
            // 维保负责人
            selectFrmLossUser();
          } else if (index == 3) {
            // 开始时间
            showTimeAlert(context, true);
          } else if (index == 4) {
            // 结束时间
            showTimeAlert(context, false);
          }
        },
        inputAction: (content) {
          widget.state.remark = content;
        },
        updatePhoto: (list) {
          widget.state.files = list;
          widget.state.update();
        },
        uploadFileAction: () {
          uploadFileAction();
        },
        deleteAttachmentAction: (int value) {
          widget.state.deleteAttachment(value);
        },
      );
    } else if (index == 1) {
      var propertyMap = {
        'unifyCompany': widget.state.unifyCompany,
        'company': widget.state.maintenanceCompany,
        'unifyContent': widget.state.unifyContent,
        'content': widget.state.maintenanceContent,
      };
      return SCMaterialInfoCell(
        title: '维保资产',
        showAdd: true,
        materialType: 4,
        list: widget.state.selectedList,
        isProperty: true,
        propertyMap: propertyMap,
        addAction: () {
          addAction();
        },
        deleteAction: (int subIndex) {
          deleteAction(subIndex);
        },
        unifyPropertyCompanyAction: (bool value) {
          if (value) {
            unifyCompanyOrContentTip(0);
          } else {
            widget.state.updateUnifyCompanyStatus(value);
          }
        },
        unifyPropertyContentAction: (bool value) {
          if (value) {
            unifyCompanyOrContentTip(1);
          } else {
            widget.state.updateUnifyContentStatus(value);
          }
        },
        propertyCompanyAction: (String value) {
          widget.state.updateUnifyCompany(value);
        },
        propertyContentAction: (String value) {
          widget.state.updateUnifyContent(value);
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
                  // 类型
                  SCEntryTypeModel subModel =
                      widget.state.typeList[selectIndex];
                  widget.state.typeIndex = selectIndex;
                  widget.state.type = model.name ?? '';
                  widget.state.typeID = subModel.stringCode ?? '';
                }
              });
            },
          ));
    });
  }

  /// 维保时间弹窗
  showTimeAlert(BuildContext context, bool isStart) {
    DateTime now = DateTime.now();
    SCPickerUtils pickerUtils = SCPickerUtils();
    pickerUtils.title = isStart ? '开始时间' : '结束时间';
    pickerUtils.cancelText = '取消';
    pickerUtils.pickerType = SCPickerType.date;
    pickerUtils.completionHandler = (selectedValues, selecteds) {
      DateTime value = selectedValues.first;
      setState(() {
        if (isStart) {
          widget.state.reportStartTimeStr =
              formatDate(value, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn]);
          widget.state.reportStartTime = formatDate(
              value, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]);
        } else {
          widget.state.reportEndTimeStr =
              formatDate(value, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn]);
          widget.state.reportEndTime = formatDate(
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
      {'isRequired': true, 'title': '维保类型', 'content': widget.state.type},
      {
        'isRequired': true,
        'title': '维保部门',
        'content': widget.state.reportOrgName
      },
      {
        'isRequired': true,
        'title': '维保负责人',
        'content': widget.state.reportUserName
      },
      {
        'isRequired': true,
        'title': '开始时间',
        'content': widget.state.reportStartTimeStr
      },
      {
        'isRequired': true,
        'title': '结束时间',
        'content': widget.state.reportEndTimeStr
      },
    ];
    return baseInfoList;
  }

  /// 添加物资
  addAction() async {
    if (widget.state.reportOrgId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectMaintenanceDepartment);
      return;
    }
    if (widget.state.isEdit) {
      addExitsMaterialAction();
    } else {
      addMaterialAction();
    }
  }

  /// 新增物资-添加物资
  addMaterialAction() async {
    var list = await SCRouterHelper.pathPage(SCRouterPath.addMaterialPage, {
      'propertyData': widget.state.selectedList,
      'materialType': SCWarehouseManageType.propertyFrmLoss,
      'orgId': widget.state.reportOrgId,
      'isProperty': true
    });
    if (list != null) {
      onlyAddMaterial(list);
    }
  }

  /// 编辑物资-添加既存物资
  addExitsMaterialAction() async {
    var list = await SCRouterHelper.pathPage(SCRouterPath.addMaterialPage, {
      'propertyData': widget.state.selectedList,
      'orgId': widget.state.fetchOrgId,
      'isEdit': true,
      "materialType": SCWarehouseManageType.propertyFrmLoss,
      'isProperty': true
    });
    if (list != null) {
      editAddMaterial(list);
    }
  }

  /// 新增物资-添加
  onlyAddMaterial(List<SCMaterialListModel> list) {
    print('新增物资==================$list');
    widget.state.updateSelectedMaterial(list);
  }

  /// 删除物资
  deleteAction(int index) {
    if (widget.state.isEdit) {
      SCMaterialListModel model = widget.state.selectedList[index];
      print("物资id===${model.id}");
      widget.state.deleteMaterial(index);
      widget.state.editDeleteMaterial(reportId: model.id ?? '');
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
    if (widget.state.typeID.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectWareHouseTypeTip);
      return;
    }

    if (widget.state.reportOrgId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectMaintenanceDepartment);
      return;
    }

    if (widget.state.reportUserId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectMaintenanceUser);
      return;
    }

    if (widget.state.reportStartTime.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectStartTime);
      return;
    }

    if (widget.state.reportEndTime.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectEndTime);
      return;
    }

    if (widget.state.selectedList.isEmpty) {
      SCToast.showTip(SCDefaultValue.addMaterialInfoTip);
      return;
    }

    List materialList = [];
    for (SCMaterialListModel model in widget.state.selectedList) {
      if (widget.state.unifyCompany) {
        model.maintenanceCompany = widget.state.maintenanceCompany;
        model.unifyMaintenanceCompany = widget.state.unifyCompany;
      }

      if (widget.state.unifyContent) {
        model.maintenanceContent = widget.state.maintenanceContent;
        model.unifyMaintenanceContent = widget.state.unifyContent;
      }
      var params = model.toJson();
      params['partName'] = model.maintenanceCompany ?? '';
      params['remark'] = model.maintenanceContent ?? '';
      params['price'] = model.maintenancePrice ?? 0.0;
      materialList.add(params);
    }

    var params = {
      "fetchOrgId": widget.state.fetchOrgId,
      "fetchOrgName": widget.state.fetchOrgName,
      "reportOrgId": widget.state.reportOrgId,
      "reportOrgName": widget.state.reportOrgName,
      "reportUserId": widget.state.reportUserId,
      "reportUserName": widget.state.reportUserName,
      "reportStartTime": widget.state.reportStartTime,
      "reportEndTime": widget.state.reportEndTime,
      "typeName": widget.state.type,
      "typeId": widget.state.typeID,
      "remark": widget.state.remark,
      "materialList": materialList,
      "files": widget.state.files,
    };
    widget.state.addFrmLoss(status: status, data: params);
  }

  /// 选择部门
  showSelectDepartmentAlert(bool isReport) {
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
                      if (isReport == true) {
                        sureSelectDepartment();
                      } else {
                        sureSelectUserDepartment();
                      }
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

  /// 确定选择使用部门
  sureSelectUserDepartment() {
    bool enable =
        widget.selectDepartmentController.currentDepartmentModel.enable ??
            false;
    if (enable) {
      if (widget.state.fetchOrgId !=
          (widget.selectDepartmentController.currentDepartmentModel.id ?? '')) {
        widget.state.fetchOrgId =
            widget.selectDepartmentController.currentDepartmentModel.id ?? '';
        widget.state.fetchOrgName =
            widget.selectDepartmentController.currentDepartmentModel.title ??
                '';
        widget.state.update();
      }
    } else {
      // 未选择数据
    }
  }

  /// 确定选择报损部门
  sureSelectDepartment() {
    bool enable =
        widget.selectDepartmentController.currentDepartmentModel.enable ??
            false;
    if (enable) {
      if (widget.state.reportOrgId !=
          (widget.selectDepartmentController.currentDepartmentModel.id ?? '')) {
        widget.state.reportUserId = '';
        widget.state.reportUserName = '';
        widget.state.reportOrgId =
            widget.selectDepartmentController.currentDepartmentModel.id ?? '';
        widget.state.reportOrgName =
            widget.selectDepartmentController.currentDepartmentModel.title ??
                '';
        widget.state.update();
      }
    } else {
      // 未选择数据
    }
  }

  /// 选择报损人
  selectFrmLossUser() async {
    if (widget.state.reportOrgId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectFrmLossDepartment);
    } else {
      var params = {
        'receiverModel': receiverModel,
        'orgId': widget.state.reportOrgId,
        'title': '选择维保负责人',
      };
      var backParams = await SCRouterHelper.pathPage(
          SCRouterPath.selectReceiverPage, params);
      if (backParams != null) {
        setState(() {
          receiverModel = backParams['receiverModel'];
          widget.state.reportUserId = receiverModel.personId ?? '';
          widget.state.reportUserName = receiverModel.personName ?? '';
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
    if (widget.state.typeID.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectWareHouseTypeTip);
      return;
    }

    if (widget.state.fetchOrgId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectUserDepartment);
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

    if (widget.state.reportStartTime.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectFrmLossTime);
      return;
    }

    if (widget.state.reportEndTime.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectFrmLossTime);
      return;
    }

    if (widget.state.selectedList.isEmpty) {
      SCToast.showTip(SCDefaultValue.addMaterialInfoTip);
      return;
    }

    var params = {
      "typeName": widget.state.type,
      "typeId": widget.state.typeID,
      "fetchOrgName": widget.state.fetchOrgName,
      "fetchOrgId": widget.state.fetchOrgId,
      "reportOrgName": widget.state.reportOrgName,
      "reportOrgId": widget.state.reportOrgId,
      "reportUserName": widget.state.reportUserName,
      "reportUserId": widget.state.reportUserId,
      "reportStartTime": widget.state.reportStartTime,
      "reportEndTime": widget.state.reportEndTime,
      "remark": widget.state.remark,
      "id": widget.state.editId,
      "files": widget.state.files,
    };
    widget.state.editMaterialBaseInfo(data: params);
  }

  /// 新增物资-编辑
  editAddMaterial(List<SCMaterialListModel> list) {
    print("原始数据===${widget.state.selectedList}");

    print("添加===$list");

    // 新增的物资
    List<SCMaterialListModel> addList = [];
    for (SCMaterialListModel model in list) {
      // 是否存在
      bool contains = false;

      for (SCMaterialListModel subModel in widget.state.selectedList) {
        if (model.assetId == subModel.assetId) {
          contains = true;
          break;
        } else {
          contains = false;
        }
      }

      if (contains) {
      } else {
        addList.add(model);
      }
    }

    List<SCMaterialListModel> newList = widget.state.selectedList;
    List addJsonList = [];
    for (SCMaterialListModel model in addList) {
      model.inId = widget.state.editId;
      newList.add(model);
      var subParams = model.toJson();
      subParams['reportId'] = widget.state.editId;
      addJsonList.add(subParams);
      print("新增的物资===${subParams}");
    }

    if (addList.isNotEmpty) {
      widget.state.editAddMaterial(list: addJsonList);
    }

    widget.state.updateSelectedMaterial(newList);
  }

  /// 统一维保单位或内容提示
  unifyCompanyOrContentTip(int type) {
    /// type,0-维保单位，1-维保内容
    String content = type == 0
        ? SCDefaultValue.unifyMaintenanceCompanyTip
        : SCDefaultValue.unifyMaintenanceContentTip;
    SCDialogUtils.instance.showMiddleDialog(
      context: context,
      content: content,
      customWidgetButtons: [
        defaultCustomButton(context,
            text: '取消',
            textColor: SCColors.color_1B1C33,
            fontWeight: FontWeight.w400),
        defaultCustomButton(context,
            text: '确定',
            textColor: SCColors.color_4285F4,
            fontWeight: FontWeight.w400, onTap: () async {
          if (type == 0) {
            widget.state.updateUnifyCompanyStatus(true);
          } else {
            widget.state.updateUnifyContentStatus(true);
          }
        }),
      ],
    );
  }

  /// 上传文件
  uploadFileAction() async {
    // FilePickerResult? result = await FilePicker.platform.pickFiles(
    //   allowMultiple: true,
    // );
    //
    // if (result != null) {
    //   widget.state.updateAttachment(result.files);
    // }
  }
}
