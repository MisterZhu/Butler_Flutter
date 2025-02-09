import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_form_data_model.dart';

class SCPatrolDetailModel {
  SCPatrolDetailModel({
      this.procInstId, 
      this.procInstName, 
      this.categoryId, 
      this.categoryName, 
      this.instSource, 
      this.customStatus, 
      this.sysStatus, 
      this.customStatusInt, 
      this.customStatusList, 
      this.actionVo, 
      this.isOverTime, 
      this.procName, 
      this.communityId,
      this.assignee,
      this.startTime, 
      this.endTime, 
      this.taskId, 
      this.nodeId, 
      this.formData,
      this.isScanCode,
      this.assigneeName,
      this.nodeBizCfg,
  });

  SCPatrolDetailModel.fromJson(dynamic json) {
    procInstId = json['procInstId'];
    procInstName = json['procInstName'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    instSource = json['instSource'];
    customStatus = json['customStatus'];
    sysStatus = json['sysStatus'];
    customStatusInt = json['customStatusInt'];
    customStatusList = json['customStatusList'] != null ? json['customStatusList'].cast<String>() : [];
    actionVo = json['actionVo'] != null ? json['actionVo'].cast<String>() : [];
    isOverTime = json['isOverTime'];
    procName = json['procName'];
    communityId = json['communityId'];
    assignee = json['assignee'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    taskId = json['taskId'];
    nodeId = json['nodeId'];
    formData = json['formData'] != null ? FormDataModel.fromJson(json['formData']) : null;
    isScanCode = json['isScanCode'];
    assigneeName = json['assigneeName'];
    nodeBizCfg = json['nodeBizCfg'];
  }
  String? procInstId;
  String? procInstName;
  int? categoryId;
  String? categoryName;
  String? instSource;
  String? customStatus;
  String? sysStatus;
  int? customStatusInt;
  List<String>? customStatusList;
  List<String>? actionVo;
  String? isOverTime;
  String? procName;
  String? assignee;
  String? startTime;
  String? endTime;
  String? taskId;
  String? nodeId;
  FormDataModel? formData;
  bool? isScanCode;
  String? assigneeName;
  String? communityId;
  Map? nodeBizCfg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['procInstId'] = procInstId;
    map['procInstName'] = procInstName;
    map['categoryId'] = categoryId;
    map['categoryName'] = categoryName;
    map['instSource'] = instSource;
    map['customStatus'] = customStatus;
    map['sysStatus'] = sysStatus;
    map['customStatusInt'] = customStatusInt;
    map['customStatusList'] = customStatusList;
    map['actionVo'] = actionVo;
    map['isOverTime'] = isOverTime;
    map['procName'] = procName;
    map['communityId'] = communityId;
    map['assignee'] = assignee;
    map['startTime'] = startTime;
    map['endTime'] = endTime;
    map['taskId'] = taskId;
    map['nodeId'] = nodeId;
    if (formData != null) {
      map['formData'] = formData?.toJson();
    }
    map['isScanCode'] = isScanCode;
    map['assigneeName'] = assigneeName;
    map['nodeBizCfg'] = nodeBizCfg;
    return map;
  }

  @override
  String toString() {
    return 'SCPatrolDetailModel{procInstId: $procInstId, procInstName: $procInstName, categoryId: $categoryId, categoryName: $categoryName, instSource: $instSource, customStatus: $customStatus, sysStatus: $sysStatus, customStatusInt: $customStatusInt, customStatusList: $customStatusList, actionVo: $actionVo, isOverTime: $isOverTime, procName: $procName, assignee: $assignee, startTime: $startTime, endTime: $endTime, taskId: $taskId, nodeId: $nodeId, formData: $formData, isScanCode: $isScanCode, assigneeName: $assigneeName}';
  }
}
