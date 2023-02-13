/// id : "125606113932228"
/// pid : ""
/// dictionaryCode : "WAREHOUSING"
/// tenantId : ""
/// parentName : ""
/// parentId : ""
/// name : "领料归还入库"
/// code : 4
/// level : 1
/// sort : 4
/// remarks : ""
/// disabled : false

/// 入库类型、出库类型model

class SCEntryTypeModel {
  SCEntryTypeModel({
      String? id, 
      String? pid, 
      String? dictionaryCode,
      String? tenantId, 
      String? parentName, 
      String? parentId, 
      String? name,
      String? code,
      int? level, 
      int? sort, 
      String? remarks, 
      bool? disabled,}){
    _id = id;
    _pid = pid;
    _dictionaryCode = dictionaryCode;
    _tenantId = tenantId;
    _parentName = parentName;
    _parentId = parentId;
    _name = name;
    _code = code;
    _level = level;
    _sort = sort;
    _remarks = remarks;
    _disabled = disabled;
}

  SCEntryTypeModel.fromJson(dynamic json) {
    _id = json['id'];
    _pid = json['pid'];
    _dictionaryCode = json['dictionaryCode'];
    _tenantId = json['tenantId'];
    _parentName = json['parentName'];
    _parentId = json['parentId'];
    _name = json['name'];
    _code = json['code'];
    _level = json['level'];
    _sort = json['sort'];
    _remarks = json['remarks'];
    _disabled = json['disabled'];
  }
  String? _id;
  String? _pid;
  String? _dictionaryCode;
  String? _tenantId;
  String? _parentName;
  String? _parentId;
  String? _name;
  String? _code;
  int? _level;
  int? _sort;
  String? _remarks;
  bool? _disabled;
  SCEntryTypeModel copyWith({  String? id,
  String? pid,
  String? dictionaryCode,
  String? tenantId,
  String? parentName,
  String? parentId,
  String? name,
  String? code,
  int? level,
  int? sort,
  String? remarks,
  bool? disabled,
}) => SCEntryTypeModel(  id: id ?? _id,
  pid: pid ?? _pid,
  dictionaryCode: dictionaryCode ?? _dictionaryCode,
  tenantId: tenantId ?? _tenantId,
  parentName: parentName ?? _parentName,
  parentId: parentId ?? _parentId,
  name: name ?? _name,
  code: code ?? _code,
  level: level ?? _level,
  sort: sort ?? _sort,
  remarks: remarks ?? _remarks,
  disabled: disabled ?? _disabled,
);
  String? get id => _id;
  String? get pid => _pid;
  String? get dictionaryCode => _dictionaryCode;
  String? get tenantId => _tenantId;
  String? get parentName => _parentName;
  String? get parentId => _parentId;
  String? get name => _name;
  String? get code => _code;
  int? get level => _level;
  int? get sort => _sort;
  String? get remarks => _remarks;
  bool? get disabled => _disabled;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['pid'] = _pid;
    map['dictionaryCode'] = _dictionaryCode;
    map['tenantId'] = _tenantId;
    map['parentName'] = _parentName;
    map['parentId'] = _parentId;
    map['name'] = _name;
    map['code'] = _code;
    map['level'] = _level;
    map['sort'] = _sort;
    map['remarks'] = _remarks;
    map['disabled'] = _disabled;
    return map;
  }

}