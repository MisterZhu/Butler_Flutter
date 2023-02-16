import 'dart:core';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_list_model.dart';

/// creator : ""
/// creatorName : ""
/// gmtCreate : ""
/// gmtModify : ""
/// id : ""    主键ID
/// materialNames : ""
/// materialNums : 0
/// materials : [{"barCode":"","code":"","id":"","inId":"","locations":"","materialId":"","materialName":"","norms":"","num":0,"referPrice":1.0,"thirdCode":"","totalPrice":1.0,"unitId":"","unitName":""}]
/// number : ""   出库单号
/// operator : ""
/// operatorName : ""
/// orgId : ""   所属组织ID
/// orgName : ""   所属组织名称
/// remark : ""
/// status : 0
/// type : 0     出库类型（1：领料出库,2：调拨出库，3：盘亏出库，4：报损出库，99：其他出库）
/// typeName : ""   出库类型名称
/// wareHouseAddress : ""
/// wareHouseId : ""    关联仓库ID
/// wareHouseName : ""   关联仓库名称
/// tenantId : ""   租户id
/// fetchOrgId : ""      领用组织ID
/// fetchOrgName : ""    领用组织名称
/// fetchUserId : ""    领用人ID
/// fetchUserName : ""   领用人名称

/// 出入库详情model

class SCMaterialEntryDetailModel {
  SCMaterialEntryDetailModel({
      String? creator, 
      String? creatorName, 
      String? gmtCreate, 
      String? gmtModify, 
      String? id, 
      String? materialNames, 
      int? materialNums, 
      List<SCMaterialListModel>? materials,
      String? number,
      String? mobileNum,
      String? operator, 
      String? operatorName, 
      String? orgId, 
      String? orgName, 
      String? remark, 
      int? status, 
      int? type, 
      String? typeName, 
      String? wareHouseAddress, 
      String? wareHouseId, 
      String? wareHouseName,
    String? tenantId,
    String? fetchOrgId,
    String? fetchOrgName,
    String? fetchUserId,
    String? fetchUserName,}){
    _creator = creator;
    _creatorName = creatorName;
    _gmtCreate = gmtCreate;
    _gmtModify = gmtModify;
    _id = id;
    _materialNames = materialNames;
    _materialNums = materialNums;
    _materials = materials;
    _number = number;
    _mobileNum = mobileNum;
    _operator = operator;
    _operatorName = operatorName;
    _orgId = orgId;
    _orgName = orgName;
    _remark = remark;
    _status = status;
    _type = type;
    _typeName = typeName;
    _wareHouseAddress = wareHouseAddress;
    _wareHouseId = wareHouseId;
    _wareHouseName = wareHouseName;
    _tenantId = tenantId;
    _fetchOrgId = fetchOrgId;
    _fetchOrgName = fetchOrgName;
    _fetchUserId = fetchUserId;
    _fetchUserName = fetchUserName;
}

