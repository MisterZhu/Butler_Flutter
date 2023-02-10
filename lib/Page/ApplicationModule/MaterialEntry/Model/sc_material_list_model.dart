/// barCode : ""
/// classifyId : ""
/// classifyName : ""
/// code : ""
/// enabled : true
/// id : ""
/// name : ""
/// norms : ""
/// pic : ""
/// picFileVo : {"fileKey":"","name":"","size":0,"suffix":"","type":0}
/// referPrice : 0
/// remark : ""
/// thirdCode : ""
/// unitId : ""
/// unitName : ""

/// 物资列表model

class SCMaterialListModel {
  SCMaterialListModel({
      String? barCode, 
      String? classifyId, 
      String? classifyName, 
      String? code, 
      bool? enabled, 
      String? id, 
      String? name, 
      String? norms, 
      String? pic, 
      PicFileVo? picFileVo, 
      double? referPrice,
      String? remark, 
      String? thirdCode, 
      String? unitId, 
      String? unitName,}){
    _barCode = barCode;
    _classifyId = classifyId;
    _classifyName = classifyName;
    _code = code;
    _enabled = enabled;
    _id = id;
    _name = name;
    _norms = norms;
    _pic = pic;
    _picFileVo = picFileVo;
    _referPrice = referPrice;
    _remark = remark;
    _thirdCode = thirdCode;
    _unitId = unitId;
    _unitName = unitName;
}

  SCMaterialListModel.fromJson(dynamic json) {
    _barCode = json['barCode'];
    _classifyId = json['classifyId'];
    _classifyName = json['classifyName'];
    _code = json['code'];
    _enabled = json['enabled'];
    _id = json['id'];
    _name = json['name'];
    _norms = json['norms'];
    _pic = json['pic'];
    _picFileVo = json['picFileVo'] != null ? PicFileVo.fromJson(json['picFileVo']) : null;
    _referPrice = json['referPrice'];
    _remark = json['remark'];
    _thirdCode = json['thirdCode'];
    _unitId = json['unitId'];
    _unitName = json['unitName'];
  }
  String? _barCode;
  String? _classifyId;
  String? _classifyName;
  String? _code;
  bool? _enabled;
  String? _id;
  String? _name;
  String? _norms;
  String? _pic;
  PicFileVo? _picFileVo;
  double? _referPrice;
  String? _remark;
  String? _thirdCode;
  String? _unitId;
  String? _unitName;
  SCMaterialListModel copyWith({  String? barCode,
  String? classifyId,
  String? classifyName,
  String? code,
  bool? enabled,
  String? id,
  String? name,
  String? norms,
  String? pic,
  PicFileVo? picFileVo,
  double? referPrice,
  String? remark,
  String? thirdCode,
  String? unitId,
  String? unitName,
}) => SCMaterialListModel(  barCode: barCode ?? _barCode,
  classifyId: classifyId ?? _classifyId,
  classifyName: classifyName ?? _classifyName,
  code: code ?? _code,
  enabled: enabled ?? _enabled,
  id: id ?? _id,
  name: name ?? _name,
  norms: norms ?? _norms,
  pic: pic ?? _pic,
  picFileVo: picFileVo ?? _picFileVo,
  referPrice: referPrice ?? _referPrice,
  remark: remark ?? _remark,
  thirdCode: thirdCode ?? _thirdCode,
  unitId: unitId ?? _unitId,
  unitName: unitName ?? _unitName,
);
  String? get barCode => _barCode;
  String? get classifyId => _classifyId;
  String? get classifyName => _classifyName;
  String? get code => _code;
  bool? get enabled => _enabled;
  String? get id => _id;
  String? get name => _name;
  String? get norms => _norms;
  String? get pic => _pic;
  PicFileVo? get picFileVo => _picFileVo;
  double? get referPrice => _referPrice;
  String? get remark => _remark;
  String? get thirdCode => _thirdCode;
  String? get unitId => _unitId;
  String? get unitName => _unitName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['barCode'] = _barCode;
    map['classifyId'] = _classifyId;
    map['classifyName'] = _classifyName;
    map['code'] = _code;
    map['enabled'] = _enabled;
    map['id'] = _id;
    map['name'] = _name;
    map['norms'] = _norms;
    map['pic'] = _pic;
    if (_picFileVo != null) {
      map['picFileVo'] = _picFileVo?.toJson();
    }
    map['referPrice'] = _referPrice;
    map['remark'] = _remark;
    map['thirdCode'] = _thirdCode;
    map['unitId'] = _unitId;
    map['unitName'] = _unitName;
    return map;
  }

}

/// fileKey : ""
/// name : ""
/// size : 0
/// suffix : ""
/// type : 0

class PicFileVo {
  PicFileVo({
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

  PicFileVo.fromJson(dynamic json) {
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
PicFileVo copyWith({  String? fileKey,
  String? name,
  int? size,
  String? suffix,
  int? type,
}) => PicFileVo(  fileKey: fileKey ?? _fileKey,
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