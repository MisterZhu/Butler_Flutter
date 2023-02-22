import 'dart:async';
import 'package:flutter/cupertino.dart';
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
import '../../../MaterialEntry/Model/sc_entry_type_model.dart';
import '../../../MaterialEntry/Model/sc_wareHouse_model.dart';
import '../../Controller/sc_add_check_controller.dart';


/// 新增调拨view

class SCAddCheckView extends StatefulWidget {
  /// SCAddCheckController
  final SCAddCheckController state;

  SCAddCheckView({Key? key, required this.state,}) : super(key: key);

  @override
  SCAddCheckViewState createState() => SCAddCheckViewState();
}

class SCAddCheckViewState extends State<SCAddCheckView> {

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
        SCBottomButtonItem(
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
        selectAction: (index) async {
          if (index == 0) {
            // 任务名称
            List list = widget.state.wareHouseList.map((e) => e.name).toList();
            showAlert(0, '任务名称', list);
          } else if (index == 1) {
            // 类型
            List list = widget.state.typeList.map((e) => e.name).toList();
            showAlert(1, '类型', list);
          } else if (index == 2) {
            // 仓库名称
            List list = widget.state.wareHouseList.map((e) => e.name).toList();
            showAlert(2, '仓库名称', list);
          }
        },
      );
    } else if (index == 1) {
      return SCMaterialInfoCell(
        showAdd: widget.state.isEdit ? false : true,
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
      // 任务名称
      currentIndex = widget.state.taskIndex;
    } else if (index == 1) {
      // 类型
      currentIndex = widget.state.typeIndex;
    } else if (index == 2) {
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
                if (index == 0) {
                  // 任务名称
                  SCWareHouseModel subModel = widget.state.wareHouseList[selectIndex];
                  widget.state.taskIndex = selectIndex;
                  widget.state.taskName = model.name ?? '';
                  widget.state.taskId = subModel.id ?? '';
                } else if (index == 1) {
                  // 类型
                  SCEntryTypeModel subModel = widget.state.typeList[selectIndex];
                  widget.state.typeIndex = selectIndex;
                  widget.state.type = model.name ?? '';
                  widget.state.typeID = subModel.code ?? 0;
                } else if (index == 2) {
                  // 仓库名称
                  SCWareHouseModel subModel = widget.state.wareHouseList[selectIndex];
                  widget.state.nameIndex = selectIndex;
                  widget.state.wareHouseName = model.name ?? '';
                  widget.state.wareHouseId = subModel.id ?? '';
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
      {'isRequired': true,'title': '任务名称','content': widget.state.taskName},
      {'isRequired': true, 'title': '类型', 'content': widget.state.type},
      {'isRequired': true,'title': '仓库名称','content': widget.state.wareHouseName},
    ];
    return baseInfoList;
  }

  /// 添加物资
  addAction() async {
    if (widget.state.wareHouseId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectWareHouseNameTip);
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
    if (widget.state.taskId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectTaskName);
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
      "wareHouseName" : widget.state.wareHouseName,
      "wareHouseId" : widget.state.wareHouseId,
      "taskName" : widget.state.taskName,
      "taskId" : widget.state.taskId,
      "typeName" : widget.state.type,
      "typeId" : widget.state.typeID,
      "materialList" : materialList
    };
    widget.state.addTransfer(status: status, data: params);
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
    if (widget.state.taskId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectTaskName);
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

    var params = {
      "wareHouseName" : widget.state.wareHouseName,
      "wareHouseId" : widget.state.wareHouseId,
      "taskName" : widget.state.taskName,
      "taskId" : widget.state.taskId,
      "typeName" : widget.state.type,
      "typeId" : widget.state.typeID,
      "id" : widget.state.editId
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
