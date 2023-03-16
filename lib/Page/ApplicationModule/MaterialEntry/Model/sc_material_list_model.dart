/// barCode : ""
/// classifyId : "" 物资分类ID
/// classifyName : "" 物资分类名称
/// code : ""   关联物资编码
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
/// "num": 0,  数量
/// "changeId": "关联调拨ID"
/// "locations": "货位信息json数据"

/// 物资列表model

class SCMaterialListModel {
  SCMaterialListModel({
    String? barCode,
    String? classifyId,
    String? classifyName,
    String? code,
    bool? enabled,
    String? id,
    String? materialId,
    String? inId, // 关联入库id
    String? reportId, // 关联报损ID
    String? name,
    String? materialName,
    String? norms,
    String? pic,
    PicFileVo? picFileVo,
    num? referPrice,
    int? number,  // 账存数量
    int? checkNum, // 盘点数量
    int? resultNum, // 赢亏数量
    int? result, // 盘点结果（1：盘盈，0：盘平，-1：盘亏）
    String? checkId, // 关联盘点id
    String? remark,
    String? thirdCode,
    String? unitId,
    String? unitName,
    String? changeId,
    String? locations,
    int? localNum,// 本地物资数量，默认1
    bool? isSelect,// 是否选中
    String? purchaseId,// 采购单id
    String? purchaseCode,// 采购单号
    String? purchaseDetailId,
    int? materialType, //物资类型：1固定资产，2易耗品
    String? assetId,
    String? assetName,
    String? assetCode,
    String? materialCode,
    String? belongOrgId,
    String? belongOrgName,
    String? fetchOrgId,
    String? fetchOrgName,
    String? fetchUserId,
    String? fetchUserName,
    String? gmtFetch,
    int? returnCheck, //0-无需归还，1-需要归还
    int? backNum, //归还数量
    int? unBackNum, //待归还数量
  }) {
    _barCode = barCode;
    _classifyId = classifyId;
    _classifyName = classifyName;
    _code = code;
    _enabled = enabled;
    _id = id;
    _materialId = materialId;
    _inId = inId;
    _reportId = reportId;
    _name = name;
    _materialName = materialName;
    _norms = norms;
    _pic = pic;
    _picFileVo = picFileVo;
    _referPrice = referPrice;
    _number = number;
    _checkNum = checkNum;
    _resultNum = resultNum;
    _result = result;
    _checkId = checkId;
    _remark = remark;
    _thirdCode = thirdCode;
    _unitId = unitId;
    _unitName = unitName;
    _changeId = changeId;
    _locations = locations;
    _localNum = localNum;
    _isSelect = isSelect;
    _purchaseId = purchaseId;
    _purchaseCode = purchaseCode;
    _purchaseDetailId = purchaseDetailId;
    _materialType = materialType;
    _assetId = assetId;
    _assetName = assetName;
    _assetCode = assetCode;
    _materialCode = materialCode;
    _belongOrgId = belongOrgId;
    _belongOrgName = belongOrgName;
    _fetchOrgId = fetchOrgId;
    _fetchOrgName = fetchOrgName;
    _fetchUserId = fetchUserId;
    _fetchUserName = fetchUserName;
    _gmtFetch = gmtFetch;
    _returnCheck = returnCheck;
    _unBackNum = unBackNum;
    _backNum = backNum;
  }

