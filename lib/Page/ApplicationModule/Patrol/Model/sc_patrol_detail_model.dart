/// 巡查详情model
class SCPatrolDetailModel {
  SCPatrolDetailModel({
      this.procInstId, 
      this.procInstName, 
      this.categoryId, 
      this.categoryName, 
      this.instSource, 
      this.customStatus, 
      this.customStatusInt, 
      this.customStatusList, 
      this.actionVo, 
      this.isOverTime, 
      this.procName, 
      this.assignee, 
      this.startTime, 
      this.endTime, 
      this.taskId,});

  SCPatrolDetailModel.fromJson(dynamic json) {
    procInstId = json['procInstId'];
    procInstName = json['procInstName'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    instSource = json['instSource'];
    customStatus = json['customStatus'];
    customStatusInt = json['customStatusInt'];
    customStatusList = json['customStatusList'] != null ? json['customStatusList'].cast<String>() : [];
    actionVo = json['actionVo'] != null ? json['actionVo'].cast<String>() : [];
    isOverTime = json['isOverTime'];
    procName = json['procName'];
    assignee = json['assignee'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    taskId = json['taskId'];
  }
  String? procInstId;// 编号
  String? procInstName;// 任务名称
  int? categoryId;// 任务分类
  String? categoryName;// 分类名称
  String? instSource;// 任务来源
  String? customStatus;// 任务状态
  int? customStatusInt;// 任务状态(数值)
  List<String>? customStatusList;// 任务状态-详情展示
  List<String>? actionVo;// 操作按钮
  String? isOverTime;// 任务超时
  String? procName;// 归属项目
  String? assignee;// 当前执行人
  String? startTime;// 任务开始时间
  String? endTime;// 任务完成时间
  String? taskId;// 任务ID

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['procInstId'] = procInstId;
    map['procInstName'] = procInstName;
    map['categoryId'] = categoryId;
    map['categoryName'] = categoryName;
    map['instSource'] = instSource;
    map['customStatus'] = customStatus;
    map['customStatusInt'] = customStatusInt;
    map['customStatusList'] = customStatusList;
    map['actionVo'] = actionVo;
    map['isOverTime'] = isOverTime;
    map['procName'] = procName;
    map['assignee'] = assignee;
    map['startTime'] = startTime;
    map['endTime'] = endTime;
    map['taskId'] = taskId;
    return map;
  }

}