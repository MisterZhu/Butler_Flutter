import 'dart:async';
import 'dart:ffi';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Alert/sc_reject_node_alert.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/Date/sc_date_utils.dart';
import '../../Home/Model/sc_todo_model.dart';
import '../../Home/View/Alert/sc_alert_header_view.dart';
import '../../../ApplicationModule/HouseInspect/View/sc_bottom_button_item.dart';
import '../../../ApplicationModule/HouseInspect/View/sc_deliver_evidence_cell.dart';
import '../../../ApplicationModule/HouseInspect/View/sc_deliver_explain_cell.dart';
import '../../../ApplicationModule/MaterialEntry/View/AddEntry/sc_material_select_item.dart';
import '../meterReadingModule/inputItemCell.dart';
import '../meterReadingModule/imgUpload.dart';

/// 驳回弹窗

class MeterReadingAlert extends StatefulWidget {
  /// 标题
  final String title;

  /// 本期读数title
  final String readingNumber;

  /// 结果-title
  final String resultDes;

  /// 说明-title
  final String reasonDes;

  /// 标签list
  final List tagList;

  final bool showNode;

  SCToDoModel? model;

  /// 是否必填原因
  final bool? isRequired;

  /// 隐藏输入框底部提示标签
  final bool? hiddenTags;

  /// 确定
  final Function(int resultIndex, String currentReading, String explainValue,
      List imageList)? sureAction;

  MeterReadingAlert({
    Key? key,
    required this.title,
    required this.readingNumber,
    required this.resultDes,
    required this.reasonDes,
    required this.tagList,
    required this.showNode,
    this.isRequired,
    this.hiddenTags,
    this.sureAction,
    this.model,
  }) : super(key: key);

  @override
  MeterReadingAlertState createState() => MeterReadingAlertState();
}

class MeterReadingAlertState extends State<MeterReadingAlert> {
  late StreamSubscription<bool> keyboardSubscription;

  /// 是否弹起键盘
  bool isShowKeyboard = false;

  /// 结果index
  int resultIndex = -1;

  /// 节点
  String node = '';

  /// 输入的内容
  String text = '';

  /// 图片数组
  List attachments = [];

  /// 本期读数
  String currentReading = '';

  double _inputHeight = 30.0;

  @override
  initState() {
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
    double height = 395.0 +
        54.0 +
        MediaQuery.of(context).padding.bottom +
        (isShowKeyboard ? 100.0 : 0.0) +
        ((widget.tagList.isNotEmpty && ((widget.hiddenTags ?? false) == false))
            ? 32
            : 0.0);
    return GestureDetector(
        onTap: () {
          SCUtils().hideKeyboard(context: context);
        },
        child: Container(
          width: double.infinity,
          height: height,
          decoration: const BoxDecoration(
              color: SCColors.color_F2F3F5,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              titleItem(context),
              Expanded(child: listView()),
              const SizedBox(
                height: 20.0,
              ),
              SCBottomButtonItem(
                list: const ['取消', '确定'],
                buttonType: 1,
                leftTapAction: () {
                  Navigator.of(context).pop();
                },
                rightTapAction: () {
                  // sureAction();

                  bool needInput = widget.isRequired ?? false;
                  if (needInput && currentReading.isEmpty) {
                    SCToast.showTip('请输入${widget.readingNumber}');
                    return;
                  }

                  handleMeterTask(
                      action: "handle",
                      code: 'code',
                      taskId: widget.model?.taskId,
                      currentReading: currentReading,
                      content: text,
                      imageList: attachments,
                      context: context,
                      result: (result) {});
                },
              ),
            ],
          ),
        ));
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

