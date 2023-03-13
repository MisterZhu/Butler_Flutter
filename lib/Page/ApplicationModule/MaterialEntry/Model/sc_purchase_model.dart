/// 采购单model
class SCPurchaseModel {
  SCPurchaseModel({
      this.applyDate, 
      this.applyManId, 
      this.applyManName, 
      this.applyPartId, 
      this.applyPartName, 
      this.creator, 
      this.creatorName, 
      this.deleted, 
      this.gmtCreate, 
      this.gmtModify, 
      this.id, 
      this.operator, 
      this.operatorName, 
      this.purchaseCode, 
      this.remark, 
      this.status, 
      this.tenantId, 
      this.totalPrice,});

  SCPurchaseModel.fromJson(dynamic json) {
    applyDate = json['applyDate'];
    applyManId = json['applyManId'];
    applyManName = json['applyManName'];
    applyPartId = json['applyPartId'];
    applyPartName = json['applyPartName'];
    creator = json['creator'];
    creatorName = json['creatorName'];
    deleted = json['deleted'];
    gmtCreate = json['gmtCreate'];
    gmtModify = json['gmtModify'];
    id = json['id'];
    operator = json['operator'];
    operatorName = json['operatorName'];
    purchaseCode = json['purchaseCode'];
    remark = json['remark'];
    status = json['status'];
    tenantId = json['tenantId'];
    totalPrice = json['totalPrice'];
  }
  String? applyDate;
  String? applyManId;
  String? applyManName;
  String? applyPartId;
  String? applyPartName;
  String? creator;
  String? creatorName;
  bool? deleted;
  String? gmtCreate;
  String? gmtModify;
  String? id;
  String? operator;
  String? operatorName;
  String? purchaseCode;
  String? remark;
  int? status;
  String? tenantId;
  int? totalPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['applyDate'] = applyDate;
    map['applyManId'] = applyManId;
    map['applyManName'] = applyManName;
    map['applyPartId'] = applyPartId;
    map['applyPartName'] = applyPartName;
    map['creator'] = creator;
    map['creatorName'] = creatorName;
    map['deleted'] = deleted;
    map['gmtCreate'] = gmtCreate;
    map['gmtModify'] = gmtModify;
    map['id'] = id;
    map['operator'] = operator;
    map['operatorName'] = operatorName;
    map['purchaseCode'] = purchaseCode;
    map['remark'] = remark;
    map['status'] = status;
    map['tenantId'] = tenantId;
    map['totalPrice'] = totalPrice;
    return map;
  }

}