import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_list_model.dart';

import '../../PropertyFrmLoss/Model/sc_property_list_model.dart';
/// 详情页面model
class SCMaterialTaskDetailModel {
  SCMaterialTaskDetailModel({
      this.creator, 
      this.creatorName, 
      this.files, 
      this.gmtCreate, 
      this.gmtModify, 
      this.id, 
      this.labelList, 
      this.materialNames, 
      this.materialNums, 
      this.materials,
      this.assets,
      this.mobileNum, 
      this.number, 
      this.operator, 
      this.operatorName, 
      this.orgId, 
      this.orgName, 
      this.remark, 
      this.reportManMobileNum, 
      this.reportOrgId, 
      this.reportOrgName, 
      this.reportTime, 
      this.reportUserId, 
      this.reportUserName, 
      this.status, 
      this.statusDesc, 
      this.type, 
      this.typeName, 
      this.wareHouseAddress, 
      this.wareHouseId, 
      this.wareHouseName,
    this.inWareHouseId,
    this.inWareHouseName,
    this.outWareHouseId,
    this.outWareHouseName,
      this.tenantId,
      this.fetchUserName,
      this.fetchUserId,
      this.fetchOrgName,
      this.fetchOrgId,
      this.fetchUserMobileNum,
    this.taskName,
    this.taskEndTime,
    this.taskStartTime,
    this.dealEndTime,
    this.dealOrgId,
    this.dealOrgName,
    this.dealStartTime,
    this.dealUserId,
    this.dealUserName,
    this.rangeName,
    this.rangeValue,
    this.materialType,
  });

