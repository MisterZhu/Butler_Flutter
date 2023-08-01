class SCHandleMessageCardModel {
  Null? noticeId;
  int? noticeArriveId;
  String? cardCode;
  int? noticeCardType;
  Null? noticeCardTypeName;
  String? title;
  Icon? icon;
  String? category;
  String? modelCode;
  String? modelCodeName;
  String? content;
  Null? displayItems;
  String? noticeTime;
  Null? creator;
  Null? creatorName;
  Null? gmtCreate;
  Null? linkImage;
  String? ext;
  TaskMsg? taskMsg;
  bool? checked;

  SCHandleMessageCardModel(
      {this.noticeId,
        this.noticeArriveId,
        this.cardCode,
        this.noticeCardType,
        this.noticeCardTypeName,
        this.title,
        this.icon,
        this.category,
        this.modelCode,
        this.modelCodeName,
        this.content,
        this.displayItems,
        this.noticeTime,
        this.creator,
        this.creatorName,
        this.gmtCreate,
        this.linkImage,
        this.ext,
        this.taskMsg,
        this.checked});

  SCHandleMessageCardModel.fromJson(Map<String, dynamic> json) {
    noticeId = json['noticeId'];
    noticeArriveId = json['noticeArriveId'];
    cardCode = json['cardCode'];
    noticeCardType = json['noticeCardType'];
    noticeCardTypeName = json['noticeCardTypeName'];
    title = json['title'];
    icon = json['icon'] != null ? new Icon.fromJson(json['icon']) : null;
    category = json['category'];
    modelCode = json['modelCode'];
    modelCodeName = json['modelCodeName'];
    content = json['content'];
    displayItems = json['displayItems'];
    noticeTime = json['noticeTime'];
    creator = json['creator'];
    creatorName = json['creatorName'];
    gmtCreate = json['gmtCreate'];
    linkImage = json['linkImage'];
    ext = json['ext'];
    taskMsg =
    json['taskMsg'] != null ? new TaskMsg.fromJson(json['taskMsg']) : null;
    checked = json['checked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['noticeId'] = this.noticeId;
    data['noticeArriveId'] = this.noticeArriveId;
    data['cardCode'] = this.cardCode;
    data['noticeCardType'] = this.noticeCardType;
    data['noticeCardTypeName'] = this.noticeCardTypeName;
    data['title'] = this.title;
    if (this.icon != null) {
      data['icon'] = this.icon!.toJson();
    }
    data['category'] = this.category;
    data['modelCode'] = this.modelCode;
    data['modelCodeName'] = this.modelCodeName;
    data['content'] = this.content;
    data['displayItems'] = this.displayItems;
    data['noticeTime'] = this.noticeTime;
    data['creator'] = this.creator;
    data['creatorName'] = this.creatorName;
    data['gmtCreate'] = this.gmtCreate;
    data['linkImage'] = this.linkImage;
    data['ext'] = this.ext;
    if (this.taskMsg != null) {
      data['taskMsg'] = this.taskMsg!.toJson();
    }
    data['checked'] = this.checked;
    return data;
  }
}

class Icon {
  String? fileKey;
  Null? name;
  Null? suffix;
  Null? size;
  int? type;

  Icon({this.fileKey, this.name, this.suffix, this.size, this.type});

  Icon.fromJson(Map<String, dynamic> json) {
    fileKey = json['fileKey'];
    name = json['name'];
    suffix = json['suffix'];
    size = json['size'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileKey'] = this.fileKey;
    data['name'] = this.name;
    data['suffix'] = this.suffix;
    data['size'] = this.size;
    data['type'] = this.type;
    return data;
  }
}

class TaskMsg {
  String? taskId;
  String? serialNumber;
  String? appName;
  String? appDesc;
  String? type;
  String? typeDesc;
  String? subType;
  Null? subTypeDesc;
  String? statusName;
  String? statusValue;
  String? code;
  String? title;

  TaskMsg(
      {this.taskId,
        this.serialNumber,
        this.appName,
        this.appDesc,
        this.type,
        this.typeDesc,
        this.subType,
        this.subTypeDesc,
        this.statusName,
        this.statusValue,
        this.code,
        this.title});

  TaskMsg.fromJson(Map<String, dynamic> json) {
    taskId = json['taskId'];
    serialNumber = json['serialNumber'];
    appName = json['appName'];
    appDesc = json['appDesc'];
    type = json['type'];
    typeDesc = json['typeDesc'];
    subType = json['subType'];
    subTypeDesc = json['subTypeDesc'];
    statusName = json['statusName'];
    statusValue = json['statusValue'];
    code = json['code'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskId'] = this.taskId;
    data['serialNumber'] = this.serialNumber;
    data['appName'] = this.appName;
    data['appDesc'] = this.appDesc;
    data['type'] = this.type;
    data['typeDesc'] = this.typeDesc;
    data['subType'] = this.subType;
    data['subTypeDesc'] = this.subTypeDesc;
    data['statusName'] = this.statusName;
    data['statusValue'] = this.statusValue;
    data['code'] = this.code;
    data['title'] = this.title;
    return data;
  }
}