  SCMaterialListModel.fromJson(dynamic json) {
    _barCode = json['barCode'];
    _classifyId = json['classifyId'];
    _classifyName = json['classifyName'];
    _code = json['code'];
    _enabled = json['enabled'];
    _id = json['id'];
    _materialId = json['materialId'];
    _inId = json['inId'];
    _reportId = json['reportId'];
    _name = json['name'];
    _materialName = json['materialName'];
    _norms = json['norms'];
    _pic = json['pic'];
    _picFileVo = json['picFileVo'] != null
        ? PicFileVo.fromJson(json['picFileVo'])
        : null;
    _referPrice = json['referPrice'];
    _number = json['num'];
    _checkNum = json['checkNum'];
    _resultNum = json['resultNum'];
    _result = json['result'];
    _checkId = json['checkId'];
    _remark = json['remark'];
    _thirdCode = json['thirdCode'];
    _unitId = json['unitId'];
    _unitName = json['unitName'];
    _changeId = json['changeId'];
    _locations = json['locations'];
    _localNum = 1;
    _isSelect = json['isSelect'];
    _purchaseId = json['purchaseId'];
    _purchaseCode = json['purchaseCode'];
    _purchaseDetailId = json['purchaseDetailId'];
    _materialType = json['materialType'];
    _assetId = json['assetId'];
    _assetName = json['assetName'];
    _assetCode = json['assetCode'];
    _materialCode = json['materialCode'];
    _belongOrgId = json['belongOrgId'];
    _belongOrgName = json['belongOrgName'];
    _fetchOrgId = json['fetchOrgId'];
    _fetchOrgName = json['fetchOrgName'];
    _fetchUserId = json['fetchUserId'];
    _fetchUserName = json['fetchUserName'];
    _gmtFetch = json['gmtFetch'];
    _returnCheck = json['returnCheck'] ?? 1;
    _unBackNum = json['unBackNum'];
    _backNum = json['backNum'];
  }
  String? _barCode;
  String? _classifyId;
  String? _classifyName;
  String? _code;
  bool? _enabled;
  String? _id;
  String? _materialId;
  String? _inId;
  String? _reportId;
  String? _name;
  String? _materialName;
  String? _norms;
  String? _pic;
  PicFileVo? _picFileVo;
  num? _referPrice;
  int? _number;
  int? _checkNum;
  int? _resultNum;
  int? _result;
  String? _checkId;
  String? _remark;
  String? _thirdCode;
  String? _unitId;
  String? _unitName;
  String? _changeId;
  String? _locations;
  int? _localNum;
  bool? _isSelect;
  String? _purchaseId;
  String? _purchaseCode;
  String? _purchaseDetailId;
  int? _materialType;
  String? _assetId;
  String? _assetName;
  String? _assetCode;
  String? _materialCode;
  String? _belongOrgId;
  String? _belongOrgName;
  String? _fetchOrgId;
  String? _fetchOrgName;
  String? _fetchUserId;
  String? _fetchUserName;
  String? _gmtFetch;
  int? _returnCheck;
  int? _unBackNum;
  int? _backNum;
  SCMaterialListModel copyWith({
    String? barCode,
    String? classifyId,
    String? classifyName,
    String? code,
    bool? enabled,
    String? id,
    String? materialId,
    String? inId,
    String? reportId,
    String? name,
    String? materialName,
    String? norms,
    String? pic,
    PicFileVo? picFileVo,
    double? referPrice,
    int? number,
    int? checkNum,
    int? resultNum,
    int? result,
    String? checkId,
    String? remark,
    String? thirdCode,
    String? unitId,
    String? unitName,
    String? changeId,
    String? locations,
    int? localNum,
    bool? isSelect,
    String? purchaseId,
    String? purchaseCode,
    String? purchaseDetailId,
    int? materialType,
    String? assetId,
    String? assetName,
    String? assetCode,
    String? materialCode,
    String? belongOrgId,
    String? belongOrgName,
    String? fetchOrgId,
    String? fetchOrgName,
    String? fetchUserId,
    String? fetchUserName,
    String? gmtFetch,
    int? returnCheck,
    int? unBackNum,
    int? backNum,
  }) =>
      SCMaterialListModel(
        barCode: barCode ?? _barCode,
        classifyId: classifyId ?? _classifyId,
        classifyName: classifyName ?? _classifyName,
        code: code ?? _code,
        enabled: enabled ?? _enabled,
        id: id ?? _id,
        materialId: materialId ?? _materialId,
        inId: inId ?? _inId,
        reportId: reportId ?? _reportId,
        name: name ?? _name,
        materialName: materialName ?? _materialName,
        norms: norms ?? _norms,
        pic: pic ?? _pic,
        picFileVo: picFileVo ?? _picFileVo,
        referPrice: referPrice ?? _referPrice,
        number: number ?? _number,
        checkNum: checkNum ?? _checkNum,
        resultNum: resultNum ?? _resultNum,
        result: result ?? _result,
        checkId: checkId ?? _checkId,
        remark: remark ?? _remark,
        thirdCode: thirdCode ?? _thirdCode,
        unitId: unitId ?? _unitId,
        unitName: unitName ?? _unitName,
        changeId: changeId ?? _changeId,
        locations: locations ?? _locations,
        localNum: localNum ?? _localNum,
        isSelect: isSelect ?? _isSelect,
        purchaseId: purchaseId ?? _purchaseId,
        purchaseCode: purchaseCode ?? _purchaseCode,
          purchaseDetailId: purchaseDetailId ?? _purchaseDetailId,
          materialType: materialType ?? _materialType,
        assetId: assetId ?? _assetId,
        assetName: assetName ?? _assetName,
        assetCode: assetCode ?? _assetCode,
        materialCode: materialCode ?? _materialCode,
        belongOrgId: belongOrgId ?? _belongOrgId,
        belongOrgName: belongOrgName ?? _belongOrgName,
        fetchOrgId: fetchOrgId ?? _fetchOrgId,
        fetchOrgName: fetchOrgName ?? _fetchOrgName,
        fetchUserId: fetchUserId ?? _fetchUserId,
        fetchUserName: fetchUserName ?? _fetchUserName,
        gmtFetch: gmtFetch ?? _gmtFetch,
        returnCheck: returnCheck ?? _returnCheck,
        unBackNum: unBackNum ?? _unBackNum,
        backNum: backNum ?? _backNum,
      );
  String? get barCode => _barCode;
  String? get classifyId => _classifyId;
  String? get classifyName => _classifyName;
  String? get code => _code;
  bool? get enabled => _enabled;
  String? get id => _id;
  String? get materialId => _materialId;
  String? get inId => _inId;
  String? get reportId => _reportId;
  String? get name => _name;
  String? get materialName => _materialName;
  String? get norms => _norms;
  String? get pic => _pic;
  PicFileVo? get picFileVo => _picFileVo;
  num? get referPrice => _referPrice;
  int? get number => _number;
  int? get checkNum => _checkNum;
  int? get resultNum => _resultNum;
  int? get result => _result;
  String? get checkId => _checkId;
  String? get remark => _remark;
  String? get thirdCode => _thirdCode;
  String? get unitId => _unitId;
  String? get unitName => _unitName;
  String? get changeId => _changeId;
  String? get locations => _locations;
  int? get localNum => _localNum;
  bool? get isSelect => _isSelect;
  String? get purchaseId => _purchaseId;
  String? get purchaseCode => _purchaseCode;
  String? get purchaseDetailId => _purchaseDetailId;
  int? get materialType => _materialType;
  String? get assetId => _assetId;
  String? get assetName => _assetName;
  String? get assetCode => _assetCode;
  String? get materialCode => _materialCode;
  String? get belongOrgId => _belongOrgId;
  String? get belongOrgName => _belongOrgName;
  String? get fetchOrgId => _fetchOrgId;
  String? get fetchOrgName => _fetchOrgName;
  String? get fetchUserId => _fetchUserId;
  String? get fetchUserName => _fetchUserName;
  String? get gmtFetch => _gmtFetch;
  int? get returnCheck => _returnCheck;
  int? get unBackNum => _unBackNum;
  int? get backNum => _backNum;

