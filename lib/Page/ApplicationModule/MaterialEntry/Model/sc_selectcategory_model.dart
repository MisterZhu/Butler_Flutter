/// 选择分类-model

class SCSelectCategoryModel {
  SCSelectCategoryModel({
      this.enable, 
      this.title, 
      this.id,
      this.showArrow,
      this.parentList,
    this.childList,
  });

  SCSelectCategoryModel.fromJson(dynamic json) {
    enable = json['enable'];
    title = json['title'];
    id = json['id'];
    showArrow = json['showArrow'];
    parentList = json['parentList'];
    childList = json['childList'];
  }
  bool? enable;// 是否可用
  String? title;// 标题
  String? id;// id
  bool? showArrow;// 是否显示详情icon
  List? parentList;// 父级list
  List? childList;// 子级 list

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enable'] = enable;
    map['title'] = title;
    map['id'] = id;
    map['showArrow'] = showArrow;
    map['parentList'] = parentList;
    map['childList'] = childList;
    return map;
  }

}