  handleMeterTask(
      {required String action,
      String? node,
      String? content,
      List? imageList,
      String? code,
      String? currentReading,
      String? taskId,
      String? targetUser,
      String? targetNode,
      dynamic context,
      Function(dynamic data)? result}) {
    var comment = {};
    if (action == "handle") {
      // 处理
      Map<String, dynamic> comment = {
        "attachments": transferImage(imageList ?? []),
        "text": content,
        "currentReading": currentReading
      };
      SCLoadingUtils.show();
      handleGetMeterTaskHandle(context, taskId!, comment);
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
    }
    var params = {
      "action": action,
      "comment": comment,
      "currentReading": currentReading,
      "formData": {"field_code": code ?? ''},
      "instanceId": '',
      "taskId": taskId,
      "targetUser": targetUser,
      "targetNode": targetNode
    };
    // SCLoadingUtils.show();
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
          SCLoadingUtils.hide();
          if (detailsInfo.toString().isEmpty) {
            SCToast.showTip('未获取到详情信息');
            return;
          }
          Map<String, dynamic> res = detailsInfo;

          previousReading = res['formData']['previousReading'] ?? 0;
          maximumReading = res['formData']['maximumReading'] ?? 0;

          if (double.parse(comment['currentReading']) < previousReading) {
            isTurn = 1;
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: const Text('本期读数小于上期读数，请确认仪表读数是否已回程。'),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            '取消',
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                          )),
                      TextButton(
                          onPressed: () {
                            SCLoadingUtils.show();
                            print(
                                "-=----------=-----${comment['attachments']}");
                            var photoStr = null;
                            if (comment['attachments'].length > 0) {
                              photoStr = comment['attachments']?[0];
                            }
                            SCHttpManager.instance.post(
                                url: SCUrl.handleMeterTask,
                                params: {
                                  "action": 'handle',
                                  "description": comment['text'],
                                  "photo": photoStr,
                                  "currentReading": comment['currentReading'],
                                  "deviceId": res['formData']['deviceId'],
                                  "instanceId": res['procInstId'],
                                  "isTurn": isTurn,
                                  "taskId": res['taskId'],
                                },
                                success: (res) {
                                  SCLoadingUtils.hide();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  SCScaffoldManager.instance.eventBus.fire(
                                      {"key": SCKey.kRefreshWorkBenchPage});
                                },
                                failure: (err) {
                                  SCLoadingUtils.hide();
                                  SCToast.showTip(err['message']);
                                });
                          },
                          child: const Text(
                            '确认',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ))
                    ],
                  );
                });
          } else if (double.parse(comment['currentReading']) > maximumReading) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: const Text('当前表读数大于最大表读数，请重新输入正确的表读数。'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text(
                          '确认',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            currentReading = '';
                          });
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                });
          } else {
            SCLoadingUtils.show();
            isTurn = 0;
            print("-=----------=-----${comment['attachments']}");
            var photoStr = null;
            if (comment['attachments'].length > 0) {
              photoStr = comment['attachments']?[0];
            }
            SCHttpManager.instance.post(
                url: SCUrl.handleMeterTask,
                params: {
                  "action": 'handle',
                  "description": comment['text'],
                  "photo": photoStr,
                  "currentReading": comment['currentReading'],
                  "deviceId": res['formData']['deviceId'],
                  "instanceId": res['procInstId'],
                  "isTurn": isTurn,
                  "taskId": res['taskId'],
                },
                success: (res) {
                  SCToast.showTip('操作成功');
                  SCLoadingUtils.hide();
                  Navigator.of(context).pop();
                  SCScaffoldManager.instance.eventBus
                      .fire({"key": SCKey.kRefreshWorkBenchPage});
                },
                failure: (err) {
                  SCLoadingUtils.hide();
                  SCToast.showTip(err['message']);
                });
          }
        },
        failure: (err) {
          SCLoadingUtils.hide();
          SCToast.showTip(err['message']);
        });
  }

  /// listView
  Widget listView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
          decoration: BoxDecoration(
              color: SCColors.color_FFFFFF,
              borderRadius: BorderRadius.circular(4.0)),
          child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return getCell(index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: 3)),
    );
  }

  ///入参
  // action: 'handle',
  // comment: { text: '54654666', attachments: [] },
  // currentReading: 5,
  // deviceId: '13760926164641',
  // instanceId: '37792aea-1fea-11ee-8bd9-baab767e558f',
  // isTurn: 0,
  // taskId: '377c386e-1fea-11ee-8bd9-baab767e558f',

  Widget getCell(int index) {
    if (index == 0) {
      return readNumberInputItem();
    } else if (index == 1) {
      return contentItem();
    } else if (index == 2) {
      return photosItem();
    } else {
      return const SizedBox(
        height: 10,
      );
    }
  }

  /// 输入框
  Widget readNumberInputItem() {
    bool needInput = widget.isRequired ?? false;
    return Container(
        padding: needInput
            ? const EdgeInsets.fromLTRB(6, 12.0, 0, 0)
            : const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: InputItemCell(
          isRequired: true,
          title: widget.readingNumber,
          errorTitle: '未填写本期读数',
          content: currentReading,
          inputHeight: _inputHeight,
          inputAction: (String content) {
            currentReading = content;
          },
        ));
  }

  /// title
  Widget titleItem(BuildContext context) {
    return SCAlertHeaderView(
      title: widget.title,
      closeTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  /// contentItem
  Widget contentItem() {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nodeItem(),
          const SizedBox(
            height: 12.0,
          ),
          inputItem(),
          // tagsView(),
        ]);
  }

  /// 节点item
  Widget nodeItem() {
    return Offstage(
      offstage: !widget.showNode,
      child: Column(
        children: [
          SCMaterialSelectItem(
            isRequired: true,
            title: widget.resultDes,
            content: node,
            selectAction: () {
              showNodeAlert();
            },
          ),
          line(),
        ],
      ),
    );
  }

  /// 输入框
  Widget inputItem() {
    bool needInput = false;
    return Container(
        padding: needInput
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: SCDeliverExplainCell(
          isRequired: needInput,
          title: widget.reasonDes,
          content: text,
          inputHeight: 92.0,
          inputAction: (String content) {
            text = content;
          },
        ));
  }

  /// 图片
  Widget photosItem() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: ImgUpload(
          title: '上传照片',
          addIcon: SCAsset.iconMaterialAddPhoto,
          addPhotoType: SCAddPhotoType.all,
          files: attachments,
          updatePhoto: (List list) {
            setState(() {
              attachments = list;
            });
          },
        ));
  }

  /// tagsView
  Widget tagsView() {
    if (widget.tagList.isNotEmpty && (widget.hiddenTags ?? false) == false) {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 7.0,
          runSpacing: 10.0,
          children: widget.tagList
              .asMap()
              .keys
              .map((index) => cell(widget.tagList[index]))
              .toList(),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  /// cell
  Widget cell(String name) {
    return GestureDetector(
      onTap: () {
        setState(() {
          text = text + name;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 24.0,
        decoration: BoxDecoration(
          color: SCColors.color_F7F8FA,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
        child: Text(
          name,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: SCFonts.f12,
            color: SCColors.color_8D8E99,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  /// 节点弹窗
  showNodeAlert() {
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCRejectNodeAlert(
            title: widget.resultDes,
            list: widget.tagList,
            currentNode: node,
            tapAction: (value, index) {
              setState(() {
                node = value;
                resultIndex = index;
              });
            },
          ));
    });
  }

  /// line
  Widget line() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.only(left: 12.0),
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  /// 确定
  sureAction() {
    bool needInput = widget.isRequired ?? false;
    if (needInput && currentReading.isEmpty) {
      SCToast.showTip('请输入${widget.readingNumber}');
      return;
    }

    widget.sureAction?.call(resultIndex, currentReading, text, attachments);
    Navigator.of(context).pop();
  }
}
