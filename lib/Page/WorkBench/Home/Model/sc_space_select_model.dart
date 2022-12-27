/// 空间-已选model
import 'dart:convert';
/// title : "海滨租户"
/// isSelect : false

SCSpaceSelectModel scSpaceSelectModelFromJson(String str) => SCSpaceSelectModel.fromJson(json.decode(str));
String scSpaceSelectModelToJson(SCSpaceSelectModel data) => json.encode(data.toJson());
class SCSpaceSelectModel {
  ScSpaceSelectModel({
      String? title, 
      bool? isSelect,}){
    _title = title;
    _isSelect = isSelect;
}

  SCSpaceSelectModel.fromJson(dynamic json) {
    _title = json['title'];
    _isSelect = json['isSelect'];
  }
  String? _title;/// 标题
  bool? _isSelect;/// 是否已选
  SCSpaceSelectModel copyWith({  String? title,
  bool? isSelect,
}) => ScSpaceSelectModel(  title: title ?? _title,
  isSelect: isSelect ?? _isSelect,
);
  String? get title => _title;
  bool? get isSelect => _isSelect;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['isSelect'] = _isSelect;
    return map;
  }

}