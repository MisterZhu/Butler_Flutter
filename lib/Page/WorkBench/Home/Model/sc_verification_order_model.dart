/// 实地核验订单model
class SCVerificationOrderModel {
  SCVerificationOrderModel({
      this.id, 
      this.verifyCode, 
      this.enterpriseName, 
      this.day, 
      this.no, 
      this.baseId, 
      this.dealStatus, 
      this.completeStatus, 
      this.applyTime, 
      this.hotelRegisterBaseInfoV, 
      this.operatorName,});

  SCVerificationOrderModel.fromJson(dynamic json) {
    id = json['id'];
    verifyCode = json['verifyCode'];
    enterpriseName = json['enterpriseName'];
    day = json['day'];
    no = json['no'];
    baseId = json['baseId'];
    dealStatus = json['dealStatus'];
    completeStatus = json['completeStatus'];
    applyTime = json['applyTime'];
    hotelRegisterBaseInfoV = json['hotelRegisterBaseInfoV'];
    operatorName = json['operatorName'];
  }
  int? id;
  String? verifyCode;
  String? enterpriseName;
  String? day;
  int? no;
  int? baseId;
  int? dealStatus;
  int? completeStatus;
  String? applyTime;
  Map? hotelRegisterBaseInfoV;
  String? operatorName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['verifyCode'] = verifyCode;
    map['enterpriseName'] = enterpriseName;
    map['day'] = day;
    map['no'] = no;
    map['baseId'] = baseId;
    map['dealStatus'] = dealStatus;
    map['completeStatus'] = completeStatus;
    map['applyTime'] = applyTime;
    map['hotelRegisterBaseInfoV'] = hotelRegisterBaseInfoV;
    map['operatorName'] = operatorName;
    return map;
  }

}