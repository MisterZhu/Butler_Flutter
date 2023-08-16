class TaskCheckModel {
  String? checkId;
  String? nodeId;
  String? procInstId;
  String? taskId;

  TaskCheckModel({this.checkId, this.nodeId, this.procInstId, this.taskId});

  TaskCheckModel.fromJson(Map<String, dynamic> json) {
    checkId = json['checkId'];
    nodeId = json['nodeId'];
    procInstId = json['procInstId'];
    taskId = json['taskId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['checkId'] = checkId;
    data['nodeId'] = nodeId;
    data['procInstId'] = procInstId;
    data['taskId'] = taskId;
    return data;
  }
}
