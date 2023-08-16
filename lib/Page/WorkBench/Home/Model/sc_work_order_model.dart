/// address : ""
/// appointmentStartTime : ""
/// appointmentStopTime : ""
/// assistCount : 0
/// audios : ""
/// callbackTime : ""
/// categoryId : ""
/// categoryName : ""
/// communityId : ""
/// communityName : ""
/// countByTask : 0
/// createTime : ""
/// createUserId : ""
/// createUserMobile : ""
/// createUserName : ""
/// description : ""
/// estimatedTime : 0
/// images : ""
/// isAssist : 0
/// isCharge : 0
/// isFee : 0
/// isOwn : 0
/// isPay : 0
/// isRevisit : 0
/// isTransfer : 0
/// lastTaskRemind : ""
/// orderId : ""
/// processTime : 0
/// processUserId : ""
/// processUserMobile : ""
/// processUserName : ""
/// receiveTime : 0
/// remainingTime : 0
/// reportUserId : ""
/// reportUserName : ""
/// reportUserPhone : ""
/// revisitEvaluation : ""
/// sendApplyStatus : 0
/// serialNumber : ""
/// source : ""
/// spaceId : 0
/// status : 0
/// taskType : 0
/// videos : ""

class SCWorkOrderModel {
  SCWorkOrderModel({
      String? address, 
      String? appointmentStartTime, 
      String? appointmentStopTime, 
      int? assistCount, 
      String? audios, 
      String? callbackTime, 
      String? categoryId, 
      String? categoryName, 
      String? communityId, 
      String? communityName, 
      int? countByTask, 
      String? createTime, 
      String? createUserId, 
      String? createUserMobile, 
      String? createUserName, 
      String? description, 
      int? estimatedTime, 
      String? images, 
      int? isAssist, 
      int? isCharge, 
      int? isFee, 
      int? isOwn, 
      int? isPay, 
      int? isRevisit, 
      int? isTransfer, 
      String? lastTaskRemind, 
      String? orderId, 
      int? processTime, 
      String? processUserId, 
      String? processUserMobile, 
      String? processUserName, 
      int? receiveTime, 
      int? remainingTime, 
      String? reportUserId, 
      String? reportUserName, 
      String? reportUserPhone, 
      String? revisitEvaluation, 
      int? sendApplyStatus, 
      String? serialNumber, 
      String? source, 
      String? spaceId,
      int? status, 
      int? taskType, 
      String? videos,
    bool? asvCheck,
    int? yycOrderType,/// 亚运村工单类型，101-回退，99-提交检测，100-通过
  }){
    _address = address;
    _appointmentStartTime = appointmentStartTime;
    _appointmentStopTime = appointmentStopTime;
    _assistCount = assistCount;
    _audios = audios;
    _callbackTime = callbackTime;
    _categoryId = categoryId;
    _categoryName = categoryName;
    _communityId = communityId;
    _communityName = communityName;
    _countByTask = countByTask;
    _createTime = createTime;
    _createUserId = createUserId;
    _createUserMobile = createUserMobile;
    _createUserName = createUserName;
    _description = description;
    _estimatedTime = estimatedTime;
    _images = images;
    _isAssist = isAssist;
    _isCharge = isCharge;
    _isFee = isFee;
    _isOwn = isOwn;
    _isPay = isPay;
    _isRevisit = isRevisit;
    _isTransfer = isTransfer;
    _lastTaskRemind = lastTaskRemind;
    _orderId = orderId;
    _processTime = processTime;
    _processUserId = processUserId;
    _processUserMobile = processUserMobile;
    _processUserName = processUserName;
    _receiveTime = receiveTime;
    _remainingTime = remainingTime;
    _reportUserId = reportUserId;
    _reportUserName = reportUserName;
    _reportUserPhone = reportUserPhone;
    _revisitEvaluation = revisitEvaluation;
    _sendApplyStatus = sendApplyStatus;
    _serialNumber = serialNumber;
    _source = source;
    _spaceId = spaceId;
    _status = status;
    _taskType = taskType;
    _videos = videos;
    _asvCheck = asvCheck;
    _yycOrderType = yycOrderType;
}