  /// set checkNum
  set checkNum(int? value) {
    _checkNum = value;
  }

  /// set num
  set localNum(int? value) {
    _localNum = value;
  }

  /// set isSelect
  set isSelect(bool? value) {
    _isSelect = value;
  }

  set materialType(int? value) {
    _materialType = value;
  }
  set name(String? value) {
    _name = value;
  }

  set materialName(String? value) {
    _materialName = value;
  }

  set id(String? value) {
    _id = value;
  }

  set materialId(String? value) {
    _materialId = value;
  }

  set inId(String? value) {
    _inId = value;
  }

  set reportId(String? value) {
    _reportId = value;
  }

  set purchaseDetailId(String? value) {
    _purchaseDetailId = value;
  }

  set assetId(String? value) {
    _assetId = value;
  }


  set returnCheck(int? value) {
    _returnCheck = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['barCode'] = _barCode;
    map['classifyId'] = _classifyId;
    map['classifyName'] = _classifyName;
    map['code'] = _code;
    map['enabled'] = _enabled;
    map['id'] = _id;
    map['materialId'] = _materialId;
    map['inId'] = _inId;
    map['reportId'] = _reportId;
    map['name'] = _name;
    map['materialName'] = _materialName;
    map['norms'] = _norms;
    map['pic'] = _pic;
    if (_picFileVo != null) {
      map['picFileVo'] = _picFileVo?.toJson();
    }
    map['referPrice'] = _referPrice;
    map['number'] = _number;
    map['resultNum'] = _resultNum;
    map['checkId'] = _checkId;
    map['remark'] = _remark;
    map['thirdCode'] = _thirdCode;
    map['unitId'] = _unitId;
    map['unitName'] = _unitName;
    map['changeId'] = _changeId;
    map['locations'] = _locations;
    map['localNum'] = _localNum;
    map['isSelect'] = _isSelect;
    map['purchaseId'] = _purchaseId;
    map['purchaseCode'] = _purchaseCode;
    map['purchaseDetailId'] = _purchaseDetailId;
    map['assetId'] = _assetId;
    map['assetName'] = _assetName;
    map['assetCode'] = _assetCode;
    map['materialCode'] = _materialCode;
    map['belongOrgId'] = _belongOrgId;
    map['belongOrgName'] = _belongOrgName;
    map['fetchOrgId'] = _fetchOrgId;
    map['fetchOrgName'] = _fetchOrgName;
    map['fetchUserId'] = _fetchUserId;
    map['fetchUserName'] = _fetchUserName;
    map['gmtFetch'] = _gmtFetch;
    map['materialType'] = _materialType;
    map['returnCheck'] = _returnCheck;
    map['unBackNum'] = _unBackNum;
    map['backNum'] = _backNum;
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
    int? type,
  }) {
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
  PicFileVo copyWith({
    String? fileKey,
    String? name,
    int? size,
    String? suffix,
    int? type,
  }) =>
      PicFileVo(
        fileKey: fileKey ?? _fileKey,
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
