import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/Strings/sc_string.dart';

import '../../../Constants/sc_default_value.dart';
import '../../../Constants/sc_h5.dart';
import '../../../Constants/sc_key.dart';
import '../../../Network/sc_config.dart';
import '../../../Network/sc_http_manager.dart';
import '../../../Network/sc_url.dart';
import '../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../Utils/Date/sc_date_utils.dart';
import '../../../Utils/Permission/sc_permission_utils.dart';
import '../../../Utils/Router/sc_router_helper.dart';
import '../../../Utils/Router/sc_router_path.dart';
import '../../../Utils/sc_utils.dart';
import '../../ApplicationModule/Patrol/Model/sc_patrol_detail_model.dart';
import '../../ApplicationModule/Patrol/Other/sc_patrol_utils.dart';
import '../Home/Model/sc_todo_model.dart';
import './meterReadingModule/meterReadingAlert.dart';

/// 点击待办处理
class SCToDoUtils {
  /// 点击卡片-详情
  detail(SCToDoModel model) {
    debugPrint("点击整个卡片");

    if (model.appName == "TASK") {
      /// 三巡一保
      if (model.type == "POLICED_POINT" || model.type == "POLICED_DEVICE") {
        /// 巡查
        patrolDetail(model);
      } else if (model.type == "POLICED_WATCH") {
        dealPatrolNewTask(model);
      } else if (model.type == "SAFE_PROD") {
        /// 安全生产
        SCToast.showTip(SCDefaultValue.developingTip);
      } else if (model.type == "QUALITY_REGULATION") {
        /// 品质督查
        debugPrint("点击品质督查");
        checkDetail(model);
      } else if (model.type == "RECTIFICATION") {
        /// 整改任务
        debugPrint("点击  整改任务");
        editDetail(model);
      } else if (model.type == "METER_READING") {
        /// 抄表任务
        handleMeterReadingTaskDetail(model);
      } else {
        /// 未知
        SCToast.showTip(SCDefaultValue.developingTip);
      }
    } else if (model.appName == "WORK_ORDER") {
      ///  工单
      workOrderDetail(model);
    } else {
      /// 未知
      SCToast.showTip(SCDefaultValue.developingTip);
    }
  }

  /// 点击卡片-处理
  dealAction(SCToDoModel model, String btnText) {
    debugPrint("点击卡片按钮${model.type}");

    if (model.appName == "TASK") {
      /// 三巡一保
      if (model.type == "POLICED_POINT" ||
          model.type == "POLICED_DEVICE" ||
          model.type == "POLICED_WATCH") {
        /// 巡查
        dealPatrolTask(model, btnText);
      } else if (model.type == "SAFE_PROD") {
        /// 安全生产
        dealPatrolTask(model, btnText);
      } else if (model.type == "METER_READING") {
        /// 抄表任务
        handleMeterReadingTask(model);
      } else if (model.type == "QUALITY_REGULATION" ||
          model.type == "RECTIFICATION") {
        /// 品质督查  整改任务
        dealPatrolTask(model, btnText);
      } else {
        /// 未知

      }
    } else if (model.appName == "WORK_ORDER") {
      ///  工单
      workOrderDeal(model);
    } else {
      /// 未知
      SCToast.showTip('未知错误');
    }
  }

  /// 编号
  String procInstId = "";

  /// 任务ID
  String taskId = "";

