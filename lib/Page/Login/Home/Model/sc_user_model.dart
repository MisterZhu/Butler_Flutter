import 'dart:convert';
/// email : "88899@qq.com"
/// id : "11165121145828"
/// account : "13221028695"
/// token : ""
/// roleIds : ["111671645741505","111678806188511","111671756697508"]
/// roleNames : ["研发","账号管理员","搜索配置员"]
/// userName : ""
/// nickName : ""
/// headPicUri : {}
/// tenantId : "eb1e1ad8-85af-42d0-ba3c-21229be19009"
/// tenantName : "海滨租户"
/// orgIds : [894]
/// mobileNum : "13221028695"
/// state : 0
/// gender : 1
/// creatorName : "wang"
/// gmtCreate : "2022-09-02 06:13:31"
/// operatorName : ""
/// gmtModify : "2022-12-02 11:44:19"
/// defaultConfigList : [{}]

SCUserModel scUserModelFromJson(String str) => SCUserModel.fromJson(json.decode(str));
String scUserModelToJson(SCUserModel data) => json.encode(data.toJson());
class SCUserModel {
  SCUserModel({
      String? email, 
      String? id, 
      String? account, 
      String? token, 
      List<String>? roleIds, 
      List<String>? roleNames, 
      String? userName, 
      String? nickName, 
      dynamic headPicUri, 
      String? tenantId, 
      String? tenantName, 
      List<int>? orgIds, 
      String? mobileNum, 
      int? state, 
      int? gender, 
      String? creatorName, 
      String? gmtCreate, 
      String? operatorName, 
      String? gmtModify, 
      List<Map<String, dynamic>>? defaultConfigList,}){
    _email = email;
    _id = id;
    _account = account;
    _token = token;
    _roleIds = roleIds;
    _roleNames = roleNames;
    _userName = userName;
    _nickName = nickName;
    _headPicUri = headPicUri;
    _tenantId = tenantId;
    _tenantName = tenantName;
    _orgIds = orgIds;
    _mobileNum = mobileNum;
    _state = state;
    _gender = gender;
    _creatorName = creatorName;
    _gmtCreate = gmtCreate;
    _operatorName = operatorName;
    _gmtModify = gmtModify;
    _defaultConfigList = defaultConfigList;
}

  SCUserModel.fromJson(dynamic json) {
    _email = json['email'];
    _id = json['id'];
    _account = json['account'];
    _token = json['token'];
    _roleIds = json['roleIds'] != null ? json['roleIds'].cast<String>() : [];
    _roleNames = json['roleNames'] != null ? json['roleNames'].cast<String>() : [];
    _userName = json['userName'];
    _nickName = json['nickName'];
    _headPicUri = json['headPicUri'];
    _tenantId = json['tenantId'];
    _tenantName = json['tenantName'];
    _orgIds = json['orgIds'] != null ? json['orgIds'].cast<int>() : [];
    _mobileNum = json['mobileNum'];
    _state = json['state'];
    _gender = json['gender'];
    _creatorName = json['creatorName'];
    _gmtCreate = json['gmtCreate'];
    _operatorName = json['operatorName'];
    _gmtModify = json['gmtModify'];
    if (json['defaultConfigList'] != null) {
      _defaultConfigList = [];
      json['defaultConfigList'].forEach((v) {
        _defaultConfigList?.add(v);
      });
    }
  }
  String? _email;
  String? _id;
  String? _account;
  String? _token;
  List<String>? _roleIds;
  List<String>? _roleNames;
  String? _userName;
  String? _nickName;
  dynamic _headPicUri;
  String? _tenantId;
  String? _tenantName;
  List<int>? _orgIds;
  String? _mobileNum;
  int? _state;
  int? _gender;
  String? _creatorName;
  String? _gmtCreate;
  String? _operatorName;
  String? _gmtModify;
  List<Map<String, dynamic>>? _defaultConfigList;
SCUserModel copyWith({  String? email,
  String? id,
  String? account,
  String? token,
  List<String>? roleIds,
  List<String>? roleNames,
  String? userName,
  String? nickName,
  dynamic headPicUri,
  String? tenantId,
  String? tenantName,
  List<int>? orgIds,
  String? mobileNum,
  int? state,
  int? gender,
  String? creatorName,
  String? gmtCreate,
  String? operatorName,
  String? gmtModify,
  List<Map<String, dynamic>>? defaultConfigList,
}) => SCUserModel(  email: email ?? _email,
  id: id ?? _id,
  account: account ?? _account,
  token: token ?? _token,
  roleIds: roleIds ?? _roleIds,
  roleNames: roleNames ?? _roleNames,
  userName: userName ?? _userName,
  nickName: nickName ?? _nickName,
  headPicUri: headPicUri ?? _headPicUri,
  tenantId: tenantId ?? _tenantId,
  tenantName: tenantName ?? _tenantName,
  orgIds: orgIds ?? _orgIds,
  mobileNum: mobileNum ?? _mobileNum,
  state: state ?? _state,
  gender: gender ?? _gender,
  creatorName: creatorName ?? _creatorName,
  gmtCreate: gmtCreate ?? _gmtCreate,
  operatorName: operatorName ?? _operatorName,
  gmtModify: gmtModify ?? _gmtModify,
  defaultConfigList: defaultConfigList ?? _defaultConfigList,
);
  String? get email => _email;
  String? get id => _id;
  String? get account => _account;
  String? get token => _token;
  List<String>? get roleIds => _roleIds;
  List<String>? get roleNames => _roleNames;
  String? get userName => _userName;
  String? get nickName => _nickName;
  dynamic get headPicUri => _headPicUri;
  String? get tenantId => _tenantId;
  String? get tenantName => _tenantName;
  List<int>? get orgIds => _orgIds;
  String? get mobileNum => _mobileNum;
  int? get state => _state;
  int? get gender => _gender;
  String? get creatorName => _creatorName;
  String? get gmtCreate => _gmtCreate;
  String? get operatorName => _operatorName;
  String? get gmtModify => _gmtModify;
  List<Map<String, dynamic>>? get defaultConfigList => _defaultConfigList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['id'] = _id;
    map['account'] = _account;
    map['token'] = _token;
    map['roleIds'] = _roleIds;
    map['roleNames'] = _roleNames;
    map['userName'] = _userName;
    map['nickName'] = _nickName;
    map['headPicUri'] = _headPicUri;
    map['tenantId'] = _tenantId;
    map['tenantName'] = _tenantName;
    map['orgIds'] = _orgIds;
    map['mobileNum'] = _mobileNum;
    map['state'] = _state;
    map['gender'] = _gender;
    map['creatorName'] = _creatorName;
    map['gmtCreate'] = _gmtCreate;
    map['operatorName'] = _operatorName;
    map['gmtModify'] = _gmtModify;
    if (_defaultConfigList != null) {
      map['defaultConfigList'] = _defaultConfigList;
    }
    return map;
  }

  /// set token
  set token(String? value) {
    _token = value;
  }

}