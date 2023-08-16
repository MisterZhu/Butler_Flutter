/// 出库-选择分类tree-model
class SCSelectCategoryTreeModel {
  SCSelectCategoryTreeModel({
      this.id, 
      this.pid, 
      this.children, 
      this.orgName, 
      this.tenantId, 
      this.companyId, 
      this.sort, 
      this.orgType, 
      this.shortName, 
      this.englishName, 
      this.typeId, 
      this.unable, 
      this.defaultCreate, 
      this.creator, 
      this.creatorName, 
      this.gmtCreate, 
      this.operator, 
      this.gmtModify, 
      this.iconUrl,
      this.name,
      this.type,
  });

  SCSelectCategoryTreeModel.fromJson(dynamic json) {
    id = json['id'] is int ? json['id'].toString() : json['id'];
    pid = json['pid'] is int ? json['pid'].toString() : json['pid'];
    if (json['children'] != null) {
      children = [];
      json['children'].forEach((v) {
        children?.add(SCSelectCategoryTreeModel.fromJson(v));
      });
    }
    orgName = json['orgName'];
    tenantId = json['tenantId'];
    companyId = json['companyId'];
    sort = json['sort'];
    orgType = json['orgType'];
    shortName = json['shortName'];
    englishName = json['englishName'];
    typeId = json['typeId'];
    unable = json['unable'];
    defaultCreate = json['defaultCreate'];
    creator = json['creator'];
    creatorName = json['creatorName'];
    gmtCreate = json['gmtCreate'];
    operator = json['operator'];
    gmtModify = json['gmtModify'];
    iconUrl = json['iconUrl'];
    name = json['name'];
    type = json['type'];
  }
  String? id;
  String? pid;
  List<SCSelectCategoryTreeModel>? children;
  String? orgName;
  String? tenantId;
  String? companyId;
  int? sort;
  int? orgType;
  String? shortName;
  String? englishName;
  int? typeId;
  bool? unable;
  bool? defaultCreate;
  String? creator;
  String? creatorName;
  String? gmtCreate;
  String? operator;
  String? gmtModify;
  String? iconUrl;
  String? name;
  int? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['pid'] = pid;
    if (children != null) {
      map['children'] = children?.map((v) => v.toJson()).toList();
    }
    map['orgName'] = orgName;
    map['tenantId'] = tenantId;
    map['companyId'] = companyId;
    map['sort'] = sort;
    map['orgType'] = orgType;
    map['shortName'] = shortName;
    map['englishName'] = englishName;
    map['typeId'] = typeId;
    map['unable'] = unable;
    map['defaultCreate'] = defaultCreate;
    map['creator'] = creator;
    map['creatorName'] = creatorName;
    map['gmtCreate'] = gmtCreate;
    map['operator'] = operator;
    map['gmtModify'] = gmtModify;
    map['iconUrl'] = iconUrl;
    map['name'] = name;
    map['type'] = type;
    return map;
  }

}