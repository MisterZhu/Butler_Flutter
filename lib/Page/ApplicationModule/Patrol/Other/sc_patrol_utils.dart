import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/Date/sc_date_utils.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/sc_utils.dart';
import '../../MaterialEntry/View/Alert/sc_reject_alert.dart';
import '../../WarningCenter/Model/sc_warning_dealresult_model.dart';
import '../Model/sc_task_node_model.dart';

/// 巡查工具类

class SCPatrolUtils {

  /// 编号
  String procInstId = "";

  /// 任务ID
  String taskId = "";

  /// nodeID
  String nodeId = "";

  /// 节点数组
  List nodeList = [];

  /// 节点名称数组
  List nodeNameList = [];

  /// 任务操作
  taskAction({required String name, bool? isDetailPage}) async {
    print('任务操作========$name');
    if (name == '添加日志') {
      addLog();
    } else if (name == '回退') {
      // 先请求回退节点接口
      getNodeData(result: (value) {
        if (value == true) {
          rollBack(isDetailPage: isDetailPage);
        }
      });
    } else if (name == '关闭') {
      close(isDetailPage: isDetailPage);
    } else if (name == '处理') {
      deal(isDetailPage: isDetailPage);
    } else if (name == '转派') {
      var data = await SCRouterHelper.pathPage(SCRouterPath.patrolTransferPage, null);
      if (data != null) {
        print("转派人===$data");
        if (data.containsKey("userId")) {
          String userId = data['userId'];
          transfer(userId: userId, isDetailPage: isDetailPage);
        }
      }
    } else if (name == '接收') {
      accept(isDetailPage: isDetailPage);
    } else if (name == '拒绝') {
      refuse(isDetailPage: isDetailPage);
    } else if(name == '抢单'){
      showDialogTip(isDetailPage: isDetailPage);
    }
  }

