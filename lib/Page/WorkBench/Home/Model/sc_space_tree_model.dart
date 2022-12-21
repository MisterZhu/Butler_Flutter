/// communityId : ""
/// flag : ""
/// floor : 0
/// iconUrl : ""
/// isLeaf : true
/// title : ""
/// type : 0
/// unable : ""
/// value : ""

class SCSpaceTreeModel {
  SCSpaceTreeModel({
      String? communityId, 
      String? flag, 
      int? floor, 
      String? iconUrl, 
      bool? isLeaf, 
      String? title, 
      int? type, 
      String? unable, 
      String? value,}){
    _communityId = communityId;
    _flag = flag;
    _floor = floor;
    _iconUrl = iconUrl;
    _isLeaf = isLeaf;
    _title = title;
    _type = type;
    _unable = unable;
    _value = value;
}

  SCSpaceTreeModel.fromJson(dynamic json) {
    _communityId = json['communityId'];
    _flag = json['flag'];
    _floor = json['floor'];
    _iconUrl = json['iconUrl'];
    _isLeaf = json['isLeaf'];
    _title = json['title'];
    _type = json['type'];
    _unable = json['unable'];
    _value = json['value'];
  }
  String? _communityId;
  String? _flag;
  int? _floor;
  String? _iconUrl;
  bool? _isLeaf;
  String? _title;
  int? _type;
  String? _unable;
  String? _value;
  SCSpaceTreeModel copyWith({  String? communityId,
  String? flag,
  int? floor,
  String? iconUrl,
  bool? isLeaf,
  String? title,
  int? type,
  String? unable,
  String? value,
}) => SCSpaceTreeModel(  communityId: communityId ?? _communityId,
  flag: flag ?? _flag,
  floor: floor ?? _floor,
  iconUrl: iconUrl ?? _iconUrl,
  isLeaf: isLeaf ?? _isLeaf,
  title: title ?? _title,
  type: type ?? _type,
  unable: unable ?? _unable,
  value: value ?? _value,
);
  String? get communityId => _communityId;
  String? get flag => _flag;
  int? get floor => _floor;
  String? get iconUrl => _iconUrl;
  bool? get isLeaf => _isLeaf;
  String? get title => _title;
  int? get type => _type;
  String? get unable => _unable;
  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['communityId'] = _communityId;
    map['flag'] = _flag;
    map['floor'] = _floor;
    map['iconUrl'] = _iconUrl;
    map['isLeaf'] = _isLeaf;
    map['title'] = _title;
    map['type'] = _type;
    map['unable'] = _unable;
    map['value'] = _value;
    return map;
  }

}