/// 巡查详情-工单model
class SCTaskFrontDoModel {
  SCTaskFrontDoModel(
      {this.address,
      this.appointmentStartTime,
      this.appointmentStopTime,
      this.assistCount,
      this.asvCheck,
      this.audios,
      this.callbackTime,
      this.categoryId,
      this.categoryName,
      this.isOwn,
      this.communityName,
      this.countByTask,
      this.createTime,
      this.createUserId,
      this.createUserMobile,
      this.createUserName,
      this.departments,
      this.description,
      this.estimatedTime,
      this.images,
      this.isAssist,
      this.isCharge,
      this.isFee,
      this.isPay,
      this.isPayName,
      this.isRevisit,
      this.contactAddress,// 联系人房屋地址
      this.contactInform, // 联系人手机号
        this.typeDesc,// 任务类型
        this.subTypeDesc,
      });

  SCTaskFrontDoModel.fromJson(dynamic json) {
    address = json['address'];
    appointmentStartTime = json['appointmentStartTime'];
    appointmentStopTime = json['appointmentStopTime'];
    assistCount = json['assistCount'];
    asvCheck = json['asvCheck'];
    audios = json['audios'];
    callbackTime = json['callbackTime'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    communityId = json['communityId'];
    communityName = json['communityName'];
    countByTask = json['countByTask'];
    createTime = json['createTime'];
    createUserId = json['createUserId'];
    createUserMobile = json['createUserMobile'];
    createUserName = json['createUserName'];
    departments = json['departments'];
    description = json['description'];
    estimatedTime = json['estimatedTime'];
    images = json['images'];
    isAssist = json['isAssist'];
    isCharge = json['isCharge'];
    isFee = json['isFee'];
    isOwn = json['isOwn'];
    isPay = json['isPay'];
    isPayName = json['isPayName'];
    isRevisit = json['isRevisit'];
    contactAddress = json['contactAddress'];
    typeDesc = json['typeDesc'];
    subTypeDesc = json['subTypeDesc'];
  }
  String? address;
  String? appointmentStartTime;
  String? appointmentStopTime;
  String? assistCount;
  String? asvCheck;
  String? audios;
  String? callbackTime;
  String? categoryId;
  String? categoryName;
  String? communityId;
  String? communityName;
  String? countByTask;
  String? createTime;
  String? createUserId;
  String? createUserMobile;
  String? createUserName;
  String? departments;
  String? description;
  String? estimatedTime;
  String? images;
  String? isAssist;
  String? isCharge;
  String? isFee;
  String? isOwn;
  String? isPay;
  String? isPayName;
  String? isRevisit;
  String? contactAddress;
  String? contactInform;
  String? typeDesc;
  String? subTypeDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['appointmentStartTime'] = appointmentStartTime;
    map['appointmentStopTime'] = appointmentStopTime;
    map['assistCount'] = assistCount;
    map['asvCheck'] = asvCheck;
    map['audios'] = audios;
    map['callbackTime'] = callbackTime;
    map['categoryId'] = categoryId;
    map['categoryName'] = categoryName;
    map['communityId'] = communityId;
    map['communityName'] = communityName;
    map['countByTask'] = countByTask;
    map['createTime'] = createTime;
    map['createUserId'] = createUserId;
    map['createUserMobile'] = createUserMobile;
    map['createUserName'] = createUserName;
    map['departments'] = departments;
    map['description'] = description;
    map['estimatedTime'] = estimatedTime;
    map['images'] = images;
    map['isAssist'] = isAssist;
    map['isCharge'] = isCharge;
    map['isFee'] = isFee;
    map['isOwn'] = isOwn;
    map['isPay'] = isPay;
    map['isPayName'] = isPayName;
    map['isRevisit'] = isRevisit;
    map['contactAddress'] = contactAddress;
    map['typeDesc'] = typeDesc;
    map['subTypeDesc'] = subTypeDesc;
    return map;
  }
}
