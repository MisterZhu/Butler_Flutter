class WorkOrder {
  String? orderId;
  String? serialNumber;
  String? categoryName;
  String? address;
  int? status;
  String? statusName;
  String? communityName;
  String? createTime;
  int? remainingTime;

  WorkOrder({this.orderId,
    this.serialNumber,
    this.categoryName,
    this.address,
    this.status,
    this.statusName,
    this.communityName,
    this.createTime,
    this.remainingTime});

  WorkOrder.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    serialNumber = json['serialNumber'];
    categoryName = json['categoryName'];
    address = json['address'];
    status = json['status'];
    statusName = json['statusName'];
    communityName = json['communityName'];
    createTime = json['createTime'];
    remainingTime = json['remainingTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['serialNumber'] = serialNumber;
    data['categoryName'] = categoryName;
    data['statusName'] = statusName;
    data['address'] = address;
    data['status'] = status;
    data['communityName'] = communityName;
    data['createTime'] = createTime;
    data['remainingTime'] = remainingTime;
    return data;
  }

}
