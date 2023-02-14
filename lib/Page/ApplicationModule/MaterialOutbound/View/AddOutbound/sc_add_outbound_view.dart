
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../../WorkBench/Home/Model/sc_home_task_model.dart';
import '../../../../WorkBench/Home/View/Alert/sc_task_module_alert.dart';
import '../../../HouseInspect/View/sc_bottom_button_item.dart';
import '../../../MaterialEntry/View/AddEntry/sc_basic_info_cell.dart';
import '../../../MaterialEntry/View/AddEntry/sc_material_info_cell.dart';
import '../../Controller/sc_add_outbound_controller.dart';

/// 新增出库view

class SCAddOutboundView extends StatefulWidget {

  /// SCAddOutboundController
  final SCAddOutboundController state;

  SCAddOutboundView({Key? key, required this.state}) : super(key: key);

  @override
  SCAddOutboundViewState createState() => SCAddOutboundViewState();
}

class SCAddOutboundViewState extends State<SCAddOutboundView> {

  /// 基础信息数组
  List baseInfoList = [{'isRequired': true, 'title': '仓库名称', 'content': ''},
    {'isRequired': true, 'title': '类型', 'content': ''},
    {'isRequired': false, 'title': '领用部门', 'content': ''},
    {'isRequired': false, 'title': '领用人', 'content': ''},
  ];

  /// 仓库名称
  String warehouseName = '';
  /// 仓库index
  int nameIndex = -1;

  /// 类型
  String type = '';

  /// 类型index
  int typeIndex = -1;

  /// 领用部门
  String department = '';
  /// 领用人
  String receiver = '';

  /// 领用人index
  int receiverIndex = -1;

  late StreamSubscription<bool> keyboardSubscription;

  /// 是否弹起键盘
  bool isShowKeyboard = false;

  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();
    isShowKeyboard = keyboardVisibilityController.isVisible;
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
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
        SCBottomButtonItem(list: const ['暂存', '提交'], buttonType: 1, leftTapAction: () {
          /// 保存
          save();
        }, rightTapAction: () {
          /// 提交
        },),
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
        selectAction: (index) async {
          if (index == 0) {
            //仓库名称
            List list = widget.state.wareHouseList.map((e) => e.name).toList();
            showAlert(0, '仓库名称', list);
          } else if (index == 1) {
            //类型
            List list = widget.state.outboundList.map((e) => e.name).toList();
            showAlert(1, '类型', list);
          } else if (index == 2) {
            //领用部门

          } else if (index == 3) {
            //领用人
            var params = {
              'receiver': receiver,
              'receiverIndex': receiverIndex
            };
            var backParams = await SCRouterHelper.pathPage(SCRouterPath.selectReceiverPage, params);
            setState(() {
              receiver = backParams['receiver'] ?? '';
              receiverIndex = backParams['receiverIndex'] ?? -1;
            });
          }
        }, inputAction: (content) {

        }, addPhotoAction: (list) {

        },);
    } else if (index == 1) {
      return SCMaterialInfoCell(
        list: [],
        addAction: () {
        SCRouterHelper.pathPage(SCRouterPath.addMaterialPage, null);
      },);
    } else {
      return const SizedBox(height: 10,);
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
    if (index == 0) {//仓库名称
      currentIndex = nameIndex;
    } else if (index == 1) {//类型
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
                if (index == 0) {//仓库名称
                  nameIndex = selectIndex;
                } else if (index == 1) {//类型
                  typeIndex = selectIndex;
                }
              });
            },
          ));
    });
  }

  /// 暂存
  save() {

  }

  /// 提交
  submit() {

  }
}
