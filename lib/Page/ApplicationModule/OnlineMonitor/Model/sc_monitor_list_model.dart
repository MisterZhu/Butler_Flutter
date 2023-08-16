class SCMonitorListModel {
  SCMonitorListModel({
      this.cameraId, 
      this.cameraName, 
      this.communityId, 
      this.communityName, 
      this.id, 
      this.manufacturer, 
      this.status,
      this.picUrl});

  SCMonitorListModel.fromJson(dynamic json) {
    cameraId = json['cameraId'];
    cameraName = json['cameraName'];
    communityId = json['communityId'];
    communityName = json['communityName'];
    id = json['id'];
    manufacturer = json['manufacturer'];
    status = json['status'];
    picUrl = json['picUrl'];
  }
  String? cameraId;
  String? cameraName;
  String? communityId;
  String? communityName;
  int? id;
  int? manufacturer;
  int? status;
  String? picUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cameraId'] = cameraId;
    map['cameraName'] = cameraName;
    map['communityId'] = communityId;
    map['communityName'] = communityName;
    map['id'] = id;
    map['manufacturer'] = manufacturer;
    map['status'] = status;
    map['picUrl'] = picUrl;
    return map;
  }

}