  SCMaterialEntryDetailModel.fromJson(dynamic json) {
    _creator = json['creator'];
    _creatorName = json['creatorName'];
    _gmtCreate = json['gmtCreate'];
    _gmtModify = json['gmtModify'];
    _id = json['id'];
    _materialNames = json['materialNames'];
    _materialNums = json['materialNums'];
    if (json['materials'] != null) {
      _materials = [];
      json['materials'].forEach((v) {
        _materials?.add(SCMaterialListModel.fromJson(v));
      });
    }
    _number = json['number'];
    _mobileNum = json['mobileNum'];
    _operator = json['operator'];
    _operatorName = json['operatorName'];
    _orgId = json['orgId'];
    _orgName = json['orgName'];
    _remark = json['remark'];
    _status = json['status'];
    _type = json['type'];
    _typeName = json['typeName'];
    _wareHouseAddress = json['wareHouseAddress'];
    _wareHouseId = json['wareHouseId'];
    _wareHouseName = json['wareHouseName'];
    _tenantId = json['tenantId'];
    _fetchOrgId = json['fetchOrgId'];
    _fetchOrgName = json['fetchOrgName'];
    _fetchUserId = json['fetchUserId'];
    _fetchUserName = json['fetchUserName'];
  }
  String? _creator;
  String? _creatorName;
  String? _gmtCreate;
  String? _gmtModify;
  String? _id;
  String? _materialNames;
  int? _materialNums;
  List<SCMaterialListModel>? _materials;
  String? _number;
  String? _mobileNum;
  String? _operator;
  String? _operatorName;
  String? _orgId;
  String? _orgName;
  String? _remark;
  int? _status;
  int? _type;
  String? _typeName;
  String? _wareHouseAddress;
  String? _wareHouseId;
  String? _wareHouseName;
  String? _tenantId;
  String? _fetchOrgId;
  String? _fetchOrgName;
  String? _fetchUserId;
  String? _fetchUserName;
  SCMaterialEntryDetailModel copyWith({  String? creator,
  String? creatorName,
  String? gmtCreate,
  String? gmtModify,
  String? id,
  String? materialNames,
  int? materialNums,
  List<SCMaterialListModel>? materials,
  String? number,
  String? operator,
  String? operatorName,
  String? orgId,
  String? orgName,
  String? remark,
  int? status,
  int? type,
  String? typeName,
  String? wareHouseAddress,
  String? wareHouseId,
  String? wareHouseName,
  String? tenantId,
    String? fetchOrgId,
    String? fetchOrgName,
    String? fetchUserId,
    String? fetchUserName,
}) => SCMaterialEntryDetailModel(  creator: creator ?? _creator,
  creatorName: creatorName ?? _creatorName,
  gmtCreate: gmtCreate ?? _gmtCreate,
  gmtModify: gmtModify ?? _gmtModify,
  id: id ?? _id,
  materialNames: materialNames ?? _materialNames,
  materialNums: materialNums ?? _materialNums,
  materials: materials ?? _materials,
  number: number ?? _number,
    mobileNum: mobileNum ?? _mobileNum,
  operator: operator ?? _operator,
  operatorName: operatorName ?? _operatorName,
  orgId: orgId ?? _orgId,
  orgName: orgName ?? _orgName,
  remark: remark ?? _remark,
  status: status ?? _status,
  type: type ?? _type,
  typeName: typeName ?? _typeName,
  wareHouseAddress: wareHouseAddress ?? _wareHouseAddress,
  wareHouseId: wareHouseId ?? _wareHouseId,
  wareHouseName: wareHouseName ?? _wareHouseName,
  tenantId: tenantId ?? _tenantId,
    fetchOrgId: fetchOrgId ?? _fetchOrgId,
    fetchOrgName: fetchOrgName ?? _fetchOrgName,
    fetchUserId: fetchUserId ?? _fetchUserId,
    fetchUserName: fetchUserName ?? _fetchUserName,
);
  String? get creator => _creator;
  String? get creatorName => _creatorName;
  String? get gmtCreate => _gmtCreate;
  String? get gmtModify => _gmtModify;
  String? get id => _id;
  String? get materialNames => _materialNames;
  int? get materialNums => _materialNums;
  List<SCMaterialListModel>? get materials => _materials;
  String? get number => _number;
  String? get mobileNum => _mobileNum;
  String? get operator => _operator;
  String? get operatorName => _operatorName;
  String? get orgId => _orgId;
  String? get orgName => _orgName;
  String? get remark => _remark;
  int? get status => _status;
  int? get type => _type;
  String? get typeName => _typeName;
  String? get wareHouseAddress => _wareHouseAddress;
  String? get wareHouseId => _wareHouseId;
  String? get wareHouseName => _wareHouseName;
  String? get tenantId => _tenantId;
  String? get fetchOrgId => _fetchOrgId;
  String? get fetchOrgName => _fetchOrgName;
  String? get fetchUserId => _fetchUserId;
  String? get fetchUserName => _fetchUserName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['creator'] = _creator;
    map['creatorName'] = _creatorName;
    map['gmtCreate'] = _gmtCreate;
    map['gmtModify'] = _gmtModify;
    map['id'] = _id;
    map['materialNames'] = _materialNames;
    map['materialNums'] = _materialNums;
    if (_materials != null) {
      map['materials'] = _materials?.map((v) => v.toJson()).toList();
    }
    map['number'] = _number;
    map['mobileNum'] = _mobileNum;
    map['operator'] = _operator;
    map['operatorName'] = _operatorName;
    map['orgId'] = _orgId;
    map['orgName'] = _orgName;
    map['remark'] = _remark;
    map['status'] = _status;
    map['type'] = _type;
    map['typeName'] = _typeName;
    map['wareHouseAddress'] = _wareHouseAddress;
    map['wareHouseId'] = _wareHouseId;
    map['wareHouseName'] = _wareHouseName;
    map['tenantId'] = _tenantId;
    map['fetchOrgId'] = _fetchOrgId;
    map['fetchOrgName'] = _fetchOrgName;
    map['fetchUserId'] = _fetchUserId;
    map['fetchUserName'] = _fetchUserName;
    return map;
  }

}