  SCWorkOrderModel.fromJson(dynamic json) {
    _address = json['address'];
    _appointmentStartTime = json['appointmentStartTime'];
    _appointmentStopTime = json['appointmentStopTime'];
    _assistCount = json['assistCount'];
    _audios = json['audios'];
    _callbackTime = json['callbackTime'];
    _categoryId = json['categoryId'];
    _categoryName = json['categoryName'];
    _communityId = json['communityId'];
    _communityName = json['communityName'];
    _countByTask = json['countByTask'];
    _createTime = json['createTime'];
    _createUserId = json['createUserId'];
    _createUserMobile = json['createUserMobile'];
    _createUserName = json['createUserName'];
    _description = json['description'];
    _estimatedTime = json['estimatedTime'];
    _images = json['images'];
    _isAssist = json['isAssist'];
    _isCharge = json['isCharge'];
    _isFee = json['isFee'];
    _isOwn = json['isOwn'];
    _isPay = json['isPay'];
    _isRevisit = json['isRevisit'];
    _isTransfer = json['isTransfer'];
    _lastTaskRemind = json['lastTaskRemind'];
    _orderId = json['orderId'];
    _processTime = json['processTime'];
    _processUserId = json['processUserId'];
    _processUserMobile = json['processUserMobile'];
    _processUserName = json['processUserName'];
    _receiveTime = json['receiveTime'];
    _remainingTime = json['remainingTime'];
    _reportUserId = json['reportUserId'];
    _reportUserName = json['reportUserName'];
    _reportUserPhone = json['reportUserPhone'];
    _revisitEvaluation = json['revisitEvaluation'];
    _sendApplyStatus = json['sendApplyStatus'];
    _serialNumber = json['serialNumber'];
    _source = json['source'];
    _spaceId = json['spaceId'];
    _status = json['status'];
    _taskType = json['taskType'];
    _videos = json['videos'];
    _asvCheck = json['asvCheck'];
    _yycOrderType = json['yycOrderType'];
  }
  String? _address;
  String? _appointmentStartTime;
  String? _appointmentStopTime;
  int? _assistCount;
  String? _audios;
  String? _callbackTime;
  String? _categoryId;
  String? _categoryName;
  String? _communityId;
  String? _communityName;
  int? _countByTask;
  String? _createTime;
  String? _createUserId;
  String? _createUserMobile;
  String? _createUserName;
  String? _description;
  int? _estimatedTime;
  String? _images;
  int? _isAssist;
  int? _isCharge;
  int? _isFee;
  int? _isOwn;
  int? _isPay;
  int? _isRevisit;
  int? _isTransfer;
  String? _lastTaskRemind;
  String? _orderId;
  int? _processTime;
  String? _processUserId;
  String? _processUserMobile;
  String? _processUserName;
  int? _receiveTime;
  int? _remainingTime;
  String? _reportUserId;
  String? _reportUserName;
  String? _reportUserPhone;
  String? _revisitEvaluation;
  int? _sendApplyStatus;
  String? _serialNumber;
  String? _source;
  String? _spaceId;
  int? _status;
  int? _taskType;
  String? _videos;
  bool? _asvCheck;
  int? _yycOrderType;
  SCWorkOrderModel copyWith({  String? address,
  String? appointmentStartTime,
  String? appointmentStopTime,
  int? assistCount,
  String? audios,
  String? callbackTime,
  String? categoryId,
  String? categoryName,
  String? communityId,
  String? communityName,
  int? countByTask,
  String? createTime,
  String? createUserId,
  String? createUserMobile,
  String? createUserName,
  String? description,
  int? estimatedTime,
  String? images,
  int? isAssist,
  int? isCharge,
  int? isFee,
  int? isOwn,
  int? isPay,
  int? isRevisit,
  int? isTransfer,
  String? lastTaskRemind,
  String? orderId,
  int? processTime,
  String? processUserId,
  String? processUserMobile,
  String? processUserName,
  int? receiveTime,
  int? remainingTime,
  String? reportUserId,
  String? reportUserName,
  String? reportUserPhone,
  String? revisitEvaluation,
  int? sendApplyStatus,
  String? serialNumber,
  String? source,
  String? spaceId,
  int? status,
  int? taskType,
  String? videos,
    bool? asvCheck,
    int? yycOrderType,
}) => SCWorkOrderModel(  address: address ?? _address,
  appointmentStartTime: appointmentStartTime ?? _appointmentStartTime,
  appointmentStopTime: appointmentStopTime ?? _appointmentStopTime,
  assistCount: assistCount ?? _assistCount,
  audios: audios ?? _audios,
  callbackTime: callbackTime ?? _callbackTime,
  categoryId: categoryId ?? _categoryId,
  categoryName: categoryName ?? _categoryName,
  communityId: communityId ?? _communityId,
  communityName: communityName ?? _communityName,
  countByTask: countByTask ?? _countByTask,
  createTime: createTime ?? _createTime,
  createUserId: createUserId ?? _createUserId,
  createUserMobile: createUserMobile ?? _createUserMobile,
  createUserName: createUserName ?? _createUserName,
  description: description ?? _description,
  estimatedTime: estimatedTime ?? _estimatedTime,
  images: images ?? _images,
  isAssist: isAssist ?? _isAssist,
  isCharge: isCharge ?? _isCharge,
  isFee: isFee ?? _isFee,
  isOwn: isOwn ?? _isOwn,
  isPay: isPay ?? _isPay,
  isRevisit: isRevisit ?? _isRevisit,
  isTransfer: isTransfer ?? _isTransfer,
  lastTaskRemind: lastTaskRemind ?? _lastTaskRemind,
  orderId: orderId ?? _orderId,
  processTime: processTime ?? _processTime,
  processUserId: processUserId ?? _processUserId,
  processUserMobile: processUserMobile ?? _processUserMobile,
  processUserName: processUserName ?? _processUserName,
  receiveTime: receiveTime ?? _receiveTime,
  remainingTime: remainingTime ?? _remainingTime,
  reportUserId: reportUserId ?? _reportUserId,
  reportUserName: reportUserName ?? _reportUserName,
  reportUserPhone: reportUserPhone ?? _reportUserPhone,
  revisitEvaluation: revisitEvaluation ?? _revisitEvaluation,
  sendApplyStatus: sendApplyStatus ?? _sendApplyStatus,
  serialNumber: serialNumber ?? _serialNumber,
  source: source ?? _source,
  spaceId: spaceId ?? _spaceId,
  status: status ?? _status,
  taskType: taskType ?? _taskType,
  videos: videos ?? _videos,
      asvCheck: asvCheck ?? _asvCheck,
      yycOrderType: yycOrderType ?? _yycOrderType,
);
  String? get address => _address;
  String? get appointmentStartTime => _appointmentStartTime;
  String? get appointmentStopTime => _appointmentStopTime;
  int? get assistCount => _assistCount;
  String? get audios => _audios;
  String? get callbackTime => _callbackTime;
  String? get categoryId => _categoryId;
  String? get categoryName => _categoryName;
  String? get communityId => _communityId;
  String? get communityName => _communityName;
  int? get countByTask => _countByTask;
  String? get createTime => _createTime;
  String? get createUserId => _createUserId;
  String? get createUserMobile => _createUserMobile;
  String? get createUserName => _createUserName;
  String? get description => _description;
  int? get estimatedTime => _estimatedTime;
  String? get images => _images;
  int? get isAssist => _isAssist;
  int? get isCharge => _isCharge;
  int? get isFee => _isFee;
  int? get isOwn => _isOwn;
  int? get isPay => _isPay;
  int? get isRevisit => _isRevisit;
  int? get isTransfer => _isTransfer;
  String? get lastTaskRemind => _lastTaskRemind;
  String? get orderId => _orderId;
  int? get processTime => _processTime;
  String? get processUserId => _processUserId;
  String? get processUserMobile => _processUserMobile;
  String? get processUserName => _processUserName;
  int? get receiveTime => _receiveTime;
  int? get remainingTime => _remainingTime;
  String? get reportUserId => _reportUserId;
  String? get reportUserName => _reportUserName;
  String? get reportUserPhone => _reportUserPhone;
  String? get revisitEvaluation => _revisitEvaluation;
  int? get sendApplyStatus => _sendApplyStatus;
  String? get serialNumber => _serialNumber;
  String? get source => _source;
  String? get spaceId => _spaceId;
  int? get status => _status;
  int? get taskType => _taskType;
  String? get videos => _videos;
  bool? get asvCheck => _asvCheck;
  int? get yycOrderType => _yycOrderType;

