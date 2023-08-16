/// 项目normalModel
class SCCommunityCommonModel {
  SCCommunityCommonModel({
    this.title,
  });

  SCCommunityCommonModel.fromJson(dynamic json) {
    title = json['title'];
  }
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    return map;
  }
}
