/// 巡查分类model
class SCPatrolTypeModel {
  SCPatrolTypeModel({
      this.id, 
      this.pid, 
      this.children, 
      this.categoryName, 
      this.description, 
      this.type, 
      this.sort, 
      this.appCode, 
      this.path, 
      this.childrenIdList,});

  SCPatrolTypeModel.fromJson(dynamic json) {
    id = json['id'];
    pid = json['pid'];
    if (json['children'] != null) {
      children = [];
      json['children'].forEach((v) {
        children?.add(SCPatrolTypeModel.fromJson(v));
      });
    }
    categoryName = json['categoryName'];
    description = json['description'];
    type = json['type'];
    sort = json['sort'];
    appCode = json['appCode'];
    path = json['path'];
    childrenIdList = json['childrenIdList'] != null ? json['childrenIdList'].cast<int>() : [];
  }
  int? id;
  int? pid;
  List<SCPatrolTypeModel>? children;
  String? categoryName;
  dynamic description;
  int? type;
  int? sort;
  String? appCode;
  String? path;
  List<int>? childrenIdList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['pid'] = pid;
    if (children != null) {
      map['children'] = children?.map((v) => v.toJson()).toList();
    }
    map['categoryName'] = categoryName;
    map['description'] = description;
    map['type'] = type;
    map['sort'] = sort;
    map['appCode'] = appCode;
    map['path'] = path;
    map['childrenIdList'] = childrenIdList;
    return map;
  }

}
