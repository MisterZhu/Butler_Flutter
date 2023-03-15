enum SCEnvironment {
  /// 研发环境
  develop,
  /// 预发环境
  pretest,
  /// 生产环境
  production
}

enum SCHttpMethod {
  get,
  post,
  put,
  delete
}

enum SCHomeFeatureStyle {
  /// 一张图片
  featureStyle1,
  /// 两张图片
  featureStyle2
}

enum SCLocationStatus {
  /// 定位未开启
  notOpen,
  /// 定位失败
  failure,
  /// 定位成功
  success,
}

/// 选择房号的逻辑链路
enum SCSelectHouseLogicType {
  /// 登录逻辑  去绑定房号
  login,
  /// 新增房号  去绑定房号
  addHouse,
}

/// 首页cell样式类型
enum SCHomeCellBottomContentType {
  // 图片下面没有标题
  noBottomContent,
  // 图片下面有标题内容
  bottomContent,
}

/// 添加照片类型
enum SCAddPhotoType {
  // 拍照+从相册选择
  all,
  // 拍照
  takePhoto,
  // 从相册选择
  photoPicker
}

/// 仓储管理类型
enum SCWarehouseManageType {
  // 物料入库
  entry,
  // 物料出库
  outbound,
  // 物料报损
  frmLoss,
  // 物料调拨
  transfer,
  // 盘点任务
  check,
  // 领料
  requisition,
  // 固定资产报损
  propertyFrmLoss,
  // 固定资产盘点任务
  fixedCheck,
}