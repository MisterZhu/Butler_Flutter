/// 任务日志model

class SCTaskLogModel {
  SCTaskLogModel({
      this.action, 
      this.bizId, 
      this.bizObject, 
      this.content, 
      this.id, 
      this.operateTime, 
      this.operator, 
      this.title,});

  SCTaskLogModel.fromJson(dynamic json) {
    action = json['action'] != null ? Action.fromJson(json['action']) : null;
    bizId = json['bizId'];
    bizObject = json['bizObject'] != null ? BizObject.fromJson(json['bizObject']) : null;
    content = json['content'] != null ? Content.fromJson(json['content']) : null;
    id = json['id'];
    operateTime = json['operateTime'];
    operator = json['operator'] != null ? Operator.fromJson(json['operator']) : null;
    title = json['title'];
  }
  Action? action;
  String? bizId;
  BizObject? bizObject;
  Content? content;
  String? id;
  String? operateTime;
  Operator? operator;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (action != null) {
      map['action'] = action?.toJson();
    }
    map['bizId'] = bizId;
    if (bizObject != null) {
      map['bizObject'] = bizObject?.toJson();
    }
    if (content != null) {
      map['content'] = content?.toJson();
    }
    map['id'] = id;
    map['operateTime'] = operateTime;
    if (operator != null) {
      map['operator'] = operator?.toJson();
    }
    map['title'] = title;
    return map;
  }

}

class Operator {
  Operator({
      this.id, 
      this.name, 
      this.phone,});

  Operator.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
  }
  String? id;
  String? name;
  String? phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    return map;
  }

}

class Content {
  Content({
      this.options,});

  Content.fromJson(dynamic json) {
    if (json['options'] != null) {
      options = [];
      json['options'].forEach((v) {
        options?.add(Options.fromJson(v));
      });
    }
  }
  List<Options>? options;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (options != null) {
      map['options'] = options?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Options {
  Options({
      this.data, 
      this.style,});

  Options.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    style = json['style'] != null ? Style.fromJson(json['style']) : null;
  }
  Data? data;
  Style? style;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (style != null) {
      map['style'] = style?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
    this.text,
    this.type,
    this.wrap,
    this.fileKey,
    this.fileUrl,
    this.fileName,
    this.suffix,
  });

  Data.fromJson(dynamic json) {
    text = json['text'];
    type = json['type'];
    wrap = json['wrap'];
    fileKey = json['fileKey'];
    fileUrl = json['fileUrl'];
    fileName = json['fileName'];
    suffix = json['suffix'];
  }
  String? text;
  String? type;
  bool? wrap;
  String? fileKey;
  String? fileUrl;
  String? fileName;
  String? suffix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['type'] = type;
    map['wrap'] = wrap;
    map['fileKey'] = fileKey;
    map['fileUrl'] = fileUrl;
    map['fileName'] = fileName;
    map['suffix'] = suffix;
    return map;
  }

}

class Style {
  Style({
      this.bold, 
      this.color, 
      this.fontSize, 
      this.italic,});

  Style.fromJson(dynamic json) {
    bold = json['bold'];
    color = json['color'];
    fontSize = json['fontSize'];
    italic = json['italic'];
  }
  bool? bold;
  String? color;
  int? fontSize;
  bool? italic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bold'] = bold;
    map['color'] = color;
    map['fontSize'] = fontSize;
    map['italic'] = italic;
    return map;
  }

}

class BizObject {
  BizObject({
      this.bizCode, 
      this.objName,});

  BizObject.fromJson(dynamic json) {
    bizCode = json['bizCode'];
    objName = json['objName'];
  }
  String? bizCode;
  String? objName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bizCode'] = bizCode;
    map['objName'] = objName;
    return map;
  }

}

class Action {
  Action({
      this.code, 
      this.type, 
      this.value,});

  Action.fromJson(dynamic json) {
    code = json['code'];
    type = json['type'];
    value = json['value'];
  }
  String? code;
  String? type;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['type'] = type;
    map['value'] = value;
    return map;
  }

}