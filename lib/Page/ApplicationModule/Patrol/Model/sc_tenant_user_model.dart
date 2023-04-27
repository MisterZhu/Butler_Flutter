class SCTenantUserModel {
  SCTenantUserModel({
      this.account, 
      this.birthday, 
      this.checkedPermissionIds, 
      this.creatorName, 
      this.dataDesensitizeList, 
      this.defaultConfigList, 
      this.disabled, 
      this.email, 
      this.gender, 
      this.gmtCreate, 
      this.gmtModify, 
      this.halfCheckedPermissionIds, 
      this.headPicUri, 
      this.id, 
      this.linkedOrgNames, 
      this.mobileNum, 
      this.nickName, 
      this.operationProviderId, 
      this.operatorName, 
      this.orgIds, 
      this.orgNames, 
      this.roleIds, 
      this.roleNames, 
      this.state, 
      this.telephone, 
      this.tenantId, 
      this.tenantName, 
      this.userName,});

  SCTenantUserModel.fromJson(dynamic json) {
    account = json['account'];
    birthday = json['birthday'];
    checkedPermissionIds = json['checkedPermissionIds'] != null ? json['checkedPermissionIds'].cast<String>() : [];
    creatorName = json['creatorName'];
    if (json['dataDesensitizeList'] != null) {
      dataDesensitizeList = [];
      json['dataDesensitizeList'].forEach((v) {
        dataDesensitizeList?.add(DataDesensitizeList.fromJson(v));
      });
    }
    if (json['defaultConfigList'] != null) {
      defaultConfigList = [];
      json['defaultConfigList'].forEach((v) {
        defaultConfigList?.add(DefaultConfigList.fromJson(v));
      });
    }
    disabled = json['disabled'];
    email = json['email'];
    gender = json['gender'];
    gmtCreate = json['gmtCreate'];
    gmtModify = json['gmtModify'];
    halfCheckedPermissionIds = json['halfCheckedPermissionIds'] != null ? json['halfCheckedPermissionIds'].cast<String>() : [];
    headPicUri = json['headPicUri'] != null ? HeadPicUri.fromJson(json['headPicUri']) : null;
    id = json['id'];
    linkedOrgNames = json['linkedOrgNames'] != null ? json['linkedOrgNames'].cast<String>() : [];
    mobileNum = json['mobileNum'];
    nickName = json['nickName'];
    operationProviderId = json['operationProviderId'];
    operatorName = json['operatorName'];
    orgIds = json['orgIds'] != null ? json['orgIds'].cast<String>() : [];
    orgNames = json['orgNames'] != null ? json['orgNames'].cast<String>() : [];
    roleIds = json['roleIds'] != null ? json['roleIds'].cast<String>() : [];
    roleNames = json['roleNames'] != null ? json['roleNames'].cast<String>() : [];
    state = json['state'];
    telephone = json['telephone'];
    tenantId = json['tenantId'];
    tenantName = json['tenantName'];
    userName = json['userName'];
  }
  String? account;
  String? birthday;
  List<String>? checkedPermissionIds;
  String? creatorName;
  List<DataDesensitizeList>? dataDesensitizeList;
  List<DefaultConfigList>? defaultConfigList;
  bool? disabled;
  String? email;
  int? gender;
  String? gmtCreate;
  String? gmtModify;
  List<String>? halfCheckedPermissionIds;
  HeadPicUri? headPicUri;
  String? id;
  List<String>? linkedOrgNames;
  String? mobileNum;
  String? nickName;
  String? operationProviderId;
  String? operatorName;
  List<String>? orgIds;
  List<String>? orgNames;
  List<String>? roleIds;
  List<String>? roleNames;
  int? state;
  String? telephone;
  String? tenantId;
  String? tenantName;
  String? userName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account'] = account;
    map['birthday'] = birthday;
    map['checkedPermissionIds'] = checkedPermissionIds;
    map['creatorName'] = creatorName;
    if (dataDesensitizeList != null) {
      map['dataDesensitizeList'] = dataDesensitizeList?.map((v) => v.toJson()).toList();
    }
    if (defaultConfigList != null) {
      map['defaultConfigList'] = defaultConfigList?.map((v) => v.toJson()).toList();
    }
    map['disabled'] = disabled;
    map['email'] = email;
    map['gender'] = gender;
    map['gmtCreate'] = gmtCreate;
    map['gmtModify'] = gmtModify;
    map['halfCheckedPermissionIds'] = halfCheckedPermissionIds;
    if (headPicUri != null) {
      map['headPicUri'] = headPicUri?.toJson();
    }
    map['id'] = id;
    map['linkedOrgNames'] = linkedOrgNames;
    map['mobileNum'] = mobileNum;
    map['nickName'] = nickName;
    map['operationProviderId'] = operationProviderId;
    map['operatorName'] = operatorName;
    map['orgIds'] = orgIds;
    map['orgNames'] = orgNames;
    map['roleIds'] = roleIds;
    map['roleNames'] = roleNames;
    map['state'] = state;
    map['telephone'] = telephone;
    map['tenantId'] = tenantId;
    map['tenantName'] = tenantName;
    map['userName'] = userName;
    return map;
  }

}

class HeadPicUri {
  HeadPicUri({
      this.fileKey, 
      this.name, 
      this.size, 
      this.suffix, 
      this.type,});

  HeadPicUri.fromJson(dynamic json) {
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

class DefaultConfigList {
  DefaultConfigList({
      this.id, 
      this.jsonValue, 
      this.priority, 
      this.type,});

  DefaultConfigList.fromJson(dynamic json) {
    id = json['id'];
    jsonValue = json['jsonValue'];
    priority = json['priority'];
    type = json['type'];
  }
  int? id;
  String? jsonValue;
  int? priority;
  int? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['jsonValue'] = jsonValue;
    map['priority'] = priority;
    map['type'] = type;
    return map;
  }

}

class DataDesensitizeList {
  DataDesensitizeList({
      this.check, 
      this.export, 
      this.info, 
      this.type,});

  DataDesensitizeList.fromJson(dynamic json) {
    check = json['check'];
    export = json['export'];
    info = json['info'];
    type = json['type'];
  }
  bool? check;
  bool? export;
  String? info;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['check'] = check;
    map['export'] = export;
    map['info'] = info;
    map['type'] = type;
    return map;
  }

}