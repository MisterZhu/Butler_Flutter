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
  SCAddReceiptViewState createState() => SCAddReceiptViewState();
}

class SCAddReceiptViewState extends State<SCAddEntryView> {
  /// 基础信息数组
  List baseInfoList = [
    {'isRequired': true, 'title': '仓库名称', 'content': ''},
    {'isRequired': true, 'title': '类型', 'content': ''}
  ];

  /// 仓库名称
  String warehouseName = '';

  /// 仓库id
  String warehouseID = '';

  /// 仓库index
  int nameIndex = -1;

  /// 类型
  String type = '';

  /// 仓库类型id
  int typeID = 0;

  /// 类型index
  int typeIndex = -1;

  late StreamSubscription<bool> keyboardSubscription;

  /// 是否弹起键盘
  bool isShowKeyboard = false;

  /// 备注
  String remark = '';

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
            list: const ['暂存', '提交'],
            buttonType: 1,
            leftTapAction: () {
              /// 保存
              save();
            },
            rightTapAction: () {
              /// 提交
              submit();
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
        list: baseInfoList,
        selectAction: (index) {
          if (index == 0) {
            //仓库名称
            List list = widget.state.wareHouseList.map((e) => e.name).toList();
            showAlert(0, '仓库名称', list);
          } else if (index == 1) {
            //类型
            List list = widget.state.entryList.map((e) => e.name).toList();
            showAlert(1, '类型', list);
          }
        },
        inputAction: (content) {
          remark = content;
        },
        addPhotoAction: (list) {},
      );
    } else if (index == 1) {
      return SCMaterialInfoCell(
        list: widget.state.selectedList,
        addAction: () {
          addAction();
        },
        deleteAction: (int subIndex) {
          deleteAction(subIndex);
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
      currentIndex = nameIndex;
    } else if (index == 1) {
      // 类型
      currentIndex = typeIndex;
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
                baseInfoList[index]['content'] = model.name!;
                if (index == 0) {
                  //仓库名称
                  SCWareHouseModel subModel = widget.state.wareHouseList[selectIndex];
                  nameIndex = selectIndex;
                  warehouseName = model.name ?? '';
                  warehouseID = subModel.id ?? '';
                } else if (index == 1) {
                  //类型
                  SCEntryTypeModel subModel = widget.state.entryList[selectIndex];
                  typeIndex = selectIndex;
                  type = model.name ?? '';
                  typeID =  subModel.code ?? 0;
                }
              });
            },
          ));
    });
  }

  /// 添加物资
  addAction() async {
    var list = await SCRouterHelper.pathPage(
        SCRouterPath.addMaterialPage, {'data': widget.state.selectedList});
    widget.state.updateSelectedMaterial(list);
  }

  /// 删除物资
  deleteAction(int index) {
    widget.state.deleteMaterial(index);
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
    if (warehouseID.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectWareHouseNameTip);
      return;
    }

    if (typeID <= 0) {
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
      "wareHouseName" : warehouseName,
      "wareHouseId" : warehouseID,
      "typeName" : type,
      "typeId" : typeID,
      "remark" : remark,
      "materialList" : materialList
    };
    print("数据===${jsonEncode(params)}");
    widget.state.addEntry(status: status, data: params);
  }
}
