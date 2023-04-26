/// 工作台model
class SCWorkBenchModel {
  SCWorkBenchModel({
      this.appName, 
      this.beginTime, 
      this.code, 
      this.communityId, 
      this.communityName, 
      this.content, 
      this.createTime, 
      this.creator, 
      this.creatorName, 
      this.endTime, 
      this.followUserIds, 
      this.hallUserIds, 
      this.handleUserIds, 
      this.handledUserIds, 
      this.id, 
      this.operator, 
      this.operatorName, 
      this.statusName, 
      this.statusValue, 
      this.subType, 
      this.taskId, 
      this.tenantId, 
      this.tenantName, 
      this.title, 
      this.type,});

  SCWorkBenchModel.fromJson(dynamic json) {
    appName = json['appName'];
    beginTime = json['beginTime'];
    code = json['code'];
    communityId = json['communityId'];
    communityName = json['communityName'];
    content = json['content'];
    createTime = json['createTime'];
    creator = json['creator'];
    creatorName = json['creatorName'];
    endTime = json['endTime'];
    followUserIds = json['followUserIds'];
    hallUserIds = json['hallUserIds'];
    handleUserIds = json['handleUserIds'];
    handledUserIds = json['handledUserIds'];
    id = json['id'];
    operator = json['operator'];
    operatorName = json['operatorName'];
    statusName = json['statusName'];
    statusValue = json['statusValue'];
    subType = json['subType'];
    taskId = json['taskId'];
    tenantId = json['tenantId'];
    tenantName = json['tenantName'];
    title = json['title'];
    type = json['type'];
  }
  String? appName;
  String? beginTime;
  String? code;
  String? communityId;
  String? communityName;
  String? content;
  String? createTime;
  String? creator;
  String? creatorName;
  String? endTime;
  String? followUserIds;
  String? hallUserIds;
  String? handleUserIds;
  String? handledUserIds;
  String? id;
  String? operator;
  String? operatorName;
  String? statusName;
  String? statusValue;
  String? subType;
  String? taskId;
  String? tenantId;
  String? tenantName;
  String? title;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appName'] = appName;
    map['beginTime'] = beginTime;
    map['code'] = code;
    map['communityId'] = communityId;
    map['communityName'] = communityName;
    map['content'] = content;
    map['createTime'] = createTime;
    map['creator'] = creator;
    map['creatorName'] = creatorName;
    map['endTime'] = endTime;
    map['followUserIds'] = followUserIds;
    map['hallUserIds'] = hallUserIds;
    map['handleUserIds'] = handleUserIds;
    map['handledUserIds'] = handledUserIds;
    map['id'] = id;
    map['operator'] = operator;
    map['operatorName'] = operatorName;
    map['statusName'] = statusName;
    map['statusValue'] = statusValue;
    map['subType'] = subType;
    map['taskId'] = taskId;
    map['tenantId'] = tenantId;
    map['tenantName'] = tenantName;
    map['title'] = title;
    map['type'] = type;
    return map;
  }

}