/// id : "112701241972501"
/// name : "物业服务"
/// menuServerList : [{"id":10839653078701,"name":"工单助手","icon":{"fileKey":"0/wishare-auth/server/AuthMenuServerE/11270459593702_11374444241002/1664163640587103.png","name":null,"suffix":null,"size":null,"type":1},"moduleId":"112701241972501","form":1,"jumpType":0,"belong":0,"url":"https://saasdev.wisharetec.com/h5Manage-order/#/workOrder/orderList"}]

class SCApplicationModuleModel {
  SCApplicationModuleModel({
      String? id, 
      String? name, 
      List<MenuServerList>? menuServerList,}){
    _id = id;
    _name = name;
    _menuServerList = menuServerList;
}

  SCApplicationModuleModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    if (json['menuServerList'] != null) {
      _menuServerList = [];
      json['menuServerList'].forEach((v) {
        _menuServerList?.add(MenuServerList.fromJson(v));
      });
    }
  }
  String? _id;
  String? _name;
  List<MenuServerList>? _menuServerList;
  SCApplicationModuleModel copyWith({  String? id,
  String? name,
  List<MenuServerList>? menuServerList,
}) => SCApplicationModuleModel(  id: id ?? _id,
  name: name ?? _name,
  menuServerList: menuServerList ?? _menuServerList,
);
  String? get id => _id;
  String? get name => _name;
  List<MenuServerList>? get menuServerList => _menuServerList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    if (_menuServerList != null) {
      map['menuServerList'] = _menuServerList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 10839653078701
/// name : "工单助手"
/// icon : {"fileKey":"0/wishare-auth/server/AuthMenuServerE/11270459593702_11374444241002/1664163640587103.png","name":null,"suffix":null,"size":null,"type":1}
/// moduleId : "112701241972501"
/// form : 1
/// jumpType : 0
/// belong : 0
/// url : "https://saasdev.wisharetec.com/h5Manage-order/#/workOrder/orderList"

class MenuServerList {
  MenuServerList({
      int? id, 
      String? name, 
      Icon? icon, 
      String? moduleId, 
      int? form, 
      int? jumpType, 
      int? belong, 
      String? url,}){
    _id = id;
    _name = name;
    _icon = icon;
    _moduleId = moduleId;
    _form = form;
    _jumpType = jumpType;
    _belong = belong;
    _url = url;
}

  MenuServerList.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _icon = json['icon'] != null ? Icon.fromJson(json['icon']) : null;
    _moduleId = json['moduleId'];
    _form = json['form'];
    _jumpType = json['jumpType'];
    _belong = json['belong'];
    _url = json['url'];
  }
  int? _id;
  String? _name;
  Icon? _icon;
  String? _moduleId;
  int? _form;
  int? _jumpType;
  int? _belong;
  String? _url;
MenuServerList copyWith({  int? id,
  String? name,
  Icon? icon,
  String? moduleId,
  int? form,
  int? jumpType,
  int? belong,
  String? url,
}) => MenuServerList(  id: id ?? _id,
  name: name ?? _name,
  icon: icon ?? _icon,
  moduleId: moduleId ?? _moduleId,
  form: form ?? _form,
  jumpType: jumpType ?? _jumpType,
  belong: belong ?? _belong,
  url: url ?? _url,
);
  int? get id => _id;
  String? get name => _name;
  Icon? get icon => _icon;
  String? get moduleId => _moduleId;
  int? get form => _form;
  int? get jumpType => _jumpType;
  int? get belong => _belong;
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    if (_icon != null) {
      map['icon'] = _icon?.toJson();
    }
    map['moduleId'] = _moduleId;
    map['form'] = _form;
    map['jumpType'] = _jumpType;
    map['belong'] = _belong;
    map['url'] = _url;
    return map;
  }

}

/// fileKey : "0/wishare-auth/server/AuthMenuServerE/11270459593702_11374444241002/1664163640587103.png"
/// name : null
/// suffix : null
/// size : null
/// type : 1

class Icon {
  Icon({
      String? fileKey, 
      dynamic name, 
      dynamic suffix, 
      dynamic size, 
      int? type,}){
    _fileKey = fileKey;
    _name = name;
    _suffix = suffix;
    _size = size;
    _type = type;
}

  Icon.fromJson(dynamic json) {
    _fileKey = json['fileKey'];
    _name = json['name'];
    _suffix = json['suffix'];
    _size = json['size'];
    _type = json['type'];
  }
  String? _fileKey;
  dynamic _name;
  dynamic _suffix;
  dynamic _size;
  int? _type;
Icon copyWith({  String? fileKey,
  dynamic name,
  dynamic suffix,
  dynamic size,
  int? type,
}) => Icon(  fileKey: fileKey ?? _fileKey,
  name: name ?? _name,
  suffix: suffix ?? _suffix,
  size: size ?? _size,
  type: type ?? _type,
);
  String? get fileKey => _fileKey;
  dynamic get name => _name;
  dynamic get suffix => _suffix;
  dynamic get size => _size;
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