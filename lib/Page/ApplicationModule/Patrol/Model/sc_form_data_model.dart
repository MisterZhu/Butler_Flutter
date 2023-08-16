import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_image_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_work_order_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/PropertyMaintenance/Model/sc_attachment_model.dart';

class FormDataModel {
  CheckObject? checkObject;

  FormDataModel({this.checkObject});

  FormDataModel.fromJson(Map<String, dynamic> json) {
    checkObject = json['checkObject'] != null
        ? CheckObject.fromJson(json['checkObject'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (checkObject != null) {
      data['checkObject'] = checkObject!.toJson();
    }
    return data;
  }
}

class CheckObject {
  Route? route;
  List<CheckList>? checkList;
  List<PlaceList>? placeList;
  Place? place;
  Device? device;
  String? bizTag;
  String? type;
  String? execWay;//新增字段-签到方式显示
  String? planPolicedType;//新增字段 1:巡查点 2：巡查组
  String? spaceName;
  String? field_custom_procDealExpTime;

  CheckObject(
      {this.route,
      this.checkList,
      this.placeList,
      this.bizTag,
      this.device,
      this.type,
      this.execWay,
      this.planPolicedType,
      this.place,
      this.spaceName,
      this.field_custom_procDealExpTime});

  CheckObject.fromJson(Map<String, dynamic> json) {
    route = json['route'] != null ? Route.fromJson(json['route']) : null;
    if (json['checkList'] != null) {
      checkList = <CheckList>[];
      json['checkList'].forEach((v) {
        checkList!.add(CheckList.fromJson(v));
      });
    }
    if (json['placeList'] != null) {
      placeList = <PlaceList>[];
      json['placeList'].forEach((v) {
        placeList!.add(PlaceList.fromJson(v));
      });
    }
    place = json['place'] != null ? Place.fromJson(json['place']) : null;
    device = json['device'] != null ? Device.fromJson(json['device']) : null;
    bizTag = json['bizTag'];
    type = json['type'];
    spaceName=json['spaceName'];
    field_custom_procDealExpTime=json['field_custom_procDealExpTime'];
    execWay = json['execWay'];
    planPolicedType = json['planPolicedType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (route != null) {
      data['route'] = route!.toJson();
    }
    if (checkList != null) {
      data['checkList'] = checkList!.map((v) => v.toJson()).toList();
    }
    if (place != null) {
      data['place'] = place?.toJson();
    }
    if (device != null) {
      data['device'] = device?.toJson();
    }
    if (placeList != null) {
      data['placeList'] = placeList!.map((v) => v.toJson()).toList();
    }
    data['bizTag'] = bizTag;
    data['type'] = type;
    data['execWay'] = execWay;
    data['planPolicedType'] = planPolicedType;
    return data;
  }
}

class Route {
  String? id;
  String? groupId;
  String? groupName;
  String? bizTag;
  int? policedClassId;
  String? policedClassIds;
  String? policedClassNames;
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
  String? tourRouteName;
  bool? dotRule;
  String? routeValidityPeriod;
  String? communityId;
  String? communityName;
  String? orgId;
  String? orgName;
  String? orgPath;
  int? placeNum;
  String? tenantId;

  Route(
      {this.id,
      this.groupId,
      this.groupName,
      this.bizTag,
      this.policedClassId,
      this.policedClassIds,
      this.policedClassNames,
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
      this.tourRouteName,
      this.dotRule,
      this.routeValidityPeriod,
      this.communityId,
      this.communityName,
      this.orgId,
      this.orgName,
      this.orgPath,
      this.placeNum,
      this.tenantId});

  Route.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['groupId'];
    groupName = json['groupName'];
    bizTag = json['bizTag'];
    policedClassId = json['policedClassId'];
    policedClassIds = json['policedClassIds'];
    policedClassNames = json['policedClassNames'];
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
    tourRouteName = json['tourRouteName'];
    dotRule = json['dotRule'];
    routeValidityPeriod = json['routeValidityPeriod'];
    communityId = json['communityId'];
    communityName = json['communityName'];
    orgId = json['orgId'];
    orgName = json['orgName'];
    orgPath = json['orgPath'];
    placeNum = json['placeNum'];
    tenantId = json['tenantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['groupId'] = groupId;
    data['groupName'] = groupName;
    data['bizTag'] = bizTag;
    data['policedClassId'] = policedClassId;
    data['policedClassIds'] = policedClassIds;
    data['policedClassNames'] = policedClassNames;
    data['policedClassName'] = policedClassName;
    data['disable'] = disable;
    data['execWay'] = execWay;
    data['extra'] = extra;
    data['creator'] = creator;
    data['operator'] = operator;
    data['creatorName'] = creatorName;
    data['operatorName'] = operatorName;
    data['gmtCreate'] = gmtCreate;
    data['gmtModify'] = gmtModify;
    data['tourRouteName'] = tourRouteName;
    data['dotRule'] = dotRule;
    data['routeValidityPeriod'] = routeValidityPeriod;
    data['communityId'] = communityId;
    data['communityName'] = communityName;
    data['orgId'] = orgId;
    data['orgName'] = orgName;
    data['orgPath'] = orgPath;
    data['placeNum'] = placeNum;
    data['tenantId'] = tenantId;
    return data;
  }
}

class CheckList {
  int? id;
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
  String? evaluateResult;
  String? comments;
  List<Attachment>? attachments;

  CheckList({
    this.id,
    this.tenantId,
    this.checkName,
    this.checkContent,
    this.comments,
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
    this.gmtModify,
    this.evaluateResult,
    this.attachments,
  });

  CheckList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenantId = json['tenantId'];
    checkName = json['checkName'];
    checkContent = json['checkContent'];
    comments = json['comments'];
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
    evaluateResult = json['evaluateResult'];
    if (json['attachments'] != null) {
      attachments = <Attachment>[];
      json['attachments'].forEach((v) {
        attachments?.add(Attachment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tenantId'] = tenantId;
    data['checkName'] = checkName;
    data['checkContent'] = checkContent;
    data['comments'] = comments;
    data['standardCode'] = standardCode;
    data['bizTag'] = bizTag;
    data['groupId'] = groupId;
    data['groupName'] = groupName;
    data['disable'] = disable;
    data['creator'] = creator;
    data['operator'] = operator;
    data['creatorName'] = creatorName;
    data['operatorName'] = operatorName;
    data['gmtCreate'] = gmtCreate;
    data['gmtModify'] = gmtModify;
    data['evaluateResult'] = evaluateResult;
    data['attachments'] = attachments;
    return data;
  }

  @override
  String toString() {
    return 'CheckList{id: $id, tenantId: $tenantId, checkName: $checkName, checkContent: $checkContent, standardCode: $standardCode, bizTag: $bizTag, groupId: $groupId, groupName: $groupName, disable: $disable, creator: $creator, operator: $operator, creatorName: $creatorName, operatorName: $operatorName, gmtCreate: $gmtCreate, gmtModify: $gmtModify, evaluateResult: $evaluateResult, attachments: $attachments}';
  }
}

class PlaceList {
  String? id;
  int? policedClassId;
  String? policedClassIds;
  String? policedClassNames;
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
  String? groupId;
  String? groupName;
  String? tenantId;
  String? projectId;
  String? projectName;
  String? orgId;
  String? orgName;
  int? spaceId;
  String? bizTag;

  PlaceList(
      {this.id,
      this.policedClassId,
      this.policedClassIds,
      this.policedClassNames,
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
      this.groupId,
      this.groupName,
      this.tenantId,
      this.projectId,
      this.projectName,
      this.orgId,
      this.orgName,
      this.spaceId,
      this.bizTag});

  PlaceList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    policedClassId = json['policedClassId'];
    policedClassIds = json['policedClassIds'];
    policedClassNames = json['policedClassNames'];
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
    groupId = json['groupId'];
    groupName = json['groupName'];
    tenantId = json['tenantId'];
    projectId = json['projectId'];
    projectName = json['projectName'];
    orgId = json['orgId'];
    orgName = json['orgName'];
    spaceId = json['spaceId'];
    bizTag = json['bizTag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['policedClassId'] = policedClassId;
    data['policedClassIds'] = policedClassIds;
    data['policedClassNames'] = policedClassNames;
    data['policedClassName'] = policedClassName;
    data['disable'] = disable;
    data['execWay'] = execWay;
    data['extra'] = extra;
    data['creator'] = creator;
    data['operator'] = operator;
    data['creatorName'] = creatorName;
    data['operatorName'] = operatorName;
    data['gmtCreate'] = gmtCreate;
    data['gmtModify'] = gmtModify;
    data['placeName'] = placeName;
    data['groupId'] = groupId;
    data['groupName'] = groupName;
    data['tenantId'] = tenantId;
    data['projectId'] = projectId;
    data['projectName'] = projectName;
    data['orgId'] = orgId;
    data['orgName'] = orgName;
    data['spaceId'] = spaceId;
    data['bizTag'] = bizTag;
    return data;
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
    this.bizTag,
  });

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
  int? policedClassId;
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
  int? spaceId;
  String? bizTag;
  String? field_custom_procDealExpTime;
  String? assigneeName;

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
    map['field_custom_procDealExpTime']=field_custom_procDealExpTime;
    map['assigneeName']=assigneeName;
    return map;
  }
}

class Device {
  Device({
    this.id,
    this.deviceName,
    this.deviceSn,
    this.deviceCode,
    this.spaceName,
    this.deviceLocation,
  });

  Device.fromJson(dynamic json) {
    id = json['id'];
    deviceName = json['deviceName'];
    deviceSn = json['deviceSn'];
    deviceCode = json['deviceCode'];
    deviceCode = json['spaceName'];
    deviceLocation = json['deviceLocation'];
  }

  String? id;
  String? deviceName;
  String? deviceSn;
  String? deviceCode;
  String? spaceName;
  String? deviceLocation;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['deviceName'] = deviceName;
    map['deviceSn'] = deviceSn;
    map['deviceCode'] = deviceCode;
    map['spaceName'] = spaceName;
    map['deviceLocation'] = deviceLocation;
    return map;
  }
}

class CellDetailList {
  String? checkId;
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
  String? evaluateResultStr;
  String? evaluateResult;
  String? comments;
  List<Attachment>? attachments;
  List<WorkOrder>? workOrders;

  CellDetailList({
    this.checkId,
    this.tenantId,
    this.checkName,
    this.checkContent,
    this.comments,
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
    this.gmtModify,
    this.evaluateResultStr,
    this.evaluateResult,
    this.attachments,
    this.workOrders,
  });

  CellDetailList.fromJson(Map<String, dynamic> json) {
    checkId = json['checkId'];
    tenantId = json['tenantId'];
    checkName = json['checkName'];
    checkContent = json['checkContent'];
    comments = json['comments'];
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
    evaluateResult = json['evaluateResult'];
    evaluateResultStr = json['evaluateResultStr'];
    if (json['attachments'] != null) {
      attachments = <Attachment>[];
      json['attachments'].forEach((v) {
        attachments?.add(Attachment.fromJson(v));
      });
    }
    if (json['workOrders'] != null) {
      workOrders = <WorkOrder>[];
      json['workOrders'].forEach((v) {
        workOrders?.add(WorkOrder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['checkId'] = checkId;
    data['tenantId'] = tenantId;
    data['checkName'] = checkName;
    data['checkContent'] = checkContent;
    data['comments'] = comments;
    data['standardCode'] = standardCode;
    data['bizTag'] = bizTag;
    data['groupId'] = groupId;
    data['groupName'] = groupName;
    data['disable'] = disable;
    data['creator'] = creator;
    data['operator'] = operator;
    data['creatorName'] = creatorName;
    data['operatorName'] = operatorName;
    data['gmtCreate'] = gmtCreate;
    data['gmtModify'] = gmtModify;
    data['evaluateResultStr'] = evaluateResultStr;
    data['evaluateResult'] = evaluateResult;
    data['attachments'] = attachments;
    return data;
  }
}
class DeviceTypeModel {
  final int id;
  final String qrCode;
  final String type;
  final String bizId;
  final String creator;
  final String operator;
  final String gmtCreate;
  final String gmtModify;

  DeviceTypeModel({
    required this.id,
    required this.qrCode,
    required this.type,
    required this.bizId,
    required this.creator,
    required this.operator,
    required this.gmtCreate,
    required this.gmtModify,
  });

  factory DeviceTypeModel.fromJson(Map<String, dynamic> json) {
    return DeviceTypeModel(
      id: json['id'],
      qrCode: json['qrCode'],
      type: json['type'],
      bizId: json['bizId'],
      creator: json['creator'],
      operator: json['operator'],
      gmtCreate: json['gmtCreate'],
      gmtModify: json['gmtModify'],
    );
  }
}
