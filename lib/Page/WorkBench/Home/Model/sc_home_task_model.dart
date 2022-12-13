/// id : "1"
/// name : "工单"
/// isSelect : false

class SCHomeTaskModel {
  SCHomeTaskModel({
    String? id,
    String? name,
      bool? isSelect,}){
    _name = name;
    _isSelect = isSelect;
}

  SCHomeTaskModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _isSelect = json['isSelect'];
  }
  String? _id;
  String? _name;
  bool? _isSelect;
  SCHomeTaskModel copyWith({  String? id,String? name,
  bool? isSelect,
}) => SCHomeTaskModel(  id: id ?? _id,
    name: name ?? _name,
  isSelect: isSelect ?? _isSelect,
);
  String? get id => _id;
  String? get name => _name;
  bool? get isSelect => _isSelect;

  /// set isSelect
  set isSelect(bool? value) {
    _isSelect = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['isSelect'] = _isSelect;
    return map;
  }

}