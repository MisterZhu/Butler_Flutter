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
      this.assignee, 
      this.startTime, 
      this.endTime, 
      this.taskId, 
      this.nodeId, 
      this.formData,});

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
    assignee = json['assignee'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    taskId = json['taskId'];
    nodeId = json['nodeId'];
    formData = json['formData'] != null ? FormData.fromJson(json['formData']) : null;
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
  FormData? formData;

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
    map['assignee'] = assignee;
    map['startTime'] = startTime;
    map['endTime'] = endTime;
    map['taskId'] = taskId;
    map['nodeId'] = nodeId;
    if (formData != null) {
      map['formData'] = formData?.toJson();
    }
    return map;
  }

}

class FormData {
  FormData({
      this.checkObject,});

  FormData.fromJson(dynamic json) {
    checkObject = json['checkObject'] != null ? CheckObject.fromJson(json['checkObject']) : null;
  }
  CheckObject? checkObject;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (checkObject != null) {
      map['checkObject'] = checkObject?.toJson();
    }
    return map;
  }

}

class CheckObject {
  CheckObject({
      this.checkList, 
      this.place, 
      this.bizTag,});

  CheckObject.fromJson(dynamic json) {
    if (json['checkList'] != null) {
      checkList = [];
      json['checkList'].forEach((v) {
        checkList?.add(CheckList.fromJson(v));
      });
    }
    place = json['place'] != null ? Place.fromJson(json['place']) : null;
    bizTag = json['bizTag'];
  }
  List<CheckList>? checkList;
  Place? place;
  String? bizTag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (checkList != null) {
      map['checkList'] = checkList?.map((v) => v.toJson()).toList();
    }
    if (place != null) {
      map['place'] = place?.toJson();
    }
    map['bizTag'] = bizTag;
    return map;
  }

}

class Place {
  Place({
      this.id, 
      this.policedClassId, 
      this.policedClassName, 
      this.disable, 
      this.execWay, 
      this.extra, 
      this.creator, 
      this.operator, 
      this.creatorName, 
      this.operatorName, 
      this.gmtCreate, 
      this.gmtModify, 
      this.placeName, 
      this.tenantId, 
      this.projectId, 
      this.projectName, 
      this.orgId, 
      this.orgName, 
      this.spaceId, 
      this.bizTag,});

  Place.fromJson(dynamic json) {
    id = json['id'];
    policedClassId = json['policedClassId'];
    policedClassName = json['policedClassName'];
    disable = json['disable'];
    execWay = json['execWay'];
    extra = json['extra'];
    creator = json['creator'];
    operator = json['operator'];
    creatorName = json['creatorName'];
    operatorName = json['operatorName'];
    gmtCreate = json['gmtCreate'];
    gmtModify = json['gmtModify'];
    placeName = json['placeName'];
    tenantId = json['tenantId'];
    projectId = json['projectId'];
    projectName = json['projectName'];
    orgId = json['orgId'];
    orgName = json['orgName'];
    spaceId = json['spaceId'];
    bizTag = json['bizTag'];
  }
  String? id;
  String? policedClassId;
  String? policedClassName;
  bool? disable;
  String? execWay;
  String? extra;
  String? creator;
  String? operator;
  String? creatorName;
  String? operatorName;
  String? gmtCreate;
  String? gmtModify;
  String? placeName;
  String? tenantId;
  String? projectId;
  String? projectName;
  String? orgId;
  String? orgName;
  String? spaceId;
  String? bizTag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['policedClassId'] = policedClassId;
    map['policedClassName'] = policedClassName;
    map['disable'] = disable;
    map['execWay'] = execWay;
    map['extra'] = extra;
    map['creator'] = creator;
    map['operator'] = operator;
    map['creatorName'] = creatorName;
    map['operatorName'] = operatorName;
    map['gmtCreate'] = gmtCreate;
    map['gmtModify'] = gmtModify;
    map['placeName'] = placeName;
    map['tenantId'] = tenantId;
    map['projectId'] = projectId;
    map['projectName'] = projectName;
    map['orgId'] = orgId;
    map['orgName'] = orgName;
    map['spaceId'] = spaceId;
    map['bizTag'] = bizTag;
    return map;
  }

}

class CheckList {
  CheckList({
      this.id, 
      this.tenantId, 
      this.checkName, 
      this.checkContent, 
      this.standardCode, 
      this.bizTag, 
      this.groupId, 
      this.groupName, 
      this.disable, 
      this.creator, 
      this.operator, 
      this.creatorName, 
      this.operatorName, 
      this.gmtCreate, 
      this.gmtModify,});

  CheckList.fromJson(dynamic json) {
    id = json['id'];
    tenantId = json['tenantId'];
    checkName = json['checkName'];
    checkContent = json['checkContent'];
    standardCode = json['standardCode'];
    bizTag = json['bizTag'];
    groupId = json['groupId'];
    groupName = json['groupName'];
    disable = json['disable'];
    creator = json['creator'];
    operator = json['operator'];
    creatorName = json['creatorName'];
    operatorName = json['operatorName'];
    gmtCreate = json['gmtCreate'];
    gmtModify = json['gmtModify'];
  }
  String? id;
  String? tenantId;
  String? checkName;
  String? checkContent;
  String? standardCode;
  String? bizTag;
  String? groupId;
  String? groupName;
  bool? disable;
  String? creator;
  String? operator;
  String? creatorName;
  String? operatorName;
  String? gmtCreate;
  String? gmtModify;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['tenantId'] = tenantId;
    map['checkName'] = checkName;
    map['checkContent'] = checkContent;
    map['standardCode'] = standardCode;
    map['bizTag'] = bizTag;
    map['groupId'] = groupId;
    map['groupName'] = groupName;
    map['disable'] = disable;
    map['creator'] = creator;
    map['operator'] = operator;
    map['creatorName'] = creatorName;
    map['operatorName'] = operatorName;
    map['gmtCreate'] = gmtCreate;
    map['gmtModify'] = gmtModify;
    return map;
  }

}