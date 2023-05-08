/// 巡查任务model

class SCPatrolTaskModel {
  SCPatrolTaskModel({
      this.actionVo, 
      this.assignee, 
      this.categoryId, 
      this.categoryName, 
      this.customStatus,
      this.customStatusInt,
      this.customStatusList, 
      this.endTime, 
      this.instSource, 
      this.isOverTime, 
      this.procInstId, 
      this.procInstName, 
      this.procName, 
      this.startTime, 
      this.taskId,
      this.nodeId,});

  SCPatrolTaskModel.fromJson(dynamic json) {
    actionVo = json['actionVo'] != null ? json['actionVo'].cast<String>() : [];
    assignee = json['assignee'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    customStatus = json['customStatus'];
    customStatusInt = json['customStatusInt'];
    customStatusList = json['customStatusList'] != null ? json['customStatusList'].cast<String>() : [];
    endTime = json['endTime'];
    instSource = json['instSource'];
    isOverTime = json['isOverTime'];
    procInstId = json['procInstId'];
    procInstName = json['procInstName'];
    procName = json['procName'];
    startTime = json['startTime'];
    taskId = json['taskId'];
    nodeId = json['nodeId'];
  }
  List<String>? actionVo;
  String? assignee;
  int? categoryId;
  String? categoryName;
  String? customStatus;
  int? customStatusInt;
  List<String>? customStatusList;
  String? endTime;
  String? instSource;
  String? isOverTime;
  String? procInstId;
  String? procInstName;
  String? procName;
  String? startTime;
  String? taskId;
  String? nodeId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['actionVo'] = actionVo;
    map['assignee'] = assignee;
    map['categoryId'] = categoryId;
    map['categoryName'] = categoryName;
    map['customStatus'] = customStatus;
    map['customStatusInt'] = customStatusInt;
    map['customStatusList'] = customStatusList;
    map['endTime'] = endTime;
    map['instSource'] = instSource;
    map['isOverTime'] = isOverTime;
    map['procInstId'] = procInstId;
    map['procInstName'] = procInstName;
    map['procName'] = procName;
    map['startTime'] = startTime;
    map['taskId'] = taskId;
    map['nodeId'] = nodeId;
    return map;
  }

}