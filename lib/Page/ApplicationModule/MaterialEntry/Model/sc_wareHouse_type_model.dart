/// value : 99
/// label : "其它入库"

/// 仓库类型model

class SCWareHouseTypeModel {
  SCWareHouseTypeModel({
      int? value, 
      String? label,}){
    _value = value;
    _label = label;
}

  SCWareHouseTypeModel.fromJson(dynamic json) {
    _value = json['value'];
    _label = json['label'];
  }
  int? _value;
  String? _label;
  SCWareHouseTypeModel copyWith({  int? value,
  String? label,
}) => SCWareHouseTypeModel(  value: value ?? _value,
  label: label ?? _label,
);
  int? get value => _value;
  String? get label => _label;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = _value;
    map['label'] = _label;
    return map;
  }

}