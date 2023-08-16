import 'dart:convert';
/// 上传用户头像model
/// fileKey : "tmp/eb1e1ad8-85af-42d0-ba3c-21229be19009/20230103/1672714597335101.jpg"
/// name : "tmp_8128b64e56aa9c8043dfee89c120c384.jpg"
/// suffix : "jpg"
/// size : 266757
/// type : 0

SCHeadPicModel scHeadPicModelFromJson(String str) => SCHeadPicModel.fromJson(json.decode(str));
String scHeadPicModelToJson(SCHeadPicModel data) => json.encode(data.toJson());
class SCHeadPicModel {
  SCHeadPicModel({
      String? fileKey, 
      String? name, 
      String? suffix, 
      int? size, 
      int? type,}){
    _fileKey = fileKey;
    _name = name;
    _suffix = suffix;
    _size = size;
    _type = type;
}

  SCHeadPicModel.fromJson(dynamic json) {
    _fileKey = json['fileKey'];
    _name = json['name'];
    _suffix = json['suffix'];
    _size = json['size'];
    _type = json['type'];
  }
  String? _fileKey;
  String? _name;
  String? _suffix;
  int? _size;
  int? _type;
  SCHeadPicModel copyWith({  String? fileKey,
  String? name,
  String? suffix,
  int? size,
  int? type,
}) => SCHeadPicModel(  fileKey: fileKey ?? _fileKey,
  name: name ?? _name,
  suffix: suffix ?? _suffix,
  size: size ?? _size,
  type: type ?? _type,
);
  String? get fileKey => _fileKey;
  String? get name => _name;
  String? get suffix => _suffix;
  int? get size => _size;
  int? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fileKey'] = _fileKey;
    map['name'] = _name;
    map['suffix'] = _suffix;
    map['size'] = _size;
    map['type'] = _type;
    return map;
  }

}