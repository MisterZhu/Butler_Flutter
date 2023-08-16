import 'dart:async';
import 'dart:developer';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_list_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_purchase_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/AddEntry/sc_basic_info_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/AddEntry/sc_material_info_cell.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../../WorkBench/Home/Model/sc_home_task_model.dart';
import '../../../../WorkBench/Home/View/Alert/sc_task_module_alert.dart';
import '../../Controller/sc_add_entry_controller.dart';
import '../../Model/sc_entry_type_model.dart';
import '../../Model/sc_wareHouse_model.dart';
import '../Detail/sc_material_bottom_view.dart';

/// 新增入库view

class SCAddEntryView extends StatefulWidget {
  /// SCAddEntryController
  final SCAddEntryController state;

  SCAddEntryView({Key? key, required this.state}) : super(key: key);

  @override
  SCAddEntryViewState createState() => SCAddEntryViewState();
}

class SCAddEntryViewState extends State<SCAddEntryView> {
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
    List list = [
      {
        "type": scMaterialBottomViewType1,
        "title": "暂存",
      },
      {
        "type": scMaterialBottomViewType2,
        "title": "提交",
      },
    ];
    if (widget.state.isEdit == true) {
      list = [
        {
          "type": scMaterialBottomViewType2,
          "title": "确定",
        },
      ];
    }
    if (widget.state.isReturnEntry == true || widget.state.type == '采购入库') {
      list = [
        {
          "type": scMaterialBottomViewType2,
          "title": "提交",
        },
      ];
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: listview(context)),
        Offstage(
          offstage: isShowKeyboard,
          child: SCMaterialDetailBottomView(
            list: list,
            onTap: (value) {
              if (value == '编辑') {
                editAction();
              } else if(value == '提交') {
                submit();
              } else if(value == '暂存') {
                save();
              } else if (value == '确定') {
                submit();
              }}
          )),
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