  showDialogTip({bool? isDetailPage}){
    if(isDetailPage == true){
      toGetOrder(isDetailPage: isDetailPage);
    }else{
      SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
        SCDialogUtils.instance.showMiddleDialog(
          context: context,
          content: "确认领取该任务？",
          customWidgetButtons: [
            defaultCustomButton(context,
                text: '取消',
                textColor: SCColors.color_1B1C33,
                fontWeight: FontWeight.w400),
            defaultCustomButton(context,
                text: '确定',
                textColor: SCColors.color_1B1C33,
                fontWeight: FontWeight.w400, onTap: () {
                  toGetOrder(isDetailPage: isDetailPage);
                }),
          ],
        );
      });
    }
  }


  //抢单处理
  toGetOrder({bool? isDetailPage}){
    SCLoadingUtils.show();
    var params = {
      "action": "accept",
      "instanceId": nodeId,
      "taskId": taskId
    };
    SCHttpManager.instance.post(
        url: SCUrl.kPatrolGetOrder,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          if(isDetailPage == true){
            SCToast.showTip("抢单成功").then((value){
              SCScaffoldManager.instance.eventBus.fire({'key': SCKey.kRefreshPatrolDetailPage});
            });
          }else{
            SCToast.showTip("抢单成功，请前往”我待办的“处理任务").then((value){
              SCScaffoldManager.instance.eventBus.fire({'key': SCKey.kRefreshPatrolPage});
            });
          }
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 接收
  accept({bool? isDetailPage}) {
    dealTask(action: "accept", result: (result) {
      if (result == true) {
        SCToast.showTip('接收成功').then((status) {
          SCScaffoldManager.instance.eventBus.fire({'key': SCKey.kRefreshPatrolPage});
          SCScaffoldManager.instance.eventBus.fire({'key': SCKey.kRefreshPatrolDetailPage});
        });
      }
    });
  }

  /// 拒绝
  refuse({bool? isDetailPage}) {
    dealTask(action: "notAccept", result: (result) {
      if (result == true) {
        SCToast.showTip('拒绝成功').then((status) {
          SCScaffoldManager.instance.eventBus.fire({'key': SCKey.kRefreshPatrolPage});
          SCScaffoldManager.instance.eventBus.fire({'key': SCKey.kRefreshPatrolDetailPage});
        });
      }
    });
  }


  /// 任务关闭
  close({bool? isDetailPage}) {
    dealTask(action: "close", result: (result) {
      if (result == true) {
        SCToast.showTip('关闭成功').then((status) {
          SCScaffoldManager.instance.eventBus.fire({'key': SCKey.kRefreshPatrolPage});
          if (isDetailPage == true) {
            SCRouterHelper.back(null);
          }
        });
      }
    });
  }

  /// 转派
  transfer({required String userId, bool? isDetailPage}) {
    dealTask(action: "transfer", targetUser: userId, result: (result) {
      if (result == true) {
        SCToast.showTip('转派成功').then((status) {
          SCScaffoldManager.instance.eventBus.fire({'key': SCKey.kRefreshPatrolDetailPage});
        });
      }
    });
  }

  /// 回退操作
  rollBack({bool? isDetailPage}) {
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCRejectAlert(
              title: '任务退回',
              resultDes: '退回节点',
              reasonDes: '退回理由',
              isRequired: true,
              tagList: nodeNameList,
              hiddenTags: true,
              showNode: true,
              sureAction: (int index, String value, List imageList) {
                SCTaskNodeModel nodeModel = nodeList[index];
                dealTask(action: "recall", targetNode: nodeModel.nodeId, content: value, imageList: imageList, result: (result) {
                  if (result == true) {
                    SCToast.showTip('任务退回成功').then((status) {
                      SCScaffoldManager.instance.eventBus.fire({'key': SCKey.kRefreshPatrolDetailPage});
                    });
                  }
                });
              }));
    });
  }

  /// 获取退回节点数据
  getNodeData({Function(bool value)? result}) {
    SCHttpManager.instance.get(
        url: SCUrl.kTaskRecallNodeUrl,
        params: {"instanceId": procInstId, "taskId": taskId},
        success: (value) {
          print('获取退回节点数据======$value');
          SCLoadingUtils.hide();
          nodeList = List<SCTaskNodeModel>.from(value.map((e) => SCTaskNodeModel.fromJson(e)).toList());
          nodeNameList = nodeList.map((e) => e.nodeName).toList();
          result?.call(true);
        },
        failure: (value) {
          result?.call(false);
          SCToast.showTip(value['message']);
        });
  }

  /// 添加日志操作
  addLog() {
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCRejectAlert(
              title: '添加日志',
              resultDes: '',
              reasonDes: '日志内容',
              isRequired: true,
              tagList: const [],
              hiddenTags: true,
              showNode: false,
              sureAction: (int index, String value, List imageList) {
                dealTask(action: "comment", content: value, imageList: imageList, result: (result) {
                  if (result == true) {
                    SCToast.showTip('添加日志成功');
                  }
                });
              }));
    });
  }

  /// 处理操作
  deal({bool? isDetailPage}) {
    // 先判断要不要扫码，再处理任务
    needScan(result: (result) async {
      if (result == true) {
        // 扫码
        var data = await SCRouterHelper.pathPage(SCRouterPath.scanPath, null);
        print("扫码结果444===$data========");
        if (data != null && data != '') {// 有扫描结果
          // 校验二维码是否正确
          checkQrcode(qrCode: data, result: (status) {
            if (status == true) {
              showDealAlert(code: data, isDetailPage: isDetailPage);
            } else {
              SCToast.showTip('二维码校验不通过，请重新扫描');
            }
          });
        }
      } else {
        showDealAlert(isDetailPage: isDetailPage);
      }
    });
  }

  /// 是否需要扫码
  needScan({Function(bool value)? result}) {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kNeedScanUrl,
        params: {"procInstId": procInstId, "nodeId": nodeId},
        success: (value) {
          SCLoadingUtils.hide();
          print('是否需要扫码======$value');
          if (value is Map && value.containsKey('isScanCode')) {
            result?.call(value['isScanCode']);
          }else{
            result?.call(false);
          }
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 显示处理弹窗
  showDealAlert({String? code, bool? isDetailPage}) {
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCRejectAlert(
            title: '处理',
            resultDes: '',
            reasonDes: '处理说明',
            isRequired: false,
            tagList: [],
            hiddenTags: true,
            showNode: false,
            sureAction: (int index, String value, List imageList) {
              dealTask(action: "handle", code: code, content: value, imageList: imageList, result: (result) {
                SCToast.showTip('处理成功').then((status) {
                  SCScaffoldManager.instance.eventBus.fire({'key': SCKey.kRefreshPatrolPage});
                  SCScaffoldManager.instance.eventBus.fire({'key': SCKey.kRefreshWorkBenchPage});

                  if(isDetailPage==true){
                    SCRouterHelper.back(null);
                  }
                });
              });
            },
          ));
    });
  }

  /// 处理结果数据字典
  loadDictionaryCode(
      String code, Function(bool success, List list)? completeHandler) {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kConfigDictionaryPidCodeUrl,
        params: {'dictionaryCode': 'ALERT_CONFIRM_RESULT', 'code': code},
        success: (value) {
          SCLoadingUtils.hide();
          List<SCWarningDealResultModel> list =
              List<SCWarningDealResultModel>.from(value
                  .map((e) => SCWarningDealResultModel.fromJson(e))
                  .toList());
          for (SCWarningDealResultModel model in list) {
            if (model.code == code) {
              completeHandler?.call(true, model.pdictionary ?? []);
              break;
            }
          }
        },
        failure: (value) {
          completeHandler?.call(false, []);
          SCToast.showTip(value['message']);
        });
  }

  /// 校验二维码是否正确
  checkQrcode({required String qrCode, Function(bool value)? result}) {
    var params = {
      "procInstId": procInstId,
      "taskId": taskId,
      "nodeId": nodeId,
      "qrCode": qrCode
    };
    SCHttpManager.instance.post(
        url: SCUrl.kCheckCodeUrl,
        params: params,
        success: (value) {
          print('校验二维码是否正确=========$value=');
          result?.call(value == '成功' ? true : false);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 处理任务
  /// action:操作类型
  /// mode：选择的节点
  /// content：内容
  /// imageList：图片
  /// code：二维码
  /// targetUser转派人
  /// targetNode退回节点
  dealTask(
      {required String action,
        String? node,
        String? content,
        List? imageList,
        String? code,
        String? targetUser,
        String? targetNode,
        Function(dynamic data)? result}) {
    var comment = {};
    if (action == "handle") {
      // 处理
      comment = {
        "attachments": transferImage(imageList ?? []),
        "text": content
      };
    } else if (action == "close") {
      // 关闭
      comment = {
        "attachments": transferImage(imageList ?? []),
        "text": content
      };
    } else if (action == "comment") {
      // 添加日志
      comment = {
        "attachments": transferImage(imageList ?? []),
        "text": content
      };
    } else if (action == "recall") {
      // 回退
      comment = {
        "attachments": transferImage(imageList ?? []),
        "text": content,
      };
    } else if (action == "accept") {
      // 接收
      comment = {
        "attachments": transferImage(imageList ?? []),
        "text": content,
      };
    } else if (action == "notAccept") {
      // 拒绝
      comment = {
        "attachments": transferImage(imageList ?? []),
        "text": content,
      };
    }
    var params = {
      "action": action,
      "comment": comment,
      "formData": {"field_code": code ?? ''},
      "instanceId": procInstId,
      "taskId": taskId,
      "targetUser": targetUser,
      "targetNode": targetNode
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kDealTaskUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          print('任务处理=========$value');
          result?.call(value);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 图片转换
  List transferImage(List imageList) {
    List list = [];
    for (var params in imageList) {
      var newParams = {
        "id": SCDateUtils.timestamp(),
        "isImage": true,
        "name": params['name'],
        "url": params['fileKey']
      };
      list.add(newParams);
    }
    return list;
  }

  /// 处理状态文本颜色
  static Color getStatusColor(int status) {
    if (status == 10) {// 待处理
      return SCColors.color_FF7F09;
    } else if (status == 20) {// 处理中
      return SCColors.color_4285F4;
    } else if (status == 30) {// 已处理
      return SCColors.color_1B1D33;
    } else if (status == 40) {// 已完成
      return SCColors.color_1B1D33;
    } else if (status == 41) {// 已取消
      return SCColors.color_B0B1B8;
    } else if (status == 42) {// 已关闭
      return SCColors.color_B0B1B8;
    } else if (status == 43) {// 已拒绝
      return SCColors.color_FF4040;
    } else {
      return SCColors.color_1B1D33;
    }
  }
}
