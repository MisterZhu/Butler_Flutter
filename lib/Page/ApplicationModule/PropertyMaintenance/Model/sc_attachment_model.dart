/// 附件model
class SCAttachmentModel {
  SCAttachmentModel({
      this.path, 
      this.name, 
      this.size,});

  SCAttachmentModel.fromJson(dynamic json) {
    path = json['path'];
    name = json['name'];
    size = json['size'];
  }
  String? path;
  String? name;
  int? size;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['path'] = path;
    map['name'] = name;
    map['size'] = size;
    return map;
  }

}