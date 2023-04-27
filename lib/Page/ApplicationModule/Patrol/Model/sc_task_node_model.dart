class SCTaskNodeModel {
  SCTaskNodeModel({
      this.nodeId, 
      this.nodeName,});

  SCTaskNodeModel.fromJson(dynamic json) {
    nodeId = json['nodeId'];
    nodeName = json['nodeName'];
  }
  String? nodeId;
  String? nodeName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nodeId'] = nodeId;
    map['nodeName'] = nodeName;
    return map;
  }

}