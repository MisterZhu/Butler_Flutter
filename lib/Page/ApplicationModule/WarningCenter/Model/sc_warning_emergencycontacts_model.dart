/// 预警详情-紧急联系人model
class SCWarningEmergencyContactsModel {
  SCWarningEmergencyContactsModel({
      this.id, 
      this.postInfo, 
      this.userId, 
      this.userInfo, 
      this.communityId, 
      this.responsibilityDescription, 
      this.emergencyContactLevel,});

  SCWarningEmergencyContactsModel.fromJson(dynamic json) {
    id = json['id'];
    postInfo = json['postInfo'] != null ? SCPostInfo.fromJson(json['postInfo']) : null;
    userId = json['userId'];
    userInfo = json['userInfo'] != null ? SCUserInfo.fromJson(json['userInfo']) : null;
    communityId = json['communityId'];
    responsibilityDescription = json['responsibilityDescription'];
    emergencyContactLevel = json['emergencyContactLevel'];
  }
  int? id;
  SCPostInfo? postInfo;
  String? userId;
  SCUserInfo? userInfo;
  String? communityId;
  String? responsibilityDescription;
  int? emergencyContactLevel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (postInfo != null) {
      map['postInfo'] = postInfo?.toJson();
    }
    map['userId'] = userId;
    if (userInfo != null) {
      map['userInfo'] = userInfo?.toJson();
    }
    map['communityId'] = communityId;
    map['responsibilityDescription'] = responsibilityDescription;
    map['emergencyContactLevel'] = emergencyContactLevel;
    return map;
  }

}

class SCUserInfo {
  SCUserInfo({
      this.id, 
      this.account, 
      this.userName, 
      this.nickName, 
      this.mobileNum, 
      this.orgIds,});

  SCUserInfo.fromJson(dynamic json) {
    id = json['id'];
    account = json['account'];
    userName = json['userName'];
    nickName = json['nickName'];
    mobileNum = json['mobileNum'];
    orgIds = json['orgIds'] != null ? json['orgIds'].cast<int>() : [];
  }
  String? id;
  String? account;
  String? userName;
  String? nickName;
  String? mobileNum;
  List<int>? orgIds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['account'] = account;
    map['userName'] = userName;
    map['nickName'] = nickName;
    map['mobileNum'] = mobileNum;
    map['orgIds'] = orgIds;
    return map;
  }

}

class SCPostInfo {
  SCPostInfo({
      this.id, 
      this.type, 
      this.name,});

  SCPostInfo.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
  }
  int? id;
  String? type;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['name'] = name;
    return map;
  }

}