/// creator : ""     创建人ID
/// creatorName : ""
/// gmtCreate : ""
/// gmtModify : ""
/// id : ""        主键ID
/// number : ""      入库单号
/// operator : ""
/// operatorName : ""
/// orgId : ""      所属组织ID
/// orgName : ""    所属组织名称
/// remark : ""    备注
/// status : 0     单据状态(0：待提交，1：待审批，2：审批中，3：已拒绝，4：已驳回，5：已撤回，6：已入库)
/// type : 0     入库类型（1：采购入库，2：调拨入库，3：盘盈入库，4：领料归还入库，5：借用归还入库，6：退货入库，99：其它入库）
/// typeName : ""    入库类型名称
/// wareHouseId : ""    关联仓库ID
/// wareHouseName : ""    关联仓库名称

/// 入库列表model

class SCMaterialEntryModel {
  SCMaterialEntryModel({
      String? creator, 
      String? creatorName, 
      String? gmtCreate, 
      String? gmtModify, 
      String? id, 
      String? number, 
      String? operator, 
      String? operatorName, 
      String? orgId, 
      String? orgName, 
      String? remark, 
      int? status, 
      int? type, 
      String? typeName, 
      String? wareHouseId, 
      String? wareHouseName,}){
    _creator = creator;
    _creatorName = creatorName;
    _gmtCreate = gmtCreate;
    _gmtModify = gmtModify;
    _id = id;
    _number = number;
    _operator = operator;
    _operatorName = operatorName;
    _orgId = orgId;
    _orgName = orgName;
    _remark = remark;
    _status = status;
    _type = type;
    _typeName = typeName;
    _wareHouseId = wareHouseId;
    _wareHouseName = wareHouseName;
}

  SCMaterialEntryModel.fromJson(dynamic json) {
    _creator = json['creator'];
    _creatorName = json['creatorName'];
    _gmtCreate = json['gmtCreate'];
    _gmtModify = json['gmtModify'];
    _id = json['id'];
    _number = json['number'];
    _operator = json['operator'];
    _operatorName = json['operatorName'];
    _orgId = json['orgId'];
    _orgName = json['orgName'];
    _remark = json['remark'];
    _status = json['status'];
    _type = json['type'];
    _typeName = json['typeName'];
    _wareHouseId = json['wareHouseId'];
    _wareHouseName = json['wareHouseName'];
  }
  String? _creator;
  String? _creatorName;
  String? _gmtCreate;
  String? _gmtModify;
  String? _id;
  String? _number;
  String? _operator;
  String? _operatorName;
  String? _orgId;
  String? _orgName;
  String? _remark;
  int? _status;
  int? _type;
  String? _typeName;
  String? _wareHouseId;
  String? _wareHouseName;
  SCMaterialEntryModel copyWith({  String? creator,
  String? creatorName,
  String? gmtCreate,
  String? gmtModify,
  String? id,
  String? number,
  String? operator,
  String? operatorName,
  String? orgId,
  String? orgName,
  String? remark,
  int? status,
  int? type,
  String? typeName,
  String? wareHouseId,
  String? wareHouseName,
}) => SCMaterialEntryModel(  creator: creator ?? _creator,
  creatorName: creatorName ?? _creatorName,
  gmtCreate: gmtCreate ?? _gmtCreate,
  gmtModify: gmtModify ?? _gmtModify,
  id: id ?? _id,
  number: number ?? _number,
  operator: operator ?? _operator,
  operatorName: operatorName ?? _operatorName,
  orgId: orgId ?? _orgId,
  orgName: orgName ?? _orgName,
  remark: remark ?? _remark,
  status: status ?? _status,
  type: type ?? _type,
  typeName: typeName ?? _typeName,
  wareHouseId: wareHouseId ?? _wareHouseId,
  wareHouseName: wareHouseName ?? _wareHouseName,
);
  String? get creator => _creator;
  String? get creatorName => _creatorName;
  String? get gmtCreate => _gmtCreate;
  String? get gmtModify => _gmtModify;
  String? get id => _id;
  String? get number => _number;
  String? get operator => _operator;
  String? get operatorName => _operatorName;
  String? get orgId => _orgId;
  String? get orgName => _orgName;
  String? get remark => _remark;
  int? get status => _status;
  int? get type => _type;
  String? get typeName => _typeName;
  String? get wareHouseId => _wareHouseId;
  String? get wareHouseName => _wareHouseName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['creator'] = _creator;
    map['creatorName'] = _creatorName;
    map['gmtCreate'] = _gmtCreate;
    map['gmtModify'] = _gmtModify;
    map['id'] = _id;
    map['number'] = _number;
    map['operator'] = _operator;
    map['operatorName'] = _operatorName;
    map['orgId'] = _orgId;
    map['orgName'] = _orgName;
    map['remark'] = _remark;
    map['status'] = _status;
    map['type'] = _type;
    map['typeName'] = _typeName;
    map['wareHouseId'] = _wareHouseId;
    map['wareHouseName'] = _wareHouseName;
    return map;
  }

}