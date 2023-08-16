/// duty : true
/// personId : ""
/// personName : ""
/// phone : ""

/// 领用人model

class SCReceiverModel {
  SCReceiverModel({
      bool? duty, 
      String? personId, 
      String? personName, 
      String? phone,}){
    _duty = duty;
    _personId = personId;
    _personName = personName;
    _phone = phone;
}

  SCReceiverModel.fromJson(dynamic json) {
    _duty = json['duty'];
    _personId = json['personId'];
    _personName = json['personName'];
    _phone = json['phone'];
  }
  bool? _duty;
  String? _personId;
  String? _personName;
  String? _phone;
  SCReceiverModel copyWith({  bool? duty,
  String? personId,
  String? personName,
  String? phone,
}) => SCReceiverModel(  duty: duty ?? _duty,
  personId: personId ?? _personId,
  personName: personName ?? _personName,
  phone: phone ?? _phone,
);
  bool? get duty => _duty;
  String? get personId => _personId;
  String? get personName => _personName;
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['duty'] = _duty;
    map['personId'] = _personId;
    map['personName'] = _personName;
    map['phone'] = _phone;
    return map;
  }

}