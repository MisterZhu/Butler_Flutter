import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/AddEntry/sc_basic_info_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/AddEntry/sc_material_info_cell.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../../WorkBench/Home/Model/sc_home_task_model.dart';
import '../../../../WorkBench/Home/View/Alert/sc_task_module_alert.dart';
import '../../../HouseInspect/View/sc_bottom_button_item.dart';
import '../../Controller/sc_add_entry_controller.dart';

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
    {'isRequired': true, 'title': '类型', 'content': ''}];

  /// 仓库名称
  String warehouseName = '';

  /// 仓库index
  int nameIndex = -1;

  /// 类型
  String type = '';

  /// 类型index
  int typeIndex = -1;

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
      }, inputAction: (content) {

      }, addPhotoAction: (list) {

      },);
    } else if (index == 1) {
      return SCMaterialInfoCell(
        addAction: () {
          SCRouterHelper.pathPage(SCRouterPath.addMaterialPage, null);
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
  submit() {}
}