  set remainingTime(int? value) {
    _remainingTime = value;
  }

  set yycOrderType(int? value) {
    _yycOrderType = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['appointmentStartTime'] = _appointmentStartTime;
    map['appointmentStopTime'] = _appointmentStopTime;
    map['assistCount'] = _assistCount;
    map['audios'] = _audios;
    map['callbackTime'] = _callbackTime;
    map['categoryId'] = _categoryId;
    map['categoryName'] = _categoryName;
    map['communityId'] = _communityId;
    map['communityName'] = _communityName;
    map['countByTask'] = _countByTask;
    map['createTime'] = _createTime;
    map['createUserId'] = _createUserId;
    map['createUserMobile'] = _createUserMobile;
    map['createUserName'] = _createUserName;
    map['description'] = _description;
    map['estimatedTime'] = _estimatedTime;
    map['images'] = _images;
    map['isAssist'] = _isAssist;
    map['isCharge'] = _isCharge;
    map['isFee'] = _isFee;
    map['isOwn'] = _isOwn;
    map['isPay'] = _isPay;
    map['isRevisit'] = _isRevisit;
    map['isTransfer'] = _isTransfer;
    map['lastTaskRemind'] = _lastTaskRemind;
    map['orderId'] = _orderId;
    map['processTime'] = _processTime;
    map['processUserId'] = _processUserId;
    map['processUserMobile'] = _processUserMobile;
    map['processUserName'] = _processUserName;
    map['receiveTime'] = _receiveTime;
    map['remainingTime'] = _remainingTime;
    map['reportUserId'] = _reportUserId;
    map['reportUserName'] = _reportUserName;
    map['reportUserPhone'] = _reportUserPhone;
    map['revisitEvaluation'] = _revisitEvaluation;
    map['sendApplyStatus'] = _sendApplyStatus;
    map['serialNumber'] = _serialNumber;
    map['source'] = _source;
    map['spaceId'] = _spaceId;
    map['status'] = _status;
    map['taskType'] = _taskType;
    map['videos'] = _videos;
    map['asvCheck'] = _asvCheck;
    map['yycOrderType'] = _yycOrderType;
    return map;
  }

}