  /// cell
  Widget getCell(int index) {
    if (index == 0) {
      return SCBasicInfoCell(
        // 基础信息
        list: getBaseInfoList(),
        requiredRemark: true,
        requiredPhotos: widget.state.isEdit ? false : true,
        remark: widget.state.remark,
        files: widget.state.files,
        selectAction: (index, title) {
          if (title == '仓库名称') {
            // 仓库名称
            List list = widget.state.wareHouseList.map((e) => e.name).toList();
            showAlert(0, '仓库名称', list);
          } else if (title == '入库类型') {
            // 入库类型
            List list = widget.state.typeList.map((e) => e.name).toList();
            showAlert(1, '入库类型', list);
          } else if (title == '物资类型') {
            // 物资类型
            List list = widget.state.materialTypeList.map((e) => e).toList();
            showAlert(2, '物资类型', list);
          } else if (title == '采购需求单') {
            purchaseSearch();
          } else if (title == '入库日期') {
            // 入库日期
            showTimeAlert(context);
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
      // 物资信息
      return SCMaterialInfoCell(
        title: (widget.state.materialType == 1 || widget.state.isProperty == true) ? '资产信息' : '物资信息',
        showAdd: widget.state.isReturnEntry == true ? false : true,
        list: widget.state.selectedList,
        isReturnEntry: widget.state.isReturnEntry,
        materialType: widget.state.type == '采购入库' ? 3 : 0,
        isProperty:  widget.state.materialType == 1 ? true : widget.state.isProperty,
        addAction: () {
          addAction();
        },
        deleteAction: (int subIndex) {
          deleteAction(subIndex);
        },
        updateNumAction: (int index, int value) {
          if (widget.state.isEdit) {
            widget.state.update();
            editOneMaterial(index);
          } else {
            widget.state.update();
          }
        },
        noNeedReturnAction: (int index, bool status) {
          SCMaterialListModel model = widget.state.selectedList[index];
          if (status == true) {
            model.returnCheck = 0;
          } else {
            model.returnCheck = 1;
          }
        }
      );
    } else {
      return const SizedBox(
        height: 12,
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
      // 入库类型
      currentIndex = widget.state.typeIndex;
    } else if (index == 2) {
      // 物资类型
      currentIndex = widget.state.materialTypeIndex;
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
                  SCWareHouseModel subModel =
                      widget.state.wareHouseList[selectIndex];
                  widget.state.nameIndex = selectIndex;
                  widget.state.wareHouseName = model.name ?? '';
                  widget.state.wareHouseId = subModel.id ?? '';
                } else if (index == 1) {
                  // 类型
                  if ((model.name ?? '') != widget.state.type) {
                    widget.state.updateSelectedMaterial([]);
                    if (widget.state.type == '采购入库') {
                      widget.state.purchaseModel = SCPurchaseModel();
                    }
                  }
                  SCEntryTypeModel subModel =
                      widget.state.typeList[selectIndex];
                  widget.state.typeIndex = selectIndex;
                  widget.state.type = model.name ?? '';
                  widget.state.typeID = subModel.code ?? 0;
                  if (widget.state.type == '归还入库' || widget.state.type == '采购入库') {
                    getBaseInfoList();
                  }
                } else if (index == 2) {
                  // 物资类型
                  widget.state.materialTypeIndex = selectIndex;
                  widget.state.materialTypeName = widget.state.materialTypeList[selectIndex] ?? '';
                  widget.state.materialType = selectIndex + 1;
                }
                if (widget.state.type == '归还入库' && widget.state.materialType == 1) {
                  widget.state.isProperty = true;
                } else {
                  widget.state.isProperty = false;
                }
              });
            },
          ));
    });
  }


  /// 入库时间弹窗
  showTimeAlert(BuildContext context) {
    DateTime now = DateTime.now();
    SCPickerUtils pickerUtils = SCPickerUtils();
    pickerUtils.title = '入库时间';
    pickerUtils.cancelText = '取消';
    pickerUtils.pickerType = SCPickerType.date;
    pickerUtils.completionHandler = (selectedValues, selecteds) {
      DateTime value = selectedValues.first;
      setState(() {
        widget.state.inDate = formatDate(value, [yyyy, '-', mm, '-', dd]);
      });
    };
    pickerUtils.showDatePicker(
        context: context,
        dateType: PickerDateTimeType.kYMD,
        minValue: DateTime(now.year - 1, 1, 1, 00, 00),
        maxValue: DateTime(now.year + 1, 12, 31, 23, 59));
  }

  /// 获取基础信息
  List getBaseInfoList() {
    /// 基础信息数组
    List baseInfoList = [
      {
        'isRequired': true,
        'title': '仓库名称',
        'content': widget.state.wareHouseName,
        'disable' : widget.state.isEdit
      },
      {
        'isRequired': true,
        'title': '入库类型',
        'content': widget.state.type,
        'disable' : widget.state.isEdit
      },
    ];
    if (widget.state.type == '归还入库') {
      baseInfoList.add({
        'isRequired': true,
        'title': '物资类型',
        'content': widget.state.materialTypeName,
        'disable' : widget.state.isEdit
      });
    } else if (widget.state.type == '采购入库') {
      baseInfoList.add({
        'isRequired': true,
        'title': '采购需求单',
        'content': widget.state.purchaseModel.purchaseCode ?? '',
        'disable' : widget.state.isEdit
      });
    }
    baseInfoList.add({
      'isRequired': true,
      'title': '入库日期',
      'content': widget.state.inDate,
      'disable' : widget.state.isEdit
    });
    if (widget.state.isReturnEntry == true) {
      baseInfoList = [
        {
          'isRequired': true,
          'title': '仓库名称',
          'content': widget.state.wareHouseName,
          'disable' : true
        },
        {
          'isRequired': true,
          'title': '入库类型',
          'content': widget.state.type,
          'disable' : true
        },
      ];
    }
    return baseInfoList;
  }

  /// 添加物资
  addAction() async {
    if (widget.state.type == '采购入库') {
      if (widget.state.purchaseId.isEmpty) {
        SCToast.showTip(SCDefaultValue.selectPurchaseIdTip);
        return;
      }
      addPurchaseMaterialAction();
    } else if (widget.state.type == '归还入库') {
      if (widget.state.materialTypeName.isEmpty) {
        SCToast.showTip(SCDefaultValue.selectMaterialTypeTip);
        return;
      }
      if (widget.state.isProperty == true || widget.state.materialType == 1) {
        if (widget.state.isEdit) {
          addExitsPropertyAction();
        } else {
          addPropertyAction();
        }
      } else {
        if (widget.state.isEdit) {
          addExitsMaterialAction();
        } else {
          addMaterialAction();
        }
      }
    } else {
      if (widget.state.isEdit) {
        addExitsMaterialAction();
      } else {
        addMaterialAction();
      }
    }
  }

  /// 新增物资-采购单物资
  addPurchaseMaterialAction() async{
    var params = await SCRouterHelper.pathPage(SCRouterPath.purchaseSelectMaterialPage, {
      "allMaterialList" : List.from(widget.state.purchaseMaterialList),
      "selectMaterialList" : List.from(widget.state.selectedList)
    });
    if (params is Map) {
      List<SCMaterialListModel> list = params['materialList'];
      widget.state.updateSelectedMaterial(list);
    }
  }

  /// 新增物资-添加物资
  addMaterialAction() async {
    var list = await SCRouterHelper.pathPage(SCRouterPath.addMaterialPage, {
      'data': widget.state.selectedList,
      'wareHouseId': widget.state.wareHouseId,
      "materialType" : SCWarehouseManageType.entry
    });
    if (list != null) {
      onlyAddMaterial(list);
    }
  }

  /// 新增资产-添加资产
  addPropertyAction() async {
    var list = await SCRouterHelper.pathPage(SCRouterPath.addMaterialPage, {
      'propertyData': widget.state.selectedList,
      'wareHouseId': widget.state.wareHouseId,
      "materialType" : SCWarehouseManageType.entry,
      'isProperty': true
    });
    if (list != null) {
      onlyAddProperty(list);
    }
  }

  /// 编辑物资-添加既存物资
  addExitsMaterialAction() async {
    var list = await SCRouterHelper.pathPage(SCRouterPath.addMaterialPage, {
      'data': widget.state.selectedList,
      'wareHouseId': widget.state.wareHouseId,
      'isEdit': true,
      "materialType" : SCWarehouseManageType.entry
    });
    if (list != null) {
      editAddMaterial(list);
    }
  }

  /// 编辑资产-添加既存资产
  addExitsPropertyAction() async {
    log("ccc===${widget.state.selectedList}");
    var list = await SCRouterHelper.pathPage(SCRouterPath.addMaterialPage, {
      'propertyData': widget.state.selectedList,
      'wareHouseId': widget.state.wareHouseId,
      'isEdit': true,
      "materialType" : SCWarehouseManageType.entry,
      'isProperty': true
    });
    if (list != null) {
      editAddProperty(list);
    }
  }

  /// 删除物资
  deleteAction(int index) {
    if (widget.state.isProperty == true) {
      if (widget.state.isEdit) {
        SCMaterialListModel model = widget.state.selectedList[index];
        widget.state.editDeleteProperty(materialInRelationId: model.id ?? '');
      } else {
        widget.state.deleteProperty(index);
      }
    } else {
      if (widget.state.isEdit) {
        SCMaterialListModel model = widget.state.selectedList[index];
        widget.state.editDeleteMaterial(materialInRelationId: model.id ?? '');
      } else {
        widget.state.deleteMaterial(index);
      }
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

    if (widget.state.typeID == 1 && widget.state.purchaseId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectPurchaseIdTip);
      return;
    }

    if (widget.state.typeID == 4 && widget.state.materialType < 0) {
      SCToast.showTip(SCDefaultValue.selectMaterialTypeTip);
      return;
    }

    if (widget.state.inDate.isEmpty) {
      SCToast.showTip(SCDefaultValue.addInDateTip);
      return;
    }

    if (widget.state.isProperty == true && widget.state.selectedList.isEmpty) {
      SCToast.showTip(SCDefaultValue.addPropertyInfoTip);
      return;
    }

    if (widget.state.isProperty == false && widget.state.selectedList.isEmpty) {
      SCToast.showTip(SCDefaultValue.addMaterialInfoTip);
      return;
    }

    List materialList = [];
    if (widget.state.isReturnEntry == true) {//归还入库
      for (SCMaterialListModel model in widget.state.selectedList) {
        var params = model.toJson();
        params['backNum'] = model.localNum;
        if (model.returnCheck == 0) {//无需归还
          params['backNum'] = 0;//归还数量设置为0
        }
        materialList.add(params);
      }
    } else {
      for (SCMaterialListModel model in widget.state.selectedList) {
        var params = model.toJson();
        params['num'] = model.localNum;
        params['materialId'] = model.id;
        params['materialName'] = model.name;
        materialList.add(params);
      }
    }
    var params = {
      "wareHouseName": widget.state.wareHouseName,
      "wareHouseId": widget.state.wareHouseId,
      "typeName": widget.state.type,
      "typeId": widget.state.typeID,
      "remark": widget.state.remark,
      "materialList": materialList,
      "files": widget.state.files,
      "inDate": widget.state.inDate,
      "purchaseId": widget.state.purchaseId,
      "materialType": widget.state.materialType,
    };
    widget.state.addEntry(status: status, data: params);
  }

  /// 编辑
  editAction() {
    if (widget.state.wareHouseId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectWareHouseNameTip);
      return;
    }

    if (widget.state.typeID <= 0) {
      SCToast.showTip(SCDefaultValue.selectWareHouseTypeTip);
      return;
    }

    if (widget.state.typeID == 1 && widget.state.purchaseId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectPurchaseIdTip);
      return;
    }

    if (widget.state.typeID == 4 && widget.state.materialType < 0) {
      SCToast.showTip(SCDefaultValue.selectMaterialTypeTip);
      return;
    }

    if (widget.state.inDate.isEmpty) {
      SCToast.showTip(SCDefaultValue.addInDateTip);
      return;
    }

    if (widget.state.isProperty == true && widget.state.selectedList.isEmpty) {
      SCToast.showTip(SCDefaultValue.addPropertyInfoTip);
      return;
    }

    if (widget.state.isProperty == false && widget.state.selectedList.isEmpty) {
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

    List propertyList = [];
    for (SCMaterialListModel model in widget.state.selectedList) {
      var params = model.toJson();
      propertyList.add(params);
    }

    var params = {
      "id": widget.state.editId,
      "wareHouseName": widget.state.wareHouseName,
      "wareHouseId": widget.state.wareHouseId,
      "typeName": widget.state.type,
      "typeId": widget.state.typeID,
      "remark": widget.state.remark,
      "materialList": materialList,
      "inDate": widget.state.inDate,
      "assets": propertyList,
      "purchaseId": widget.state.purchaseId,
      "materialType": widget.state.materialType,
    };
    widget.state.editMaterialBaseInfo(data: params);
  }

  /// 新增物资-添加
  onlyAddMaterial(List<SCMaterialListModel> list) {
    widget.state.updateSelectedMaterial(list);
  }

  /// 新增资产-添加
  onlyAddProperty(List<SCMaterialListModel> list) {
    widget.state.updateSelectedProperty(list);
  }

  /// 新增物资-编辑
  editAddMaterial(List<SCMaterialListModel> list) {
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
        if (model.id == subModel.materialId) {
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

    for (SCMaterialListModel model in editList) {}

    List<SCMaterialListModel> newList = widget.state.selectedList;
    List addJsonList = [];
    for (SCMaterialListModel model in addList) {
      model.inId = widget.state.editId;
      model.materialId = model.id;
      model.materialName = model.name;
      newList.add(model);
      var subParams = model.toJson();
      subParams['materialId'] = model.id;
      subParams['materialName'] = model.name;
      subParams['num'] = model.localNum;
      subParams['inId'] = widget.state.editId;
      addJsonList.add(subParams);
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
    List<SCMaterialListModel> list = [widget.state.selectedList[index]];
    widget.state.editMaterial(list: list);
  }

  /// 新增资产-编辑
  editAddProperty(List<SCMaterialListModel> list) {
    print("编辑-----------原始数据===${widget.state.selectedList}");

    // 新增的物资
    List<SCMaterialListModel> addList = [];
    for (SCMaterialListModel model in list) {
      print("编辑---------新增资产添加===${model.toJson()}");
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
      addJsonList.add(subParams);
      print("新增的物资===${subParams}");
    }

    if (addList.isNotEmpty) {
      widget.state.editAddProperty(list: addJsonList);
    }

    widget.state.updateSelectedProperty(newList);
  }

  /// 采购需求单
  purchaseSearch() async{
    var params = await SCRouterHelper.pathPage(SCRouterPath.purchaseSearchPage, null);
    if (params is Map) {
      widget.state.purchaseModel = params['model'];
      widget.state.purchaseId = widget.state.purchaseModel.id ?? '';
      widget.state.purchaseMaterialList = List.from(params['materialList']);
      widget.state.updateSelectedMaterial(List.from(params['materialList']));
    }
  }
}
