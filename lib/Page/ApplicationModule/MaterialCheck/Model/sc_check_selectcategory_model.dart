/// 盘点任务-选择物资分类model
// class SCCheckSelectCategoryModel {
class SCCheckSelectCategoryModel {
  SCCheckSelectCategoryModel({
    this.parentList,
    this.childList,
    this.title,
    this.isSelected,
    this.enable,});

  SCCheckSelectCategoryModel.fromJson(dynamic json) {
    if (json['parentList'] != null) {
      parentList = [];
      json['parentList'].forEach((v) {
        parentList?.add(SCCheckSelectCategoryModel.fromJson(v));
      });
    }
    if (json['childList'] != null) {
      childList = [];
      json['childList'].forEach((v) {
        childList?.add(SCCheckSelectCategoryModel.fromJson(v));
      });
    }
    title = json['title'];
    isSelected = json['isSelected'];
    enable = json['enable'];
  }
  List<SCCheckSelectCategoryModel>? parentList;
  List<SCCheckSelectCategoryModel>? childList;
  String? title;
  bool? isSelected;
  bool? enable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (parentList != null) {
      map['parentList'] = parentList?.map((v) => v.toJson()).toList();
    }
    if (childList != null) {
      map['childList'] = childList?.map((v) => v.toJson()).toList();
    }
    map['title'] = title;
    map['isSelected'] = isSelected;
    map['enable'] = enable;
    return map;
  }

}