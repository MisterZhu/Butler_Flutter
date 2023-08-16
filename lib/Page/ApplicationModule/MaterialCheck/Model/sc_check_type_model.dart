/// 新增物资-物资分类model
class SCCheckTypeModel {
  SCCheckTypeModel({
    this.id,
    this.pid,
    this.children,
    this.parentList,
    this.dictionaryCode,
    this.tenantId,
    this.parentName,
    this.parentId,
    this.name,
    this.code,
    this.level,
    this.sort,
    this.isSelected,
    this.remarks,
    this.disable,
  });

  SCCheckTypeModel.fromJson(dynamic json) {
    id = json['id'];
    pid = json['pid'];
    if (json['children'] != null) {
      children = [];
      json['children'].forEach((v) {
        children?.add(SCCheckTypeModel.fromJson(v));
      });
    }
    dictionaryCode = json['dictionaryCode'];
    tenantId = json['tenantId'];
    parentName = json['parentName'];
    parentId = json['parentId'];
    name = json['name'];
    code = json['code'];
    level = json['level'];
    sort = json['sort'];
    remarks = json['remarks'];
  }
  String? id;
  String? pid;
  List<SCCheckTypeModel>? children;
  List<SCCheckTypeModel>? parentList;
  String? dictionaryCode;
  String? tenantId;
  String? parentName;
  String? parentId;
  String? name;
  String? code;
  int? level;
  int? sort;
  String? remarks;
  bool? isSelected;
  bool? disable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['pid'] = pid;
    if (children != null) {
      map['children'] = children?.map((v) => v.toJson()).toList();
    }
    if (children != null) {
      map['parentList'] = parentList?.map((v) => v.toJson()).toList();
    }
    map['dictionaryCode'] = dictionaryCode;
    map['tenantId'] = tenantId;
    map['parentName'] = parentName;
    map['parentId'] = parentId;
    map['name'] = name;
    map['code'] = code;
    map['level'] = level;
    map['sort'] = sort;
    map['isSelected'] = isSelected;
    map['remarks'] = remarks;
    map['disable'] = disable;
    return map;
  }
}
