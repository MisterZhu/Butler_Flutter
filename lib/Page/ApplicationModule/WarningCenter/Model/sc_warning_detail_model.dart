class SCWarningDetailModel {
  SCWarningDetailModel({
      this.alertCode, 
      this.alertContext, 
      this.alertDetailedVS, 
      this.alertExplain, 
      this.alertPlanName, 
      this.alertSource, 
      this.alertType, 
      this.alertWorkOrderVList, 
      this.beginTime, 
      this.communityId, 
      this.communityName, 
      this.confirmResult, 
      this.confirmResultName, 
      this.endTime, 
      this.fileVoList, 
      this.generationTime, 
      this.gmtCreate, 
      this.gmtModify, 
      this.id, 
      this.levelId, 
      this.levelName, 
      this.operator, 
      this.operatorName, 
      this.ruleId, 
      this.ruleName, 
      this.status, 
      this.statusName,});

  SCWarningDetailModel.fromJson(dynamic json) {
    alertCode = json['alertCode'];
    alertContext = json['alertContext'];
    if (json['alertDetailedVS'] != null) {
      alertDetailedVS = [];
      json['alertDetailedVS'].forEach((v) {
        alertDetailedVS?.add(AlertDetailedVs.fromJson(v));
      });
    }
    alertExplain = json['alertExplain'];
    alertPlanName = json['alertPlanName'];
    alertSource = json['alertSource'];
    alertType = json['alertType'];
    if (json['alertWorkOrderVList'] != null) {
      alertWorkOrderVList = [];
      json['alertWorkOrderVList'].forEach((v) {
        alertWorkOrderVList?.add(AlertWorkOrderVList.fromJson(v));
      });
    }
    beginTime = json['beginTime'];
    communityId = json['communityId'];
    communityName = json['communityName'];
    confirmResult = json['confirmResult'];
    confirmResultName = json['confirmResultName'];
    endTime = json['endTime'];
    if (json['fileVoList'] != null) {
      fileVoList = [];
      json['fileVoList'].forEach((v) {
        fileVoList?.add(FileVoList.fromJson(v));
      });
    }
    generationTime = json['generationTime'];
    gmtCreate = json['gmtCreate'];
    gmtModify = json['gmtModify'];
    id = json['id'];
    levelId = json['levelId'];
    levelName = json['levelName'];
    operator = json['operator'];
    operatorName = json['operatorName'];
    ruleId = json['ruleId'];
    ruleName = json['ruleName'];
    status = json['status'];
    statusName = json['statusName'];
  }
  String? alertCode;
  String? alertContext;
  List<AlertDetailedVs>? alertDetailedVS;
  String? alertExplain;
  String? alertPlanName;
  String? alertSource;
  String? alertType;
  List<AlertWorkOrderVList>? alertWorkOrderVList;
  String? beginTime;
  String? communityId;
  String? communityName;
  int? confirmResult;
  String? confirmResultName;
  String? endTime;
  List<FileVoList>? fileVoList;
  String? generationTime;
  String? gmtCreate;
  String? gmtModify;
  int? id;
  int? levelId;
  String? levelName;
  String? operator;
  String? operatorName;
  int? ruleId;
  String? ruleName;
  int? status;
  String? statusName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['alertCode'] = alertCode;
    map['alertContext'] = alertContext;
    if (alertDetailedVS != null) {
      map['alertDetailedVS'] = alertDetailedVS?.map((v) => v.toJson()).toList();
    }
    map['alertExplain'] = alertExplain;
    map['alertPlanName'] = alertPlanName;
    map['alertSource'] = alertSource;
    map['alertType'] = alertType;
    if (alertWorkOrderVList != null) {
      map['alertWorkOrderVList'] = alertWorkOrderVList?.map((v) => v.toJson()).toList();
    }
    map['beginTime'] = beginTime;
    map['communityId'] = communityId;
    map['communityName'] = communityName;
    map['confirmResult'] = confirmResult;
    map['confirmResultName'] = confirmResultName;
    map['endTime'] = endTime;
    if (fileVoList != null) {
      map['fileVoList'] = fileVoList?.map((v) => v.toJson()).toList();
    }
    map['generationTime'] = generationTime;
    map['gmtCreate'] = gmtCreate;
    map['gmtModify'] = gmtModify;
    map['id'] = id;
    map['levelId'] = levelId;
    map['levelName'] = levelName;
    map['operator'] = operator;
    map['operatorName'] = operatorName;
    map['ruleId'] = ruleId;
    map['ruleName'] = ruleName;
    map['status'] = status;
    map['statusName'] = statusName;
    return map;
  }

}

class FileVoList {
  FileVoList({
      this.fileKey, 
      this.name, 
      this.size, 
      this.suffix, 
      this.type,});

  FileVoList.fromJson(dynamic json) {
    fileKey = json['fileKey'];
    name = json['name'];
    size = json['size'];
    suffix = json['suffix'];
    type = json['type'];
  }
  String? fileKey;
  String? name;
  int? size;
  String? suffix;
  int? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fileKey'] = fileKey;
    map['name'] = name;
    map['size'] = size;
    map['suffix'] = suffix;
    map['type'] = type;
    return map;
  }

}

