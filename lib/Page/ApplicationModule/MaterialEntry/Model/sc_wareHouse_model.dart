/// id : ""
/// name : ""

/// 仓库列表model

class SCWareHouseModel {
  SCWareHouseModel({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  SCWareHouseModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
  SCWareHouseModel copyWith({  String? id,
  String? name,
}) => SCWareHouseModel(  id: id ?? _id,
  name: name ?? _name,
);
  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}