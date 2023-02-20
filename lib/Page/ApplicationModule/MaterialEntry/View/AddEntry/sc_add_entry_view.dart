import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_list_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/AddEntry/sc_basic_info_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/AddEntry/sc_material_info_cell.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../../WorkBench/Home/Model/sc_home_task_model.dart';
import '../../../../WorkBench/Home/View/Alert/sc_task_module_alert.dart';
import '../../../HouseInspect/View/sc_bottom_button_item.dart';
import '../../Controller/sc_add_entry_controller.dart';
import '../../Model/sc_entry_type_model.dart';
import '../../Model/sc_wareHouse_model.dart';

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

  /// cell
  Widget getCell(int index) {
    if (index == 0) {
      return SCBasicInfoCell(// 基础信息
        list: getBaseInfoList(),
        remark: widget.state.remark,
        selectAction: (index) {
          if (index == 0) {
            // 仓库名称
            List list = widget.state.wareHouseList.map((e) => e.name).toList();
            showAlert(0, '仓库名称', list);
          } else if (index == 1) {
            // 类型
            List list = widget.state.typeList.map((e) => e.name).toList();
            showAlert(1, '类型', list);
          }
        },
        inputAction: (content) {
          widget.state.remark = content;
        },
        addPhotoAction: (list) {},
      );
    } else if (index == 1) {// 物资信息
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
          if (widget.state.isEdit) {
            widget.state.update();
            editOneMaterial(index);
          } else {
            widget.state.update();
          }
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
                  SCWareHouseModel subModel =
                      widget.state.wareHouseList[selectIndex];
                  widget.state.nameIndex = selectIndex;
                  widget.state.wareHouseName = model.name ?? '';
                  widget.state.wareHouseId = subModel.id ?? '';
                } else if (index == 1) {
                  // 类型
                  SCEntryTypeModel subModel =
                      widget.state.typeList[selectIndex];
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
      {
        'isRequired': true,
        'title': '仓库名称',
        'content': widget.state.wareHouseName
      },
      {'isRequired': true, 'title': '类型', 'content': widget.state.type}
    ];
    return baseInfoList;
  }

  /// 添加物资
  addAction() async {
    if (widget.state.wareHouseId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectWarehouseTip);
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
      'wareHouseId': widget.state.wareHouseId
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
      'isEdit': true,
    });
    if (list != null) {
      editAddMaterial(list);
    }
  }

  /// 删除物资
  deleteAction(int index) {
    if (widget.state.isEdit) {
      SCMaterialListModel model = widget.state.selectedList[index];
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
      "wareHouseName": widget.state.wareHouseName,
      "wareHouseId": widget.state.wareHouseId,
      "typeName": widget.state.type,
      "typeId": widget.state.typeID,
      "remark": widget.state.remark,
      "materialList": materialList
    };
    widget.state.addEntry(status: status, data: params);
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
      "id": widget.state.editId,
      "wareHouseName": widget.state.wareHouseName,
      "wareHouseId": widget.state.wareHouseId,
      "typeName": widget.state.type,
      "typeId": widget.state.typeID,
      "remark": widget.state.remark,
      "materialList": materialList
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

    for (SCMaterialListModel model in editList) {
      print("编辑的物资===${model.toJson()}");
    }

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
    List<SCMaterialListModel> list = [widget.state.selectedList[index]];
    widget.state.editMaterial(list: list);
  }
}