  SCMaterialTaskDetailModel.fromJson(dynamic json) {
    creator = json['creator'];
    creatorName = json['creatorName'];
    if (json['files'] != null) {
      files = [];
      json['files'].forEach((v) {
        files?.add(Files.fromJson(v));
      });
    }
    gmtCreate = json['gmtCreate'];
    gmtModify = json['gmtModify'];
    id = json['id'];
    if (json['labelList'] != null) {
      labelList = [];
      json['labelList'].forEach((v) {
        labelList?.add(v);
      });
    }
    materialNames = json['materialNames'];
    materialNums = json['materialNums'];
    if (json['materials'] != null) {
      materials = [];
      json['materials'].forEach((v) {
        materials?.add(SCMaterialListModel.fromJson(v));
      });
    }
    if (json['assets'] != null) {
      assets = [];
      json['assets'].forEach((v) {
        assets?.add(SCMaterialListModel.fromJson(v));
      });
    }
    mobileNum = json['mobileNum'];
    number = json['number'];
    operator = json['operator'];
    operatorName = json['operatorName'];
    orgId = json['orgId'];
    orgName = json['orgName'];
    remark = json['remark'];
    reportManMobileNum = json['reportManMobileNum'];
    reportOrgId = json['reportOrgId'];
    reportOrgName = json['reportOrgName'];
    reportTime = json['reportTime'];
    reportUserId = json['reportUserId'];
    reportUserName = json['reportUserName'];
    status = json['status'];
    statusDesc = json['statusDesc'];
    type = json['type'];
    typeName = json['typeName'];
    wareHouseAddress = json['wareHouseAddress'];
    wareHouseId = json['wareHouseId'];
    wareHouseName = json['wareHouseName'];
    inWareHouseId = json['inWareHouseId'];
    inWareHouseName = json['inWareHouseName'];
    outWareHouseId = json['outWareHouseId'];
    outWareHouseName = json['outWareHouseName'];
    tenantId = json['tenantId'];
    fetchOrgId = json['fetchOrgId'];
    fetchOrgName = json['fetchOrgName'];
    fetchUserId = json['fetchUserId'];
    fetchUserName = json['fetchUserName'];
    fetchUserMobileNum = json['fetchUserMobileNum'];
    taskStartTime = json['taskStartTime'];
    taskEndTime = json['taskEndTime'];
    taskName = json['taskName'];
    rangeName = json['rangeName'];
    rangeValue = json['rangeValue'];
    dealUserId = json['dealUserId'];
    dealUserName = json['dealUserName'];
    dealStartTime = json['dealStartTime'];
    dealEndTime = json['dealEndTime'];
    dealOrgId = json['dealOrgId'];
    dealOrgName = json['dealOrgName'];
    materialType = json['materialType'];
  }
  String? creator;
  String? creatorName;
  List<Files>? files;
  String? gmtCreate;
  String? gmtModify;
  String? id;
  List<String>? labelList;
  String? materialNames;
  int? materialNums;
  List<SCMaterialListModel>? materials;
  List<SCMaterialListModel>? assets;
  String? mobileNum;
  String? number;
  String? operator;
  String? operatorName;
  String? orgId;
  String? orgName;
  String? remark;
  String? reportManMobileNum;
  String? reportOrgId;
  String? reportOrgName;
  String? reportTime;
  String? reportUserId;
  String? reportUserName;
  int? status;
  String? statusDesc;
  int? type;
  String? typeName;
  String? wareHouseAddress;
  String? wareHouseId;
  String? wareHouseName;
  String? inWareHouseId;
  String? inWareHouseName;
  String? outWareHouseId;
  String? outWareHouseName;
  String? tenantId;
  String? fetchOrgId;
  String? fetchOrgName;
  String? fetchUserId;
  String? fetchUserName;
  String? fetchUserMobileNum;
  String? dealEndTime;
  String? dealStartTime;
  String? dealOrgId;
  String? dealOrgName;
  String? dealUserId;
  String? dealUserName;
  String? rangeName;
  int? rangeValue;
  String? taskEndTime;
  String? taskStartTime;
  String? taskName;
  int? materialType;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['creator'] = creator;
    map['creatorName'] = creatorName;
    if (files != null) {
      map['files'] = files?.map((v) => v.toJson()).toList();
    }
    map['gmtCreate'] = gmtCreate;
    map['gmtModify'] = gmtModify;
    map['id'] = id;
    if (labelList != null) {
      map['labelList'] = labelList?.map((v) => v).toList();
    }
    map['materialNames'] = materialNames;
    map['materialNums'] = materialNums;
    if (materials != null) {
      map['materials'] = materials?.map((v) => v.toJson()).toList();
    }
    if (assets != null) {
      map['assets'] = assets?.map((v) => v.toJson()).toList();
    }
    map['mobileNum'] = mobileNum;
    map['number'] = number;
    map['operator'] = operator;
    map['operatorName'] = operatorName;
    map['orgId'] = orgId;
    map['orgName'] = orgName;
    map['remark'] = remark;
    map['reportManMobileNum'] = reportManMobileNum;
    map['reportOrgId'] = reportOrgId;
    map['reportOrgName'] = reportOrgName;
    map['reportTime'] = reportTime;
    map['reportUserId'] = reportUserId;
    map['reportUserName'] = reportUserName;
    map['status'] = status;
    map['statusDesc'] = statusDesc;
    map['type'] = type;
    map['typeName'] = typeName;
    map['wareHouseAddress'] = wareHouseAddress;
    map['wareHouseId'] = wareHouseId;
    map['wareHouseName'] = wareHouseName;
    map['inWareHouseId'] = inWareHouseId;
    map['inWareHouseName'] = inWareHouseName;
    map['outWareHouseId'] = outWareHouseId;
    map['outWareHouseName'] = outWareHouseName;
    map['tenantId'] = tenantId;
    map['fetchUserId'] = fetchUserId;
    map['fetchUserName'] = fetchUserName;
    map['fetchOrgName'] = fetchOrgName;
    map['fetchOrgId'] = fetchOrgId;
    map['fetchUserMobileNum'] = fetchUserMobileNum;
    map['taskStartTime'] = taskStartTime;
    map['taskEndTime'] = taskEndTime;
    map['taskName'] = taskName;
    map['rangeName'] = rangeName;
    map['rangeValue'] = rangeValue;
    map['dealUserId'] = dealUserId;
    map['dealUserName'] = dealUserName;
    map['dealStartTime'] = dealStartTime;
    map['dealEndTime'] = dealEndTime;
    map['dealOrgId'] = dealOrgId;
    map['dealOrgName'] = dealOrgName;
    map['materialType'] = materialType;
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