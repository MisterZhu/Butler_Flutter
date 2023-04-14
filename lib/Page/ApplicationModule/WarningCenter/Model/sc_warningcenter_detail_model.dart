import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/Model/sc_warningcenter_model.dart';

/// 预警详情model
class SCWarningCenterDetailModel {
  SCWarningCenterDetailModel({
      this.id, 
      this.alertCode, 
      this.alertSource, 
      this.communityId, 
      this.communityName, 
      this.ruleId, 
      this.ruleName, 
      this.levelId, 
      this.levelName, 
      this.alertPlanName, 
      this.status, 
      this.statusName, 
      this.confirmResult, 
      this.confirmResultName, 
      this.generationTime, 
      this.beginTime, 
      this.endTime, 
      this.operator, 
      this.operatorName, 
      this.gmtModify, 
      this.gmtCreate, 
      this.alertExplain, 
      this.fileVoList, 
      this.alertContext, 
      this.alertDetailedVS, 
      this.alertWorkOrderVList, 
      this.alertType,});

  SCWarningCenterDetailModel.fromJson(dynamic json) {
    id = json['id'];
    alertCode = json['alertCode'];
    alertSource = json['alertSource'];
    communityId = json['communityId'];
    communityName = json['communityName'];
    ruleId = json['ruleId'];
    ruleName = json['ruleName'];
    levelId = json['levelId'];
    levelName = json['levelName'];
    alertPlanName = json['alertPlanName'];
    status = json['status'];
    statusName = json['statusName'];
    confirmResult = json['confirmResult'];
    confirmResultName = json['confirmResultName'];
    generationTime = json['generationTime'];
    beginTime = json['beginTime'];
    endTime = json['endTime'];
    operator = json['operator'];
    operatorName = json['operatorName'];
    gmtModify = json['gmtModify'];
    gmtCreate = json['gmtCreate'];
    alertExplain = json['alertExplain'];
    if (json['fileVoList'] != null) {
      fileVoList = [];
      json['fileVoList'].forEach((v) {
        fileVoList?.add(SCFileVoList.fromJson(v));
      });
    }
    alertContext = json['alertContext'];
    if (json['alertDetailedVS'] != null) {
      alertDetailedVS = [];
      json['alertDetailedVS'].forEach((v) {
        alertDetailedVS?.add(SCAlertDetailedVs.fromJson(v));
      });
    }
    if (json['alertWorkOrderVList'] != null) {
      alertWorkOrderVList = [];
      json['alertWorkOrderVList'].forEach((v) {
        alertWorkOrderVList?.add(SCAlertWorkOrderVList.fromJson(v));
      });
    }
    alertType = json['alertType'];
  }
  int? id;
  String? alertCode;
  String? alertSource;
  String? communityId;
  String? communityName;
  int? ruleId;
  String? ruleName;
  int? levelId;
  String? levelName;
  String? alertPlanName;
  int? status;
  String? statusName;
  dynamic confirmResult;
  dynamic confirmResultName;
  String? generationTime;
  dynamic beginTime;
  dynamic endTime;
  dynamic operator;
  dynamic operatorName;
  String? gmtModify;
  String? gmtCreate;
  dynamic alertExplain;
  List<dynamic>? fileVoList;
  String? alertContext;
  List<SCAlertDetailedVs>? alertDetailedVS;
  List<SCAlertWorkOrderVList>? alertWorkOrderVList;
  String? alertType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['alertCode'] = alertCode;
    map['alertSource'] = alertSource;
    map['communityId'] = communityId;
    map['communityName'] = communityName;
    map['ruleId'] = ruleId;
    map['ruleName'] = ruleName;
    map['levelId'] = levelId;
    map['levelName'] = levelName;
    map['alertPlanName'] = alertPlanName;
    map['status'] = status;
    map['statusName'] = statusName;
    map['confirmResult'] = confirmResult;
    map['confirmResultName'] = confirmResultName;
    map['generationTime'] = generationTime;
    map['beginTime'] = beginTime;
    map['endTime'] = endTime;
    map['operator'] = operator;
    map['operatorName'] = operatorName;
    map['gmtModify'] = gmtModify;
    map['gmtCreate'] = gmtCreate;
    map['alertExplain'] = alertExplain;
    if (fileVoList != null) {
      map['fileVoList'] = fileVoList?.map((v) => v.toJson()).toList();
    }
    map['alertContext'] = alertContext;
    if (alertDetailedVS != null) {
      map['alertDetailedVS'] = alertDetailedVS?.map((v) => v.toJson()).toList();
    }
    if (alertWorkOrderVList != null) {
      map['alertWorkOrderVList'] = alertWorkOrderVList?.map((v) => v.toJson()).toList();
    }
    map['alertType'] = alertType;
    return map;
  }

}

class SCAlertWorkOrderVList {
  SCAlertWorkOrderVList({
      this.alertId, 
      this.workOrderId, 
      this.sortNum, 
      this.serialNumber,});

