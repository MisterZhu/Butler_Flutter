/// 空间model
/// id : "698"
/// pid : "0"
/// children : [{"id":"6c48f7bc-1373-11eb-acb3-6c2b5986eb15","pid":"698","children":[],"title":"海滨项目三","flag":1,"isLeaf":false,"value":"6c48f7bc-1373-11eb-acb3-6c2b5986eb15","iconUrl":"eb1e1ad8-85af-42d0-ba3c-21229be19009/space/SpaceTypeOperationalF/10980035643317.9648e0c5-6f1b-43ac-8130-fa25f852f821/1667456887475101.png","type":10980035643317,"floor":"","unable":0,"communityId":""}]
/// title : "海滨租户"
/// flag : 0
/// isLeaf : false
/// value : ""
/// iconUrl : ""
/// type : -1
/// floor : ""
/// unable : 0
/// communityId : ""

class SCSpaceModel {
  SCSpaceModel({
      String? id, 
      String? pid, 
      List<SCSpaceModel>? children,
      String? title, 
      int? flag, 
      bool? isLeaf, 
      String? value, 
      String? iconUrl, 
      int? type, 
      String? floor, 
      int? unable, 
      String? communityId,}){
    _id = id;
    _pid = pid;
    _children = children;
    _title = title;
    _flag = flag;
    _isLeaf = isLeaf;
    _value = value;
    _iconUrl = iconUrl;
    _type = type;
    _floor = floor;
    _unable = unable;
    _communityId = communityId;
}

  SCSpaceModel.fromJson(dynamic json) {
    _id = json['id'];
    _pid = json['pid'];
    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
        _children?.add(SCSpaceModel.fromJson(v));
      });
    }
    _title = json['title'];
    _flag = json['flag'];
    _isLeaf = json['isLeaf'];
    _value = json['value'];
    _iconUrl = json['iconUrl'];
    _type = json['type'];
    _floor = json['floor'];
    _unable = json['unable'];
    _communityId = json['communityId'];
  }
  String? _id;
  String? _pid;
  List<SCSpaceModel>? _children;
  String? _title;
  int? _flag;
  bool? _isLeaf;
  String? _value;
  String? _iconUrl;
  int? _type;
  String? _floor;
  int? _unable;
  String? _communityId;
  SCSpaceModel copyWith({  String? id,
  String? pid,
  List<SCSpaceModel>? children,
  String? title,
  int? flag,
  bool? isLeaf,
  String? value,
  String? iconUrl,
  int? type,
  String? floor,
  int? unable,
  String? communityId,
}) => SCSpaceModel(  id: id ?? _id,
  pid: pid ?? _pid,
  children: children ?? _children,
  title: title ?? _title,
  flag: flag ?? _flag,
  isLeaf: isLeaf ?? _isLeaf,
  value: value ?? _value,
  iconUrl: iconUrl ?? _iconUrl,
  type: type ?? _type,
  floor: floor ?? _floor,
  unable: unable ?? _unable,
  communityId: communityId ?? _communityId,
);
  String? get id => _id;
  String? get pid => _pid;
  List<SCSpaceModel>? get children => _children;
  String? get title => _title;
  int? get flag => _flag;
  bool? get isLeaf => _isLeaf;
  String? get value => _value;
  String? get iconUrl => _iconUrl;
  int? get type => _type;
  String? get floor => _floor;
  int? get unable => _unable;
  String? get communityId => _communityId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['pid'] = _pid;
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    map['title'] = _title;
    map['flag'] = _flag;
    map['isLeaf'] = _isLeaf;
    map['value'] = _value;
    map['iconUrl'] = _iconUrl;
    map['type'] = _type;
    map['floor'] = _floor;
    map['unable'] = _unable;
    map['communityId'] = _communityId;
    return map;
  }

}