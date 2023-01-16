class SCHotelOrderModel {
  SCHotelOrderModel({
      this.id, 
      this.bizNo, 
      this.hotelId, 
      this.hotelName, 
      this.customerName, 
      this.customerMobileNum, 
      this.stateCode, 
      this.stateDesc, 
      this.roomState, 
      this.roomStateDesc, 
      this.orderHouseType, 
      this.gmtStartDate, 
      this.gmtEndDate, 
      this.orderPrice, 
      this.payedPrice, 
      this.payWay, 
      this.payWayCode, 
      this.customerSource, 
      this.customerSourceCode, 
      this.gmtCreateTime, 
      this.gmtModifyTime, 
      this.duration,});

  SCHotelOrderModel.fromJson(dynamic json) {
    id = json['id'];
    bizNo = json['bizNo'];
    hotelId = json['hotelId'];
    hotelName = json['hotelName'];
    customerName = json['customerName'];
    customerMobileNum = json['customerMobileNum'];
    stateCode = json['stateCode'];
    stateDesc = json['stateDesc'];
    roomState = json['roomState'];
    roomStateDesc = json['roomStateDesc'];
    orderHouseType = json['orderHouseType'] != null ? json['orderHouseType'].cast<String>() : [];
    gmtStartDate = json['gmtStartDate'];
    gmtEndDate = json['gmtEndDate'];
    orderPrice = json['orderPrice'];
    payedPrice = json['payedPrice'];
    payWay = json['payWay'];
    payWayCode = json['payWayCode'];
    customerSource = json['customerSource'];
    customerSourceCode = json['customerSourceCode'];
    gmtCreateTime = json['gmtCreateTime'];
    gmtModifyTime = json['gmtModifyTime'];
    duration = json['duration'];
  }
  int? id;
  String? bizNo;
  int? hotelId;
  String? hotelName;
  String? customerName;
  String? customerMobileNum;
  int? stateCode;
  String? stateDesc;
  int? roomState;
  String? roomStateDesc;
  List<String>? orderHouseType;
  String? gmtStartDate;
  String? gmtEndDate;
  double? orderPrice;
  double? payedPrice;
  String? payWay;
  int? payWayCode;
  String? customerSource;
  int? customerSourceCode;
  String? gmtCreateTime;
  String? gmtModifyTime;
  int? duration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['bizNo'] = bizNo;
    map['hotelId'] = hotelId;
    map['hotelName'] = hotelName;
    map['customerName'] = customerName;
    map['customerMobileNum'] = customerMobileNum;
    map['stateCode'] = stateCode;
    map['stateDesc'] = stateDesc;
    map['roomState'] = roomState;
    map['roomStateDesc'] = roomStateDesc;
    map['orderHouseType'] = orderHouseType;
    map['gmtStartDate'] = gmtStartDate;
    map['gmtEndDate'] = gmtEndDate;
    map['orderPrice'] = orderPrice;
    map['payedPrice'] = payedPrice;
    map['payWay'] = payWay;
    map['payWayCode'] = payWayCode;
    map['customerSource'] = customerSource;
    map['customerSourceCode'] = customerSourceCode;
    map['gmtCreateTime'] = gmtCreateTime;
    map['gmtModifyTime'] = gmtModifyTime;
    map['duration'] = duration;
    return map;
  }
}