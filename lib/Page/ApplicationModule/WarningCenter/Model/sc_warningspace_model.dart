/// 预警详情-空间信息model
class SCWarningSpaceModel {
  SCWarningSpaceModel({
    this.id,
    this.name,
    this.code,
    this.cover,
    this.province,
    this.city,
    this.area,
    this.shequ,
    this.street,
    this.longitude,
    this.latitude,
    this.type,
    this.stage,
    this.ownership,
    this.buildArea,
    this.contacts,
    this.contactsPhone,
    this.pic,
    this.remark,
    this.address,
    this.state,
    this.disabled,
    this.creator,
    this.operator,
    this.gmtCreate,
    this.gmtModify,
    this.orgId,
    this.typeNameFlag,
    this.developer,
    this.developerName,
    this.haveChild,
    this.takeOverDate,
  });

  SCWarningSpaceModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    cover = json['cover'];
    province = json['province'];
    city = json['city'];
    area = json['area'];
    shequ = json['shequ'];
    street = json['street'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    type = json['type'];
    stage = json['stage'];
    ownership = json['ownership'];
    buildArea = json['buildArea'];
    contacts = json['contacts'];
    contactsPhone = json['contactsPhone'];
    pic = json['pic'];
    remark = json['remark'];
    address = json['address'];
    state = json['state'];
    disabled = json['disabled'];
    creator = json['creator'];
    operator = json['operator'];
    gmtCreate = json['gmtCreate'];
    gmtModify = json['gmtModify'];
    orgId = json['orgId'];
    typeNameFlag = json['typeNameFlag'];
    developer = json['developer'];
    developerName = json['developerName'];
    haveChild = json['haveChild'];
    takeOverDate = json['takeOverDate'];
  }
  String? id;
  String? name;
  String? code;
  String? cover;
  String? province;
  String? city;
  String? area;
  String? shequ;
  String? street;
  String? longitude;
  String? latitude;
  int? type;
  String? stage;
  int? ownership;
  String? buildArea;
  String? contacts;
  String? contactsPhone;
  String? pic;
  String? remark;
  String? address;
  int? state;
  int? disabled;
  String? creator;
  String? operator;
  String? gmtCreate;
  String? gmtModify;
  int? orgId;
  String? typeNameFlag;
  String? developer;
  String? developerName;
  bool? haveChild;
  String? takeOverDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['code'] = code;
    map['cover'] = cover;
    map['province'] = province;
    map['city'] = city;
    map['area'] = area;
    map['shequ'] = shequ;
    map['street'] = street;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    map['type'] = type;
    map['stage'] = stage;
    map['ownership'] = ownership;
    map['buildArea'] = buildArea;
    map['contacts'] = contacts;
    map['contactsPhone'] = contactsPhone;
    map['pic'] = pic;
    map['remark'] = remark;
    map['address'] = address;
    map['state'] = state;
    map['disabled'] = disabled;
    map['creator'] = creator;
    map['operator'] = operator;
    map['gmtCreate'] = gmtCreate;
    map['gmtModify'] = gmtModify;
    map['orgId'] = orgId;
    map['typeNameFlag'] = typeNameFlag;
    map['developer'] = developer;
    map['developerName'] = developerName;
    map['haveChild'] = haveChild;
    map['takeOverDate'] = takeOverDate;
    return map;
  }
}
