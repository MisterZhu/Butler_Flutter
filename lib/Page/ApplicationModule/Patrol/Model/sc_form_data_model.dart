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
  String? bizTag;
  String? type;

  CheckObject(
      {this.route, this.checkList, this.placeList, this.bizTag, this.type});

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
    bizTag = json['bizTag'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (route != null) {
      data['route'] = route!.toJson();
    }
    if (checkList != null) {
      data['checkList'] = checkList!.map((v) => v.toJson()).toList();
    }
    if (placeList != null) {
      data['placeList'] = placeList!.map((v) => v.toJson()).toList();
    }
    data['bizTag'] = bizTag;
    data['type'] = type;
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

  CheckList(
      {this.id,
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
        this.gmtModify});

  CheckList.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tenantId'] = tenantId;
    data['checkName'] = checkName;
    data['checkContent'] = checkContent;
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
    return data;
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
