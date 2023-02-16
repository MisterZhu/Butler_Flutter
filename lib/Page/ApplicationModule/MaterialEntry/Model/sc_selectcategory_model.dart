/// 选择分类-model

class SCSelectCategoryModel {
  SCSelectCategoryModel({
      this.enable, 
      this.title, 
      this.id,
      this.showArrow,
  });

  SCSelectCategoryModel.fromJson(dynamic json) {
    enable = json['enable'];
    title = json['title'];
    id = json['id'];
    showArrow = json['showArrow'];
  }
  bool? enable;
  String? title;
  String? id;
  bool? showArrow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enable'] = enable;
    map['title'] = title;
    map['id'] = id;
    map['showArrow'] = showArrow;
    return map;
  }

}