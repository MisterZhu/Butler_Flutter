import 'sc_property_list_model.dart';

class SCPropertyFrmLossDetailModel {
  SCPropertyFrmLossDetailModel({
      this.id, 
      this.fetchOrgId, 
      this.fetchOrgName, 
      this.fetchUserId, 
      this.fetchUserName, 
      this.reportOrgId, 
      this.reportOrgName, 
      this.reportUserId, 
      this.reportManMobileNum, 
      this.reportUserName, 
      this.type, 
      this.typeName, 
      this.reportTime, 
      this.number, 
      this.remark, 
      this.status, 
      this.statusDesc, 
      this.deleted, 
      this.tenantId, 
      this.creator, 
      this.operator, 
      this.gmtCreate, 
      this.gmtModify, 
      this.creatorName, 
      this.mobileNum, 
      this.assetNames, 
      this.assets, 
      this.labelList, 
      this.files,});

  SCPropertyFrmLossDetailModel.fromJson(dynamic json) {
    id = json['id'];
    fetchOrgId = json['fetchOrgId'];
    fetchOrgName = json['fetchOrgName'];
    fetchUserId = json['fetchUserId'];
    fetchUserName = json['fetchUserName'];
    reportOrgId = json['reportOrgId'];
    reportOrgName = json['reportOrgName'];
    reportUserId = json['reportUserId'];
    reportManMobileNum = json['reportManMobileNum'];
    reportUserName = json['reportUserName'];
    type = json['type'];
    typeName = json['typeName'];
    reportTime = json['reportTime'];
    number = json['number'];
    remark = json['remark'];
    status = json['status'];
    statusDesc = json['statusDesc'];
    deleted = json['deleted'];
    tenantId = json['tenantId'];
    creator = json['creator'];
    operator = json['operator'];
    gmtCreate = json['gmtCreate'];
    gmtModify = json['gmtModify'];
    creatorName = json['creatorName'];
    mobileNum = json['mobileNum'];
    assetNames = json['assetNames'];
    if (json['assets'] != null) {
      assets = [];
      json['assets'].forEach((v) {
        assets?.add(SCPropertyListModel.fromJson(v));
      });
    }
    labelList = json['labelList'] != null ? json['labelList'].cast<String>() : [];
    if (json['files'] != null) {
      files = [];
      json['files'].forEach((v) {
        files?.add(Files.fromJson(v));
      });
    }
  }
  String? id;
  String? fetchOrgId;
  String? fetchOrgName;
  String? fetchUserId;
  String? fetchUserName;
  String? reportOrgId;
  String? reportOrgName;
  String? reportUserId;
  String? reportManMobileNum;
  String? reportUserName;
  int? type;
  String? typeName;
  String? reportTime;
  String? number;
  String? remark;
  int? status;
  String? statusDesc;
  bool? deleted;
  String? tenantId;
  String? creator;
  String? operator;
  String? gmtCreate;
  String? gmtModify;
  String? creatorName;
  String? mobileNum;
  String? assetNames;
  List<SCPropertyListModel>? assets;
  List<String>? labelList;
  List<Files>? files;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['fetchOrgId'] = fetchOrgId;
    map['fetchOrgName'] = fetchOrgName;
    map['fetchUserId'] = fetchUserId;
    map['fetchUserName'] = fetchUserName;
    map['reportOrgId'] = reportOrgId;
    map['reportOrgName'] = reportOrgName;
    map['reportUserId'] = reportUserId;
    map['reportManMobileNum'] = reportManMobileNum;
    map['reportUserName'] = reportUserName;
    map['type'] = type;
    map['typeName'] = typeName;
    map['reportTime'] = reportTime;
    map['number'] = number;
    map['remark'] = remark;
    map['status'] = status;
    map['statusDesc'] = statusDesc;
    map['deleted'] = deleted;
    map['tenantId'] = tenantId;
    map['creator'] = creator;
    map['operator'] = operator;
    map['gmtCreate'] = gmtCreate;
    map['gmtModify'] = gmtModify;
    map['creatorName'] = creatorName;
    map['mobileNum'] = mobileNum;
    map['assetNames'] = assetNames;
    if (assets != null) {
      map['assets'] = assets?.map((v) => v.toJson()).toList();
    }
    map['labelList'] = labelList;
    if (files != null) {
      map['files'] = files?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Assets {
  Assets({
      this.id, 
      this.reportId, 
      this.materialId, 
      this.materialName, 
      this.classifyId, 
      this.classifyName, 
      this.materialCode, 
      this.pic, 
      this.assetId, 
      this.assetName, 
      this.assetCode, 
      this.fetchOrgId, 
      this.fetchOrgName, 
      this.fetchUserId, 
      this.fetchUserName, 
      this.unitId, 
      this.unitName, 
      this.barCode, 
      this.thirdCode, 
      this.norms, 
      this.referPrice, 
      this.num, 
      this.totalPrice, 
      this.locations, 
      this.deleted, 
      this.tenantId, 
      this.creator, 
      this.operator, 
      this.gmtCreate, 
      this.gmtModify, 
      this.creatorName, 
      this.operatorName,});

  Assets.fromJson(dynamic json) {
    id = json['id'];
    reportId = json['reportId'];
    materialId = json['materialId'];
    materialName = json['materialName'];
    classifyId = json['classifyId'];
    classifyName = json['classifyName'];
    materialCode = json['materialCode'];
    pic = json['pic'];
    assetId = json['assetId'];
    assetName = json['assetName'];
    assetCode = json['assetCode'];
    fetchOrgId = json['fetchOrgId'];
    fetchOrgName = json['fetchOrgName'];
    fetchUserId = json['fetchUserId'];
    fetchUserName = json['fetchUserName'];
    unitId = json['unitId'];
    unitName = json['unitName'];
    barCode = json['barCode'];
    thirdCode = json['thirdCode'];
    norms = json['norms'];
    referPrice = json['referPrice'];
    num = json['num'];
    totalPrice = json['totalPrice'];
    locations = json['locations'];
    deleted = json['deleted'];
    tenantId = json['tenantId'];
    creator = json['creator'];
    operator = json['operator'];
    gmtCreate = json['gmtCreate'];
    gmtModify = json['gmtModify'];
    creatorName = json['creatorName'];
    operatorName = json['operatorName'];
  }
  String? id;
  String? reportId;
  String? materialId;
  String? materialName;
  String? classifyId;
  String? classifyName;
  String? materialCode;
  String? pic;
  String? assetId;
  String? assetName;
  String? assetCode;
  String? fetchOrgId;
  String? fetchOrgName;
  String? fetchUserId;
  String? fetchUserName;
  String? unitId;
  String? unitName;
  String? barCode;
  String? thirdCode;
  String? norms;
  int? referPrice;
  int? num;
  int? totalPrice;
  String? locations;
  bool? deleted;
  String? tenantId;
  String? creator;
  String? operator;
  String? gmtCreate;
  String? gmtModify;
  String? creatorName;
  String? operatorName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['reportId'] = reportId;
    map['materialId'] = materialId;
    map['materialName'] = materialName;
    map['classifyId'] = classifyId;
    map['classifyName'] = classifyName;
    map['materialCode'] = materialCode;
    map['pic'] = pic;
    map['assetId'] = assetId;
    map['assetName'] = assetName;
    map['assetCode'] = assetCode;
    map['fetchOrgId'] = fetchOrgId;
    map['fetchOrgName'] = fetchOrgName;
    map['fetchUserId'] = fetchUserId;
    map['fetchUserName'] = fetchUserName;
    map['unitId'] = unitId;
    map['unitName'] = unitName;
    map['barCode'] = barCode;
    map['thirdCode'] = thirdCode;
    map['norms'] = norms;
    map['referPrice'] = referPrice;
    map['num'] = num;
    map['totalPrice'] = totalPrice;
    map['locations'] = locations;
    map['deleted'] = deleted;
    map['tenantId'] = tenantId;
    map['creator'] = creator;
    map['operator'] = operator;
    map['gmtCreate'] = gmtCreate;
    map['gmtModify'] = gmtModify;
    map['creatorName'] = creatorName;
    map['operatorName'] = operatorName;
    return map;
  }

}

class Files {
  Files({
    this.fileKey,
    this.name,
    this.size,
    this.suffix,
    this.type,});

  Files.fromJson(dynamic json) {
    fileKey = json['fileKey'];
    name = json['name'];
    size = json['size'];
    suffix = json['suffix'];
    type = json['type'];
  }
  String? fileKey;
  String? name;
  int? size;
  String? suffix;
  int? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fileKey'] = fileKey;
    map['name'] = name;
    map['size'] = size;
    map['suffix'] = suffix;
    map['type'] = type;
    return map;
  }

}