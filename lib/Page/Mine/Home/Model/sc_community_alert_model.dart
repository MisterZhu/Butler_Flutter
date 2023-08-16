/// 项目model
class SCCommunityAlertModel {
  SCCommunityAlertModel({
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
      this.developer, 
      this.state, 
      this.tenantId, 
      this.disabled, 
      this.creator, 
      this.operator, 
      this.gmtCreate, 
      this.gmtModify, 
      this.orgId, 
      this.typeNameFlag, 
      this.takeOverDate,});

  SCCommunityAlertModel.fromJson(dynamic json) {
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
    developer = json['developer'];
    state = json['state'];
    tenantId = json['tenantId'];
    disabled = json['disabled'];
    creator = json['creator'];
    operator = json['operator'];
    gmtCreate = json['gmtCreate'];
    gmtModify = json['gmtModify'];
    orgId = json['orgId'];
    typeNameFlag = json['typeNameFlag'];
    takeOverDate = json['takeOverDate'];
  }
  String? id;
  String? name;
  dynamic code;
  dynamic cover;
  String? province;
  String? city;
  String? area;
  String? shequ;
  String? street;
  dynamic longitude;
  dynamic latitude;
  int? type;
  String? stage;
  int? ownership;
  String? buildArea;
  String? contacts;
  String? contactsPhone;
  String? developer;
  int? state;
  String? tenantId;
  int? disabled;
  String? creator;
  String? operator;
  String? gmtCreate;
  String? gmtModify;
  int? orgId;
  String? typeNameFlag;
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
    map['developer'] = developer;
    map['state'] = state;
    map['tenantId'] = tenantId;
    map['disabled'] = disabled;
    map['creator'] = creator;
    map['operator'] = operator;
    map['gmtCreate'] = gmtCreate;
    map['gmtModify'] = gmtModify;
    map['orgId'] = orgId;
    map['typeNameFlag'] = typeNameFlag;
    map['takeOverDate'] = takeOverDate;
    return map;
  }

}