import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../Constants/sc_h5.dart';
import '../../../Network/sc_config.dart';
import '../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../Utils/Router/sc_router_helper.dart';
import '../../../Utils/Router/sc_router_path.dart';
import '../../../Utils/sc_utils.dart';
import '../Controller/sc_handle_message_controller.dart';
import '../Controller/sc_message_controller.dart';
import '../Model/sc_handle_message_card_model.dart';
import '../Model/sc_message_card_model.dart';
import '../View/sc_message_listview.dart';
import '../View/sc_message_top_dialog.dart';
import '../View/sc_message_top_item.dart';

/// 消息page

class SCHandleMessagePage extends StatefulWidget {
  @override
  State<SCHandleMessagePage> createState() => _SCHandleMessagePage();
}

class _SCHandleMessagePage extends State<SCHandleMessagePage> {
  late SCHandleMessageController controller;

  String controllerTag = '';
  dynamic model;
  String taskTime='';
  String taskContent='';
  String taskCode='';
  SCHandleMessageCardModel? taskDetail;

  @override
  initState() {
    super.initState();
    var args = Get.arguments;
    SCMessageCardModel model = args['model'];
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCHandleMessagePage).toString());
    controller = Get.put(SCHandleMessageController(), tag: controllerTag);
    // controller.initParams(Get.arguments);
    handleGetDetail(model);
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag(
        (SCHandleMessagePage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "消息",
        centerTitle: true,
        navBackgroundColor: SCColors.color_FFFFFF,
        elevation: 0,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(10),
            color: SCColors.color_F2F3F5,
            child: body()));
  }

  /// body
  Widget body() {
    return GetBuilder<SCHandleMessageController>(
      tag: controllerTag,
      init: controller,
      builder: (state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title(),
            time(),
            contextItem(),
          ],
        );
      },
    );
  }

  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('待办通知',
            style: const TextStyle(
              fontSize: SCFonts.f30,
              fontWeight: FontWeight.w800,
            ))
      ],
    );
  }

  Widget time() {
    return Text(taskTime.toString(),
        style: TextStyle(
          fontSize: SCFonts.f15,
          fontWeight: FontWeight.w400,
        ));
  }

  Widget contextItem() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
      child:  taskCode.isEmpty
          ? null
          : RichText(
              text: TextSpan(
                text:'${taskContent}编号:',
                style: const TextStyle(
                  fontSize: SCFonts.f18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black, // 设置默认文本颜色
                ),
                children: [
                  TextSpan(
                    text: '$taskCode',
                    style: const TextStyle(
                      color: Colors.blue, // 设置点击文本的颜色
                      decoration: TextDecoration.underline, // 添加下划线效果
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        handleGoDetail(taskDetail!);
                      },
                  ),
                ],
              ),
            ),
    );
  }

  ///
  handleGetDetail(dynamic model) {
    // taskDetail
    var url = SCUrl.kMessageDetailUrl;
    SCHttpManager.instance.get(
        url: url,
        params: {"noticeArriveId": model?.noticeArriveId ?? ''},
        success: (res) {
          setState(() {
            taskDetail = SCHandleMessageCardModel.fromJson(res);
            taskContent = taskDetail?.content.toString() ??'';
            taskTime = taskDetail?.noticeTime??'';
            taskCode = taskDetail?.taskMsg?.serialNumber??'';
            print(15132132);
          });
        },
        failure: (err) {});
  }

  /// 跳转工单H5详情
  handleGoDetail(SCHandleMessageCardModel taskDetail) {
    print('======>工单详情跳转¥${taskDetail?.taskMsg?.taskId}');
    if (taskDetail?.taskMsg?.type == 'WORK_ORDER') {
      var url =
          '${SCH5.workOrderDetailUrl}?source=my&orderId=${taskDetail.taskMsg?.taskId}';
      SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
        "title": '工单详情',
        "url": SCUtils.getWebViewUrl(
            url: SCConfig.getH5Url(url), title: '工单详情', needJointParams: true)
      });
    }
  }
}
