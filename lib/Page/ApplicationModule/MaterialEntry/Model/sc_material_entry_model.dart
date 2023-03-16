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
/// orgId : ""      所属组织ID(调入仓库所属)
/// orgName : ""    所属组织名称(调入仓库所属)
/// remark : ""    备注
/// statusDesc : "" 单据状态描述
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
/// inWareHouseId : "调入仓库ID"
/// inWareHouseName: "调入仓库名称"
/// outWareHouseId : "调出仓库ID"
/// outWareHouseName	: "调出仓库名称	"
///
///
///
/// 入库列表model

class SCMaterialEntryModel {
  SCMaterialEntryModel({
    String? creator,// 创建人ID
    String? creatorName,// 创建人姓名
    String? gmtCreate,// 创建时间
    String? gmtModify,// 修改时间(最近操作时间)
    String? id,// 主键ID
    String? materialNames,
    int? materialNums,
    List<SCMaterialListModel>? materials,
    String? number,// 入库单号
    String? mobileNum,
    String? operator,// 操作人ID
    String? operatorName,// 修改人姓名
    String? orgId, // 所属组织ID
    String? orgName,
    String? remark,
    String? statusDesc,
    int? status, // 单据状态(0：待提交，1：待审批，2：审批中，3：已拒绝，4：已驳回，5：已撤回，6：已入库)
    int? type, // 入库类型（1：采购入库，2：调拨入库，3：盘盈入库，4：领料归还入库，5：借用归还入库，6：退货入库，99：其它入库）
    String? typeName,
    int? reason,
    String? reasonName,
    String? wareHouseAddress,
    String? wareHouseId, // 关联仓库ID
    String? wareHouseName,
    String? fetchOrgId,
    String? fetchOrgName,
    String? fetchUserId,
    String? fetchUserName,
    String? inWareHouseId,
    String? inWareHouseName,
    String? outWareHouseId,
    String? outWareHouseName,
    String? taskName,
    String? taskStartTime,
    String? taskEndTime,
    int? rangeValue,
    String? assetNames,
    int? assetNums,
    bool? returned,
    String? dealOrgId,// 处理部门id
    String? dealOrgName,// 处理部门名称
    String? dealUserId,// 处理人id
    String? dealUserName,// 处理人
  }) {
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
    _statusDesc = statusDesc;
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
    _inWareHouseId = inWareHouseId;
    _inWareHouseName = inWareHouseName;
    _outWareHouseId = outWareHouseId;
    _outWareHouseName = outWareHouseName;
    _taskName = taskName;
    _taskStartTime = taskStartTime;
    _taskEndTime = taskEndTime;
    _rangeValue = rangeValue;
    _assetNames = assetNames;
    _assetNums = assetNums;
    _returned = returned;
    _dealOrgId = dealOrgId;
    _dealOrgName = dealOrgName;
    _dealUserId = dealUserId;
    _dealUserName = dealUserName;
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
    _statusDesc = json['statusDesc'];
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
    _inWareHouseId = json['inWareHouseId'];
    _inWareHouseName = json['inWareHouseName'];
    _outWareHouseId = json['outWareHouseId'];
    _outWareHouseName = json['outWareHouseName'];
    _taskName = json['taskName'];
    _taskStartTime= json['taskStartTime'];
    _taskEndTime = json['taskEndTime'];
    _rangeValue = json['rangeValue'];
    _assetNames = json['assetNames'];
    _assetNums = json['assetNums'];
    _returned = json['returned'];
    _dealOrgId = json['dealOrgId'];
    _dealOrgName = json['dealOrgName'];
    _dealUserId = json['dealUserId'];
    _dealUserName = json['dealUserName'];
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
  String? _statusDesc;
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
  String? _inWareHouseId;
  String? _inWareHouseName;
  String? _outWareHouseId;
  String? _outWareHouseName;
  String? _taskName;
  String? _taskStartTime;
      String? _taskEndTime;
  int? _rangeValue;
  String? _assetNames;
  int? _assetNums;
  bool? _returned;
  String? _dealOrgId;
  String? _dealOrgName;
  String? _dealUserId;
  String? _dealUserName;
  SCMaterialEntryModel copyWith({
    String? creator,
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
    String? statusDesc,
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
    String? inWareHouseId,
    String? inWareHouseName,
    String? outWareHouseId,
    String? outWareHouseName,
    String? taskName,
    String? taskStartTime,
    String? taskEndTime,
    int? rangeValue,
    String? assetNames,
    int? assetNums,
    bool? returned,
    String? dealOrgId,
    String? dealOrgName,
    String? dealUserId,
    String? dealUserName,
  }) =>
      SCMaterialEntryModel(
        creator: creator ?? _creator,
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
        statusDesc: statusDesc ?? _statusDesc,
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
        inWareHouseId: inWareHouseId ?? _inWareHouseId,
        inWareHouseName: inWareHouseName ?? _inWareHouseName,
        outWareHouseId: outWareHouseId ?? _outWareHouseId,
        outWareHouseName: outWareHouseName ?? _outWareHouseName,
          taskName: taskName ?? _taskName,
          taskStartTime: taskStartTime ?? _taskStartTime,
          taskEndTime: taskEndTime ?? _taskEndTime,
          rangeValue: rangeValue ?? _rangeValue,
        assetNames: assetNames ?? _assetNames,
        assetNums: assetNums ?? _assetNums,
          returned: returned ?? _returned,
          dealOrgId: dealOrgId ?? _dealOrgId,
          dealOrgName: dealOrgName ?? _dealOrgName,
        dealUserId: dealUserId ?? _dealUserId,
        dealUserName: dealUserName ?? _dealUserName,
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
  String? get statusDesc => _statusDesc;
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
  String? get inWareHouseId => _inWareHouseId;
  String? get inWareHouseName => _inWareHouseName;
  String? get outWareHouseId => _outWareHouseId;
  String? get outWareHouseName => _outWareHouseName;
  String? get taskName => _taskName;
  String? get taskStartTime => _taskStartTime;
  String? get taskEndTime => _taskEndTime;
  int? get rangeValue => _rangeValue;
  String? get assetNames => _assetNames;
  int? get assetNums => _assetNums;
  bool? get returned => _returned;
  String? get dealOrgId => _dealOrgId;
  String? get dealOrgName => _dealOrgName;
  String? get dealUserId => _dealUserId;
  String? get dealUserName => _dealUserName;
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
    map['statusDesc'] = _statusDesc;
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
    map['inWareHouseId'] = _inWareHouseId;
    map['inWareHouseName'] = _inWareHouseName;
    map['outWareHouseId'] = _outWareHouseId;
    map['outWareHouseName'] = _outWareHouseName;
    map['taskName'] = _taskName;
    map['taskStartTime'] = _taskStartTime;
    map['taskEndTime'] = _taskEndTime;
    map['rangeValue'] = _rangeValue;
    map['assetNames'] = _assetNames;
    map['assetNums'] = _assetNums;
    map['returned'] = _returned;
    map['dealOrgId'] = _dealOrgId;
    map['dealOrgName'] = _dealOrgName;
    map['dealUserId'] = _dealUserId;
    map['dealUserName'] = _dealUserName;
    return map;
  }
}