class AlertWorkOrderVList {
  AlertWorkOrderVList({
      this.alertId, 
      this.serialNumber, 
      this.sortNum, 
      this.workOrderId,});

  AlertWorkOrderVList.fromJson(dynamic json) {
    alertId = json['alertId'];
    serialNumber = json['serialNumber'];
    sortNum = json['sortNum'];
    workOrderId = json['workOrderId'];
  }
  int? alertId;
  String? serialNumber;
  int? sortNum;
  String? workOrderId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['alertId'] = alertId;
    map['serialNumber'] = serialNumber;
    map['sortNum'] = sortNum;
    map['workOrderId'] = workOrderId;
    return map;
  }

}

class AlertDetailedVs {
  AlertDetailedVs({
      this.addressCode, 
      this.alertContext, 
      this.alertSource, 
      this.alertSourceVList, 
      this.deviceCode, 
      this.eventName, 
      this.firstAlertTime, 
      this.humanCode, 
      this.loopCode, 
      this.nowAlertTime, 
      this.position, 
      this.reportTime,});

  AlertDetailedVs.fromJson(dynamic json) {
    addressCode = json['addressCode'];
    alertContext = json['alertContext'];
    alertSource = json['alertSource'];
    if (json['alertSourceVList'] != null) {
      alertSourceVList = [];
      json['alertSourceVList'].forEach((v) {
        alertSourceVList?.add(AlertSourceVList.fromJson(v));
      });
    }
    deviceCode = json['deviceCode'];
    eventName = json['eventName'];
    firstAlertTime = json['firstAlertTime'];
    humanCode = json['humanCode'];
    loopCode = json['loopCode'];
    nowAlertTime = json['nowAlertTime'];
    position = json['position'];
    reportTime = json['reportTime'];
  }
  String? addressCode;
  String? alertContext;
  String? alertSource;
  List<AlertSourceVList>? alertSourceVList;
  String? deviceCode;
  String? eventName;
  String? firstAlertTime;
  String? humanCode;
  String? loopCode;
  String? nowAlertTime;
  String? position;
  int? reportTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['addressCode'] = addressCode;
    map['alertContext'] = alertContext;
    map['alertSource'] = alertSource;
    if (alertSourceVList != null) {
      map['alertSourceVList'] = alertSourceVList?.map((v) => v.toJson()).toList();
    }
    map['deviceCode'] = deviceCode;
    map['eventName'] = eventName;
    map['firstAlertTime'] = firstAlertTime;
    map['humanCode'] = humanCode;
    map['loopCode'] = loopCode;
    map['nowAlertTime'] = nowAlertTime;
    map['position'] = position;
    map['reportTime'] = reportTime;
    return map;
  }

}

class AlertSourceVList {
  AlertSourceVList({
      this.alertId, 
      this.alertSourceCode, 
      this.communityId, 
      this.communityName, 
      this.coordinateSystem, 
      this.creator, 
      this.creatorName, 
      this.eventName, 
      this.gmtCreate, 
      this.id, 
      this.latitude, 
      this.longitude, 
      this.position, 
      this.sourceContent, 
      this.sourceId, 
      this.sourceKind, 
      this.sourceName, 
      this.tenantId, 
      this.tenantName,});

  AlertSourceVList.fromJson(dynamic json) {
    alertId = json['alertId'];
    alertSourceCode = json['alertSourceCode'];
    communityId = json['communityId'];
    communityName = json['communityName'];
    coordinateSystem = json['coordinateSystem'];
    creator = json['creator'];
    creatorName = json['creatorName'];
    eventName = json['eventName'];
    gmtCreate = json['gmtCreate'];
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    position = json['position'];
    sourceContent = json['sourceContent'];
    sourceId = json['sourceId'];
    sourceKind = json['sourceKind'];
    sourceName = json['sourceName'];
    tenantId = json['tenantId'];
    tenantName = json['tenantName'];
  }
  int? alertId;
  String? alertSourceCode;
  String? communityId;
  String? communityName;
  String? coordinateSystem;
  String? creator;
  String? creatorName;
  String? eventName;
  String? gmtCreate;
  int? id;
  int? latitude;
  int? longitude;
  String? position;
  String? sourceContent;
  String? sourceId;
  String? sourceKind;
  String? sourceName;
  String? tenantId;
  String? tenantName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['alertId'] = alertId;
    map['alertSourceCode'] = alertSourceCode;
    map['communityId'] = communityId;
    map['communityName'] = communityName;
    map['coordinateSystem'] = coordinateSystem;
    map['creator'] = creator;
    map['creatorName'] = creatorName;
    map['eventName'] = eventName;
    map['gmtCreate'] = gmtCreate;
    map['id'] = id;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['position'] = position;
    map['sourceContent'] = sourceContent;
    map['sourceId'] = sourceId;
    map['sourceKind'] = sourceKind;
    map['sourceName'] = sourceName;
    map['tenantId'] = tenantId;
    map['tenantName'] = tenantName;
    return map;
  }

}