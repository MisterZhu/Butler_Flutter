
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../../WorkBench/Home/Model/sc_todo_model.dart';
import '../../../../WorkBench/Other/sc_todo_utils.dart';
import '../../Controller/sc_task_front_controller.dart';
import '../../Controller/sc_task_log_controller.dart';
import '../../Page/sc_task_log_page.dart';
import '../Patrol/sc_task_log_view.dart';

/// page

class SCTaskFrontPageView extends StatefulWidget {

  final String bizId;

  const SCTaskFrontPageView({super.key, required this.bizId});
  @override
  SCTaskFrontPageViewState createState() => SCTaskFrontPageViewState();
}

class SCTaskFrontPageViewState extends State<SCTaskFrontPageView> {

  /// SCTaskLogController
  late SCTaskFrontController controller;

  /// SCWarningCenterController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCTaskFrontPageView).toString());
    controller = Get.put(SCTaskFrontController(), tag: controllerTag);
    controller.initParams({
      'bizId': widget.bizId
    });
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag(pageName(), controllerTag);
    //controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return GetBuilder<SCTaskFrontController>(
        tag: controllerTag,
        init: controller,
        builder: (state) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.all(16),
            color: SCColors.color_F2F3F5,
            child: ListView.separated(
              // padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0, bottom: 12.0),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return getSCToDoModelCell(SCToDoModel.fromJson(controller.dataList[index]));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return line(index);
                },
                itemCount: controller.dataList.length),
          );
        });
  }

  /// line
  Widget line(int index) {
    return const SizedBox(
      height: 10.0,
    );
  }

  Widget getSCToDoModelCell(SCToDoModel model) {
    bool hideAddressRow = true;
    var cardStyle = SCToDoUtils().getCardStyle(model);
    // title
    String title = model.subTypeDesc ?? '';
    // content
    String content = '${model.title ?? ''}\n${model.content ?? ''}';
    // 按钮文字
    String btnTitle = cardStyle['btnTitle'];
    // 处理状态文字
    String statusTitle = cardStyle['statusTitle'];
    // 处理状态文字颜色
    Color statusColor = cardStyle['statusColor'];
    // 是否显示倒计时
    bool isShowTimer = cardStyle['isShowTimer'];
    // 剩余时间
    int remainingTime = cardStyle['remainingTime'];
    // 创建时间
    String createTime = cardStyle['createTime'];
    // 地址
    String address = model.contactAddress ?? '';
    // 联系人
    String userName = model.contact ?? '';
    // 手机号
    String phone = model.contactInform ?? '';
    return SCTaskCardCell(
      title: title,
      statusTitle: statusTitle,
      statusTitleColor: statusColor,
      content: content,
      tagList: const [],
      address: address,
      contactUserName: userName,
      remainingTime: remainingTime,
      time: createTime,
      timeType: isShowTimer ? 1 : 0,
      btnText: btnTitle,
      hideBtn: btnTitle.isEmpty,
      hideAddressRow: hideAddressRow,
      btnTapAction: () {//卡片button点击
        SCToDoUtils().dealAction(model, btnTitle);
      },
      detailTapAction: () {//整个卡片的点击
        SCToDoUtils().detail(model);
      },
      callAction: () {
        SCUtils.call(phone);
      },
    );
  }

  /// pageName
  String pageName() {
    return (SCTaskFrontPageView).toString();
  }

}
