/// tenantId : ""
/// tenantLogo : {"fileKey":"","name":"","size":0,"suffix":"","type":0}
/// tenantName : ""
/// userId : ""

class SCTenantListModel {
  SCTenantListModel({
      String? tenantId, 
      TenantLogo? tenantLogo, 
      String? tenantName, 
      String? userId,}){
    _tenantId = tenantId;
    _tenantLogo = tenantLogo;
    _tenantName = tenantName;
    _userId = userId;
}

  SCTenantListModel.fromJson(dynamic json) {
    _tenantId = json['tenantId'];
    _tenantLogo = json['tenantLogo'] != null ? TenantLogo.fromJson(json['tenantLogo']) : null;
    _tenantName = json['tenantName'];
    _userId = json['userId'];
  }
  String? _tenantId;
  TenantLogo? _tenantLogo;
  String? _tenantName;
  String? _userId;
  SCTenantListModel copyWith({  String? tenantId,
  TenantLogo? tenantLogo,
  String? tenantName,
  String? userId,
}) => SCTenantListModel(  tenantId: tenantId ?? _tenantId,
  tenantLogo: tenantLogo ?? _tenantLogo,
  tenantName: tenantName ?? _tenantName,
  userId: userId ?? _userId,
);
  String? get tenantId => _tenantId;
  TenantLogo? get tenantLogo => _tenantLogo;
  String? get tenantName => _tenantName;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tenantId'] = _tenantId;
    if (_tenantLogo != null) {
      map['tenantLogo'] = _tenantLogo?.toJson();
    }
    map['tenantName'] = _tenantName;
    map['userId'] = _userId;
    return map;
  }

}

/// fileKey : ""
/// name : ""
/// size : 0
/// suffix : ""
/// type : 0

class TenantLogo {
  TenantLogo({
      String? fileKey, 
      String? name, 
      int? size, 
      String? suffix, 
      int? type,}){
    _fileKey = fileKey;
    _name = name;
    _size = size;
    _suffix = suffix;
    _type = type;
}

  TenantLogo.fromJson(dynamic json) {
    _fileKey = json['fileKey'];
    _name = json['name'];
    _size = json['size'];
    _suffix = json['suffix'];
    _type = json['type'];
  }
  String? _fileKey;
  String? _name;
  int? _size;
  String? _suffix;
  int? _type;
TenantLogo copyWith({  String? fileKey,
  String? name,
  int? size,
  String? suffix,
  int? type,
}) => TenantLogo(  fileKey: fileKey ?? _fileKey,
  name: name ?? _name,
  size: size ?? _size,
  suffix: suffix ?? _suffix,
  type: type ?? _type,
);
  String? get fileKey => _fileKey;
  String? get name => _name;
  int? get size => _size;
  String? get suffix => _suffix;
  int? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fileKey'] = _fileKey;
    map['name'] = _name;
    map['size'] = _size;
    map['suffix'] = _suffix;
    map['type'] = _type;
    return map;
  }

}