  SCAlertWorkOrderVList.fromJson(dynamic json) {
    alertId = json['alertId'];
    workOrderId = json['workOrderId'];
    sortNum = json['sortNum'];
    serialNumber = json['serialNumber'];
  }
  int? alertId;
  String? workOrderId;
  int? sortNum;
  String? serialNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['alertId'] = alertId;
    map['workOrderId'] = workOrderId;
    map['sortNum'] = sortNum;
    map['serialNumber'] = serialNumber;
    return map;
  }

}

class SCAlertDetailedVs {
  SCAlertDetailedVs({
      this.alertSource, 
      this.deviceCode, 
      this.position, 
      this.firstAlertTime, 
      this.nowAlertTime, 
      this.reportTime, 
      this.alertContext, 
      this.addressCode, 
      this.loopCode, 
      this.humanCode, 
      this.eventName, 
      this.alertSourceVList,});

  SCAlertDetailedVs.fromJson(dynamic json) {
    alertSource = json['alertSource'];
    deviceCode = json['deviceCode'];
    position = json['position'];
    firstAlertTime = json['firstAlertTime'];
    nowAlertTime = json['nowAlertTime'];
    reportTime = json['reportTime'];
    alertContext = json['alertContext'];
    addressCode = json['addressCode'];
    loopCode = json['loopCode'];
    humanCode = json['humanCode'];
    eventName = json['eventName'];
    if (json['alertSourceVList'] != null) {
      alertSourceVList = [];
      json['alertSourceVList'].forEach((v) {
        alertSourceVList?.add(SCAlertSourceVList.fromJson(v));
      });
    }
  }
  String? alertSource;
  dynamic deviceCode;
  String? position;
  String? firstAlertTime;
  String? nowAlertTime;
  int? reportTime;
  String? alertContext;
  String? addressCode;
  String? loopCode;
  dynamic humanCode;
  String? eventName;
  List<SCAlertSourceVList>? alertSourceVList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['alertSource'] = alertSource;
    map['deviceCode'] = deviceCode;
    map['position'] = position;
    map['firstAlertTime'] = firstAlertTime;
    map['nowAlertTime'] = nowAlertTime;
    map['reportTime'] = reportTime;
    map['alertContext'] = alertContext;
    map['addressCode'] = addressCode;
    map['loopCode'] = loopCode;
    map['humanCode'] = humanCode;
    map['eventName'] = eventName;
    if (alertSourceVList != null) {
      map['alertSourceVList'] = alertSourceVList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class SCAlertSourceVList {
  SCAlertSourceVList({
      this.id, 
      this.alertId, 
      this.alertSourceCode, 
      this.tenantId, 
      this.tenantName, 
      this.communityId, 
      this.communityName, 
      this.sourceId, 
      this.sourceName, 
      this.sourceContent, 
      this.eventName, 
      this.position, 
      this.sourceKind, 
      this.longitude, 
      this.latitude, 
      this.coordinateSystem, 
      this.creator, 
      this.creatorName, 
      this.gmtCreate,});

  SCAlertSourceVList.fromJson(dynamic json) {
    id = json['id'];
    alertId = json['alertId'];
    alertSourceCode = json['alertSourceCode'];
    tenantId = json['tenantId'];
    tenantName = json['tenantName'];
    communityId = json['communityId'];
    communityName = json['communityName'];
    sourceId = json['sourceId'];
    sourceName = json['sourceName'];
    sourceContent = json['sourceContent'];
    eventName = json['eventName'];
    position = json['position'];
    sourceKind = json['sourceKind'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    coordinateSystem = json['coordinateSystem'];
    creator = json['creator'];
    creatorName = json['creatorName'];
    gmtCreate = json['gmtCreate'];
  }
  int? id;
  int? alertId;
  String? alertSourceCode;
  String? tenantId;
  String? tenantName;
  String? communityId;
  String? communityName;
  String? sourceId;
  String? sourceName;
  String? sourceContent;
  String? eventName;
  String? position;
  dynamic sourceKind;
  dynamic longitude;
  dynamic latitude;
  dynamic coordinateSystem;
  String? creator;
  String? creatorName;
  String? gmtCreate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['alertId'] = alertId;
    map['alertSourceCode'] = alertSourceCode;
    map['tenantId'] = tenantId;
    map['tenantName'] = tenantName;
    map['communityId'] = communityId;
    map['communityName'] = communityName;
    map['sourceId'] = sourceId;
    map['sourceName'] = sourceName;
    map['sourceContent'] = sourceContent;
    map['eventName'] = eventName;
    map['position'] = position;
    map['sourceKind'] = sourceKind;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    map['coordinateSystem'] = coordinateSystem;
    map['creator'] = creator;
    map['creatorName'] = creatorName;
    map['gmtCreate'] = gmtCreate;
    return map;
  }

}