  /// 抄表任务
  handleMeterReadingTask(SCToDoModel model) async {
    int lastDollarIndex = model.taskId?.lastIndexOf('\$') ?? 0;
    int firstDollarIndex = model.taskId?.indexOf('\$') ?? 0;
    if (model.operationList?[0] == '接收') {
      handleTaskMeterReadingAccecp(model);
    } else if (model.operationList?[0] == '处理') {
      // var scanData = await SCRouterHelper.pathPage(SCRouterPath.scanPath, null);

      SCPermissionUtils.scanCodeReadWithPrivacyAlert(
          completionHandler: (value) {
        var scanData = value;
        print("扫码结果222===$scanData=======");

        if (scanData['data']['result'].toString().isNotEmpty) {
          SCHttpManager.instance.get(
              url: SCUrl.handleMeterTaskDetail,
              params: {"procInstId": model.taskId},
              success: (detailsInfo) {
                if (detailsInfo.toString().isEmpty) {
                  SCLoadingUtils.hide();
                  SCToast.showTip('未获取到详情信息');
                  return;
                }
                Map<String, dynamic> record = detailsInfo;
                if (record['formData']['isClockIn']) {
                  showDealAlert(model);
                } else {
                  var params = {
                    'deviceId': scanData['data']['result'] ?? '',
                    'procInstId': model.taskId?.substring(0, firstDollarIndex),
                    'taskId': model.code
                  };
                  SCHttpManager.instance.post(
                      url: SCUrl.handleQrcodeMeterReading,
                      params: params,
                      success: (detailsInfo) {
                        print("12345xxs===>$detailsInfo");
                        showDealAlert(model);
                      });
                }
              },
              failure: (err) {
                SCLoadingUtils.hide();
                SCToast.showTip(err['message']);
              });
        }
      });
    }
  }

