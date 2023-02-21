import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_list_model.dart';

/// creator : ""     创建人ID
/// creatorName : ""
/// gmtCreate : ""
/// gmtModify : ""
/// id : ""        主键ID
/// number : ""      入库单号
/// materialNames : ""   物资名称集合
/// materialNums : 0     物资数量	
/// materials : [{"barCode":"","code":"","id":"","inId":"","locations":"","materialId":"","materialName":"","norms":"","num":0,"referPrice":0,"thirdCode":"","totalPrice":0,"unitId":"","unitName":""}]
/// operator : ""
/// operatorName : ""
/// orgId : ""      所属组织ID
/// orgName : ""    所属组织名称
/// remark : ""    备注
/// status : 0     单据状态(0：待提交，1：待审批，2：审批中，3：已拒绝，4：已驳回，5：已撤回，6：已入库)
/// type : 0     入库类型（1：采购入库，2：调拨入库，3：盘盈入库，4：领料归还入库，5：借用归还入库，6：退货入库，99：其它入库）
/// typeName : ""    入库类型名称
/// wareHouseAddress : ""    仓库地址
/// wareHouseId : ""    关联仓库ID
/// wareHouseName : ""    关联仓库名称
/// fetchOrgId : ""      领用组织ID
/// fetchOrgName : ""    领用组织名称
/// fetchUserId : ""    领用人ID
/// fetchUserName : ""   领用人名称

/// 入库列表model

class SCMaterialEntryModel {
  SCMaterialEntryModel({
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
    int? reason,
    String? reasonName,
    String? wareHouseAddress,
      String? wareHouseId, 
      String? wareHouseName,
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
    _reason = reason;
    _reasonName = reasonName;
    _wareHouseAddress = wareHouseAddress;
    _wareHouseId = wareHouseId;
    _wareHouseName = wareHouseName;
    _fetchOrgId = fetchOrgId;
    _fetchOrgName = fetchOrgName;
    _fetchUserId = fetchUserId;
    _fetchUserName = fetchUserName;
}

  SCMaterialEntryModel.fromJson(dynamic json) {
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
    _reason = json['reason'];
    _reasonName = json['reasonName'];
    _wareHouseAddress = json['wareHouseAddress'];
    _wareHouseId = json['wareHouseId'];
    _wareHouseName = json['wareHouseName'];
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
  int? _reason;
  String? _reasonName;
  String? _wareHouseAddress;
  String? _wareHouseId;
  String? _wareHouseName;
  String? _fetchOrgId;
  String? _fetchOrgName;
  String? _fetchUserId;
  String? _fetchUserName;
  SCMaterialEntryModel copyWith({  String? creator,
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
    int? reason,
    String? reasonName,
  String? wareHouseAddress,
  String? wareHouseId,
  String? wareHouseName,
  String? fetchOrgId,
  String? fetchOrgName,
  String? fetchUserId,
  String? fetchUserName,
}) => SCMaterialEntryModel(  creator: creator ?? _creator,
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
    reason: reason ?? _reason,
    reasonName: reasonName ?? _reasonName,
  wareHouseAddress: wareHouseAddress ?? _wareHouseAddress,
  wareHouseId: wareHouseId ?? _wareHouseId,
  wareHouseName: wareHouseName ?? _wareHouseName,
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
  int? get reason => _reason;
  String? get reasonName => _reasonName;
  String? get wareHouseAddress => _wareHouseAddress;
  String? get wareHouseId => _wareHouseId;
  String? get wareHouseName => _wareHouseName;
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
    map['reason'] = _reason;
    map['reasonName'] = _reasonName;
    map['wareHouseAddress'] = _wareHouseAddress;
    map['wareHouseId'] = _wareHouseId;
    map['wareHouseName'] = _wareHouseName;
    map['fetchOrgId'] = _fetchOrgId;
    map['fetchOrgName'] = _fetchOrgName;
    map['fetchUserId'] = _fetchUserId;
    map['fetchUserName'] = _fetchUserName;
    return map;
  }
}