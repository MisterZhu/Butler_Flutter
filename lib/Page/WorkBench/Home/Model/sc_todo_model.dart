/// 工作台-待办model
class SCToDoModel {
  SCToDoModel(
      {this.appName,
      this.type,
      this.subType,
      this.taskId,
      this.id,
      this.code,
      this.title,
      this.content,
      this.statusName,
      this.statusValue,
      this.handleUserIds,
      this.handledUserIds,
      this.followUserIds,
      this.hallUserIds,
      this.beginTime,
      this.endTime,
      this.createTime,
      this.creator,
      this.operator,
      this.creatorName,
      this.operatorName,
      this.tenantId,
      this.tenantName,
      this.communityId,
      this.communityName,
      this.operationList,
      this.contact,// 联系人姓名
      this.contactAddress,// 联系人房屋地址
      this.contactInform, // 联系人手机号
        this.typeDesc,// 任务类型
        this.subTypeDesc,
      });

  SCToDoModel.fromJson(dynamic json) {
    appName = json['appName'];
    type = json['type'];
    subType = json['subType'];
    taskId = json['taskId'];
    id = json['id'];
    code = json['code'];
    title = json['title'];
    content = json['content'];
    statusName = json['statusName'];
    statusValue = json['statusValue'];
    handleUserIds = json['handleUserIds'];
    handledUserIds = json['handledUserIds'];
    followUserIds = json['followUserIds'];
    hallUserIds = json['hallUserIds'];
    beginTime = json['beginTime'];
    endTime = json['endTime'];
    createTime = json['createTime'];
    creator = json['creator'];
    operator = json['operator'];
    creatorName = json['creatorName'];
    operatorName = json['operatorName'];
    tenantId = json['tenantId'];
    tenantName = json['tenantName'];
    communityId = json['communityId'];
    communityName = json['communityName'];
    operationList = json['operationList'];
    contact = json['contact'];
    contactInform = json['contactInform'];
    contactAddress = json['contactAddress'];
    typeDesc = json['typeDesc'];
    subTypeDesc = json['subTypeDesc'];
  }
  String? appName;
  String? type;
  String? subType;
  String? taskId;
  String? id;
  String? code;
  String? title;
  String? content;
  String? statusName;
  String? statusValue;
  String? handleUserIds;
  String? handledUserIds;
  String? followUserIds;
  String? hallUserIds;
  String? beginTime;
  String? endTime;
  String? createTime;
  String? creator;
  String? operator;
  String? creatorName;
  String? operatorName;
  String? tenantId;
  String? tenantName;
  String? communityId;
  String? communityName;
  List? operationList; // 操作按钮
  String? contact;
  String? contactAddress;
  String? contactInform;
  String? typeDesc;
  String? subTypeDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appName'] = appName;
    map['type'] = type;
    map['subType'] = subType;
    map['taskId'] = taskId;
    map['id'] = id;
    map['code'] = code;
    map['title'] = title;
    map['content'] = content;
    map['statusName'] = statusName;
    map['statusValue'] = statusValue;
    map['handleUserIds'] = handleUserIds;
    map['handledUserIds'] = handledUserIds;
    map['followUserIds'] = followUserIds;
    map['hallUserIds'] = hallUserIds;
    map['beginTime'] = beginTime;
    map['endTime'] = endTime;
    map['createTime'] = createTime;
    map['creator'] = creator;
    map['operator'] = operator;
    map['creatorName'] = creatorName;
    map['operatorName'] = operatorName;
    map['tenantId'] = tenantId;
    map['tenantName'] = tenantName;
    map['communityId'] = communityId;
    map['communityName'] = communityName;
    map['operationList'] = operationList;
    map['contact'] = contact;
    map['contactInform'] = contactInform;
    map['contactAddress'] = contactAddress;
    map['typeDesc'] = typeDesc;
    map['subTypeDesc'] = subTypeDesc;
    return map;
  }
}