  handleMeterReadingTaskDetail(SCToDoModel model) {
    ///我经办的任务列表没有包含$_$nodeid,导致跳转失败！！！
    if(model.taskId?.indexOf('\$')!= -1) {
      int lastDollarIndex = model.taskId?.lastIndexOf('\$') ?? 0;
      int firstDollarIndex = model.taskId?.indexOf('\$') ?? 0;
      String url =
          '${SCUtils.getWebViewUrl(url: SCH5.readingTaskMeterDetailUrl, title: '抄表任务', needJointParams: true)}&nodeId=${model.taskId?.substring(lastDollarIndex+1)}&procInstId=${model.taskId?.substring(0, firstDollarIndex)}&taskId=${model.code}';
      // 跳到详情
      SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
        "title": model.subTypeDesc ?? '',
        "url": SCConfig.getH5Url(url),
        "needJointParams": false
      })?.then((value) {
        SCScaffoldManager.instance.eventBus
            .fire({"key": SCKey.kRefreshWorkBenchPage});
      });
    }

  }

  /// 抄表接受任务
  handleTaskMeterReadingAccecp(SCToDoModel model) {
    SCLoadingUtils.show();
    int lastDollarIndex = model.taskId?.indexOf('\$') ?? 0;
    SCHttpManager.instance.post(
        url: SCUrl.handleMeterTask,
        params: {
          "action": 'accept',
          "instanceId": model.taskId?.substring(0, lastDollarIndex),
          "taskId": model.code,
        },
        success: (res) {
          SCToast.showTip('操作成功');
          SCLoadingUtils.hide();
          SCScaffoldManager.instance.eventBus
              .fire({"key": SCKey.kRefreshWorkBenchPage});
        },
        failure: (err) {
          SCLoadingUtils.hide();
          SCToast.showTip(err['message']);
          SCScaffoldManager.instance.eventBus
              .fire({"key": SCKey.kRefreshWorkBenchPage});
        });
  }

  showDealAlert(SCToDoModel model) {
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: MeterReadingAlert(
            title: '处理',
            resultDes: '',
            readingNumber: '本期读数',
            reasonDes: '备注',
            isRequired: true,
            tagList: [],
            hiddenTags: true,
            showNode: false,
            model: model,
            sureAction: (int index, String currentReading, String text,
                List attachments) {},
          ));
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
        "fileKey": params['fileKey']
      };
      list.add(newParams);
    }
    return list;
  }

  handleGetMeterTaskHandle(
      context, String taskId, Map<String, dynamic> comment) {
    var isTurn = 0;
    var previousReading = 0.0;
    var maximumReading = 0.0;
    SCHttpManager.instance.get(
        url: SCUrl.handleMeterTaskDetail,
        params: {"procInstId": taskId},
        success: (detailsInfo) {
          Map<String, dynamic> res = detailsInfo;

          previousReading = res['formData']['previousReading'] ?? 0;
          maximumReading = res['formData']['maximumReading'] ?? 0;

          print(99991);
          print(comment['currentReading']);
          print(res['formData']['previousReading']);
          print(previousReading);
          print(maximumReading);
          print(99991);
          if (double.parse(comment['currentReading']) < previousReading) {
            isTurn = 1;
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(''),
                    content: const Text('本期读数小于上期读数，请确认仪表读数是否已回程。'),
                    actions: <Widget>[
                      TextButton(onPressed: () {}, child: Text('取消')),
                      TextButton(
                          onPressed: () {
                            SCHttpManager.instance.post(
                                url: SCUrl.handleMeterTask,
                                params: {
                                  "action": 'handle',
                                  "description": comment['text'],
                                  "photo": comment['attachments']?[0],
                                  "currentReading": comment['currentReading'],
                                  "deviceId": res['formData']['deviceId'],
                                  "instanceId": res['formData']['procInstId'],
                                  "isTurn": 0,
                                  "taskId":
                                      '377c386e-1fea-11ee-8bd9-baab767e558f',
                                },
                                success: (res) {
                                  SCLoadingUtils.hide();
                                  print(res);
                                },
                                failure: (err) {
                                  SCLoadingUtils.hide();
                                  SCToast.showTip(err['message']);
                                });
                          },
                          child: const Text('确认'))
                    ],
                  );
                });
          }
          if (double.parse(comment['currentReading']) > maximumReading) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(''),
                    content: const Text('当前表读数大于最大表读数，请重新输入正确的表读数。'),
                    actions: <Widget>[
                      TextButton(onPressed: () {}, child: const Text('确认'))
                    ],
                  );
                });
          }
        },
        failure: (err) {
          SCLoadingUtils.hide();
          SCToast.showTip(err['message']);
        });
  }

  //抢单处理
  toGetOrder(SCToDoModel model) {
    SCLoadingUtils.show();
    var params = {
      "action": "accept",
      "instanceId": "",
      "taskId": "",
    };
    SCHttpManager.instance.post(
        url: SCUrl.kTransferUserListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 品质督查
  checkDetail(SCToDoModel model) {
    List<String>? title = model.taskId?.split("\$\_\$");
    String url = '';
    if ((title ?? []).isNotEmpty && title?.length == 2) {
      url =
          "${SCConfig.BASE_URL}${SCH5.checkDetailsUrl}?id=${title?[0]}&nodeId=${title?[1]}&from=app";
    } else {
      SCToast.showTip('未知错误');
      return;
    }
    String realUrl =
        SCUtils.getWebViewUrl(url: url, title: '', needJointParams: true);
    debugPrint("web url = $realUrl");

    SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
      "title": model.subTypeDesc ?? '',
      "url": realUrl,
      "needJointParams": true
    })?.then((value) {
      SCScaffoldManager.instance.eventBus
          .fire({"key": SCKey.kRefreshWorkBenchPage});
    });
  }

  /// 任务整改
  editDetail(SCToDoModel model) {
    List<String>? title = model.taskId?.split("\$\_\$");
    String url = '';
    if ((title ?? []).isNotEmpty && title?.length == 2) {
      url =
          "${SCConfig.BASE_URL}${SCH5.editDetailsUrl}?id=${title?[0]}&nodeId=${title?[1]}&from=app";
    } else {
      SCToast.showTip('未知错误');
      return;
    }
    String realUrl =
        SCUtils.getWebViewUrl(url: url, title: '', needJointParams: true);
    SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
      "title": model.subTypeDesc ?? '',
      "url": realUrl,
      "needJointParams": true
    })?.then((value) {
      SCScaffoldManager.instance.eventBus
          .fire({"key": SCKey.kRefreshWorkBenchPage});
    });
  }

  workOrderDetail(SCToDoModel model) {
    int status = (model.statusValue ?? '0').cnToInt();
    String title = SCUtils.getWorkOrderButtonText(status);
    var url =
        '${SCConfig.BASE_URL}${SCH5.workOrderDetailUrl}?source=my&orderId=${model.taskId}';
    // String url =
    //     "${SCConfig.BASE_URL}${SCH5.workOrderUrl}?isFromWorkBench=1&status=$status&orderId=${model.taskId}&source=workbench";
    String realUrl =
        SCUtils.getWebViewUrl(url: url, title: title, needJointParams: true);
    SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
      "title": model.subTypeDesc ?? '',
      "url": realUrl,
      "needJointParams": false
    })?.then((value) {
      SCScaffoldManager.instance.eventBus
          .fire({"key": SCKey.kRefreshWorkBenchPage});
    });
  }

  workOrderDeal(SCToDoModel model) {
    int status = (model.statusValue ?? '0').cnToInt();
    String title = SCUtils.getWorkOrderButtonText(status);
    String url =
        "${SCConfig.BASE_URL}${SCH5.workOrderUrl}?isFromWorkBench=1&status=$status&orderId=${model.taskId}&source=workbench&openSource=appWorkbench";
    String realUrl =
    SCUtils.getWebViewUrl(url: url, title: title, needJointParams: true);
    SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
      "title": model.subTypeDesc ?? '',
      "url": realUrl,
      "needJointParams": false
    })?.then((value) {
      SCScaffoldManager.instance.eventBus
          .fire({"key": SCKey.kRefreshWorkBenchPage});
    });
  }

  /// 巡查详情
  patrolDetail(SCToDoModel model) {
    String id = model.taskId ?? '';
    String procInstId = '';
    String nodeId = '';
    if (id.isNotEmpty) {
      if (id.contains('\$_\$')) {
        List idList = id.split('\$_\$');
        if (idList.length > 1) {
          procInstId = idList[0];
          nodeId = idList[1];
        } else if (idList.length == 1) {
          procInstId = idList[0];
        }
      } else {
        procInstId = model.taskId ?? '';
      }
    }
    SCRouterHelper.pathPage(SCRouterPath.patrolDetailPage, {
      "procInstId": procInstId,
      "nodeId": nodeId,
      "type": model.type
    })?.then((value) {
      SCScaffoldManager.instance.eventBus
          .fire({"key": SCKey.kRefreshWorkBenchPage});
    });
  }

  /// 巡查处理
  dealPatrolTask(SCToDoModel model, String btnText) async {
    String id = model.taskId ?? '';
    String procInstId = '';
    String nodeId = '';
    if (id.isNotEmpty) {
      if (id.contains('\$_\$')) {
        List idList = id.split('\$_\$');
        if (idList.length > 1) {
          procInstId = idList[0];
          nodeId = idList[1];
        }
      }
    }
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: '${SCUrl.kPatrolDetailUrl}$procInstId\$_\$$nodeId',
        params: null,
        success: (value) {
          SCLoadingUtils.hide();
          String taskId = value['taskId'];
          SCPatrolUtils patrolUtils = SCPatrolUtils();
          patrolUtils.taskId = taskId;
          patrolUtils.procInstId = procInstId;
          patrolUtils.nodeId = nodeId;
          patrolUtils.taskAction(name: btnText);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 巡查处理
  dealPatrolNewTask(SCToDoModel model) async {
    String id = model.taskId ?? '';
    String procInstId = '';
    String nodeId = '';
    if (id.isNotEmpty) {
      if (id.contains('\$_\$')) {
        List idList = id.split('\$_\$');
        if (idList.length > 1) {
          procInstId = idList[0];
          nodeId = idList[1];
        }
      }
    }
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: '${SCUrl.kPatrolDetailUrl}$procInstId\$_\$$nodeId',
        params: null,
        success: (value) {
          SCLoadingUtils.hide();

          SCPatrolDetailModel model = SCPatrolDetailModel.fromJson(value);
          if (model.formData?.checkObject?.type == "route") {
            SCRouterHelper.pathPage(SCRouterPath.patrolRoutePage, {
              "place": model.formData,
              "procInstId": model.procInstId ?? '',
              "nodeId": model.nodeId ?? ''
            });
          } else {
            log('我的数据-------------------------------------此处执行了${model.procInstId ?? ''}  ${model.nodeId ?? ''}');
            SCRouterHelper.pathPage(SCRouterPath.patrolDetailPage, {
              "procInstId": model.procInstId ?? '',
              "nodeId": model.nodeId ?? '',
              "type": "POLICED_WATCH"
            });
          }
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 获取卡片按钮title、处理状态title、颜色值等
  Map<String, dynamic> getCardStyle(SCToDoModel model) {
    // 按钮title
    String btnTitle = '';
    // 状态title
    String statusTitle = model.statusName ?? '';
    // 状态title颜色
    Color statusColor = SCColors.color_1B1D33;
    // 状态
    int status = (model.statusValue ?? '0').cnToInt();
    // 剩余时间相关信息
    var remainingTimeMap = getRemainingTime(model);
    // 创建时间
    String createTime = remainingTimeMap['createTime'];
    // 是否显示倒计时
    bool isShowTimer = remainingTimeMap['isShowTimer'];
    // 剩余时间
    int remainingTime = remainingTimeMap['remainingTime'];
    if ((model.operationList ?? []).isNotEmpty) {
      btnTitle = model.operationList?.first;
    }
    if (model.appName == "TASK") {
      /// 三巡一保
      if (model.type == "POLICED_POINT") {
        /// 巡查
        statusColor = SCPatrolUtils.getStatusColor(status);
      } else if (model.type == "SAFE_PROD") {
        /// 安全生产

      } else {
        /// 未知

      }
    } else if (model.appName == "WORK_ORDER") {
      ///  工单
      btnTitle =
          SCUtils.getWorkOrderButtonText((model.statusValue ?? '0').cnToInt());
    } else {
      /// 未知

    }
    return {
      "btnTitle": btnTitle,
      "statusTitle": statusTitle,
      "statusColor": statusColor,
      'isShowTimer': isShowTimer,
      "remainingTime": remainingTime,
      "createTime": createTime
    };
  }

  /// 通过结束时间获取剩余时间
  Map<String, dynamic> getRemainingTime(SCToDoModel model) {
    // 创建时间
    String createTime = model.createTime ?? '';
    // 是否显示倒计时
    bool isShowTimer = false;
    // 剩余时间
    int remainingTime = 0;
    if (model.appName == "TASK") {
      /// 三巡一保
      if (model.type == "POLICED_POINT") {
        /// 巡查
        // model.endTime = '2023-05-15 09:20:54';
        if (model.endTime != null && model.endTime != '') {
          DateTime endTime = SCDateUtils.stringToDateTime(
              dateString: model.endTime ?? '',
              formateString: 'yyyy-MM-dd HH:mm:ss');
          int endTimeStamp = endTime.millisecondsSinceEpoch ~/ 1000;
          int currentTimeStamp = SCDateUtils.timestamp() ~/ 1000;
          remainingTime = endTimeStamp - currentTimeStamp;
          isShowTimer = true;
        }
      } else if (model.type == "SAFE_PROD") {
        /// 安全生产

      } else {
        /// 未知

      }
    } else if (model.appName == "WORK_ORDER") {
      ///  工单
      if (model.endTime != null && model.endTime != '') {
        DateTime endTime = SCDateUtils.stringToDateTime(
            dateString: model.endTime ?? '',
            formateString: 'yyyy-MM-dd HH:mm:ss');
        int endTimeStamp = endTime.millisecondsSinceEpoch ~/ 1000;
        int currentTimeStamp = SCDateUtils.timestamp() ~/ 1000;
        remainingTime = endTimeStamp - currentTimeStamp;
        isShowTimer = true;
      }
    } else {
      /// 未知

    }
    return {
      'isShowTimer': isShowTimer,
      "remainingTime": remainingTime,
      "createTime": createTime
    };
  }
}
