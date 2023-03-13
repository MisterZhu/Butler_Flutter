class SCPropertyListModel {
  SCPropertyListModel({
      this.id, 
      this.materialId, 
      this.assetId, 
      this.assetName, 
      this.assetCode, 
      this.materialCode, 
      this.norms, 
      this.unitId, 
      this.unitName, 
      this.classifyId, 
      this.classifyName, 
      this.belongOrgId, 
      this.belongOrgName, 
      this.fetchOrgId, 
      this.fetchOrgName, 
      this.fetchUserId, 
      this.fetchUserName, 
      this.gmtFetch, 
      this.amount, 
      this.lossAmount, 
      this.supplierId, 
      this.supplier, 
      this.timePlan, 
      this.state, 
      this.deleted, 
      this.tenantId, 
      this.creator, 
      this.operator, 
      this.gmtCreate, 
      this.gmtModify, 
      this.creatorName, 
      this.operatorName, 
      this.orgIdList,
      this.pic,
      this.isSelect,
    this.inId,
  });

  SCPropertyListModel.fromJson(dynamic json) {
    id = json['id'];
    materialId = json['materialId'];
    assetId = json['assetId'];
    assetName = json['assetName'];
    assetCode = json['assetCode'];
    materialCode = json['materialCode'];
    norms = json['norms'];
    unitId = json['unitId'];
    unitName = json['unitName'];
    classifyId = json['classifyId'];
    classifyName = json['classifyName'];
    belongOrgId = json['belongOrgId'];
    belongOrgName = json['belongOrgName'];
    fetchOrgId = json['fetchOrgId'];
    fetchOrgName = json['fetchOrgName'];
    fetchUserId = json['fetchUserId'];
    fetchUserName = json['fetchUserName'];
    gmtFetch = json['gmtFetch'];
    amount = json['amount'];
    lossAmount = json['lossAmount'];
    supplierId = json['supplierId'];
    supplier = json['supplier'];
    timePlan = json['timePlan'];
    state = json['state'];
    deleted = json['deleted'];
    tenantId = json['tenantId'];
    creator = json['creator'];
    operator = json['operator'];
    gmtCreate = json['gmtCreate'];
    gmtModify = json['gmtModify'];
    creatorName = json['creatorName'];
    operatorName = json['operatorName'];
    orgIdList = json['orgIdList'];
    isSelect = json['isSelect'];
    pic = json['pic'];
    inId = json['inId'];
  }
  String? id;
  String? materialId;
  String? assetId;
  String? assetName;
  String? assetCode;
  String? materialCode;
  String? norms;
  String? unitId;
  String? unitName;
  String? classifyId;
  String? classifyName;
  String? belongOrgId;
  String? belongOrgName;
  String? fetchOrgId;
  String? fetchOrgName;
  String? fetchUserId;
  String? fetchUserName;
  String? gmtFetch;
  int? amount;
  int? lossAmount;
  String? supplierId;
  String? supplier;
  String? timePlan;
  int? state;
  bool? deleted;
  String? tenantId;
  String? creator;
  String? operator;
  String? gmtCreate;
  String? gmtModify;
  String? creatorName;
  String? operatorName;
  String? orgIdList;
  bool? isSelect;
  String? pic;
  String? inId;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['materialId'] = materialId;
    map['assetId'] = assetId;
    map['assetName'] = assetName;
    map['assetCode'] = assetCode;
    map['materialCode'] = materialCode;
    map['norms'] = norms;
    map['unitId'] = unitId;
    map['unitName'] = unitName;
    map['classifyId'] = classifyId;
    map['classifyName'] = classifyName;
    map['belongOrgId'] = belongOrgId;
    map['belongOrgName'] = belongOrgName;
    map['fetchOrgId'] = fetchOrgId;
    map['fetchOrgName'] = fetchOrgName;
    map['fetchUserId'] = fetchUserId;
    map['fetchUserName'] = fetchUserName;
    map['gmtFetch'] = gmtFetch;
    map['amount'] = amount;
    map['lossAmount'] = lossAmount;
    map['supplierId'] = supplierId;
    map['supplier'] = supplier;
    map['timePlan'] = timePlan;
    map['state'] = state;
    map['deleted'] = deleted;
    map['tenantId'] = tenantId;
    map['creator'] = creator;
    map['operator'] = operator;
    map['gmtCreate'] = gmtCreate;
    map['gmtModify'] = gmtModify;
    map['creatorName'] = creatorName;
    map['operatorName'] = operatorName;
    map['orgIdList'] = orgIdList;
    map['isSelect'] = isSelect;
    map['pic'] = pic;
    map['inId'] = inId;
    return map;
  }

}