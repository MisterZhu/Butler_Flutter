import 'dart:convert';
/// 默认配置数据model
/// id : 12048213332702
/// userId : "11165121145828"
/// tenantId : "eb1e1ad8-85af-42d0-ba3c-21229be19009"
/// type : 1
/// jsonValue : ""
/// priority : 0

SCDefaultConfigModel scDefaultConfigModelFromJson(String str) => SCDefaultConfigModel.fromJson(json.decode(str));
String scDefaultConfigModelToJson(SCDefaultConfigModel data) => json.encode(data.toJson());
class SCDefaultConfigModel {
  SCDefaultConfigModel({
      int? id, 
      String? userId, 
      String? tenantId, 
      int? type, 
      String? jsonValue, 
      int? priority,}){
    _id = id;
    _userId = userId;
    _tenantId = tenantId;
    _type = type;
    _jsonValue = jsonValue;
    _priority = priority;
}

  SCDefaultConfigModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _tenantId = json['tenantId'];
    _type = json['type'];
    _jsonValue = json['jsonValue'];
    _priority = json['priority'];
  }
  int? _id;
  String? _userId;
  String? _tenantId;
  int? _type;
  String? _jsonValue;
  int? _priority;
  SCDefaultConfigModel copyWith({  int? id,
  String? userId,
  String? tenantId,
  int? type,
  String? jsonValue,
  int? priority,
}) => SCDefaultConfigModel(  id: id ?? _id,
  userId: userId ?? _userId,
  tenantId: tenantId ?? _tenantId,
  type: type ?? _type,
  jsonValue: jsonValue ?? _jsonValue,
  priority: priority ?? _priority,
);
  int? get id => _id;
  String? get userId => _userId;
  String? get tenantId => _tenantId;
  int? get type => _type;
  String? get jsonValue => _jsonValue;
  int? get priority => _priority;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['tenantId'] = _tenantId;
    map['type'] = _type;
    map['jsonValue'] = _jsonValue;
    map['priority'] = _priority;
    return map;
  }

}