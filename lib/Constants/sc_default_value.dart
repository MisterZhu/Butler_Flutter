/// 常用的默认值

class SCDefaultValue {
  const SCDefaultValue._();

  /// 屏幕默认宽度
  static const  double defaultScreenWidth = 375.0;

  /// APP名称
  static const String appName = '善数管理';

  /// h5渠道，用于表示h5是应用在flutter上
  static int h5Channel = 1;

  /// client
  static const String client = 'co-app';

  /// app唯一标识
  static const String appCode = '101';

  /// 高德web key
  static const String kAMapWebKey = 'fb48becc7b7a077d4da585a977d39ed2';

  /// 微信appId
  static const String kWeChatAppId = "wx37e729dfef38aad2";

  /// 微信appKey
  static const String kWeChatAppKey = "9c43d236e8df615e5cf2501f189d0cd1";

  /// 微信universalLink
  static const String kWeChatUniversalLink = "https://90ebce5254556de5a7c4db4334ced558.share2dlink.com/";

  /// 极光appKey
  static const String kJPushAppKey = "f02a45b9542a99cd79446472";

  /// 极光channel
  static const String kJPushChannel = "WishareAppStore";

  /// 网络超时时间
  static const int timeOut = 30000;

  /// 手机号正则表达式
  static const String phoneReg = r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$";

  /// 身份证正则表达式
  static const String idCardReg = r'^\d{6}(18|19|20)?\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$';

  /// 正数正则表达式-不允许小数点
  static const String positiveNumberReg = r'^[1-9][0-9]*';

  /// 非负数正则表达式
  static const String nonNegativeReg = r'^([1-9][0-9]*|0)';

  /// 金额表达式
  static const String priceReg = r'^\d+(\.)?[0-9]{0,2}';

  /// 网络加载中
  static const String loadingMessage = '加载中...';

  /// 网络加载失败
  static const String errorMessage = '加载失败，请稍后重试！';

  /// 网络不稳定
  static const String netErrorMessage = '网络不稳定，请稍后重试！';

  /// 同意协议才可以使用APP
  static const String canUseAppMessage = '同意协议后才可以使用!';

  /// 同意用户协议
  static const String agreeUserAgreementMessage = '请先同意用户协议和隐私政策！';

  /// 账户过期
  static const String accountExpiredMessage = '账户已过期,请重新登录!';

  /// 扫码权限弹窗提示内容
  static const String scanAlertMessage = "允许“$appName”访问您的相机权限，用于您在提交工单、使用报事报修、参与活动、扫一扫功能";

  /// 相册权限弹窗提示内容
  static const String photoAlertMessage = "允许“$appName”访问您的相册权限，用于您在提交工单、使用报事报修、参与活动、修改头像";

  /// 相机权限弹窗提示内容
  static const String cameraAlertMessage = "允许“$appName”访问您的相机权限，用于您在提交工单、使用报事报修、参与活动、修改头像";

  /// 相机无权限提示
  static const String noCameraPermissionMessage = "相机权限受限，请在设置中开启相机权限";

  /// 相册无权限提示
  static const String noPhotoPermissionMessage = "相册权限受限，请在设置中开启相册权限";

  /// 定位权限弹窗提示内容
  static const String locationAlertMessage = "允许“$appName”访问您的位置权限，用于您快速定位获取周边服务";

  /// 设置通知弹窗提示内容
  static const String setNotificationAlertMessage = "允许“$appName”访问您的通知权限，用于“$appName”向您提供消息推送服务";

  /// 输入姓名提示
  static const String inputNameTip = "请输入姓名";

  /// 姓名格式错误提示
  static const String inputNameErrorTip = "请输入正确的姓名";

  /// 输入证件号码提示
  static const String inputIDCardTip = "请输入证件号码";

  /// 证件号码格式错误提示
  static const String inputIDCardErrorTip = "请输入正确的证件号码";

  /// 未安装微信
  static const String unInstalWeChatTip = "请安装微信";

  /// 未安装支付宝提示
  static const String unInstallAliPayTip = "请安装支付宝";

  /// 支付成功提示
  static const String paySuccessMessage = "支付成功";

  static const String paySuccessTip = "支付成功";

  /// 支付失败提示
  static const String payFailureTip = "支付失败";

  /// 未安装微信
  static const String unInstallWeChatTip = "请安装微信";

  /// 拨号失败
  static const String callFailedTip = "拨号失败";

  /// 功能开发中
  static const String developingTip = "功能开发中";

  /// 验房-签署弹窗文案
  static const String houseInspectSignatureTip = "请将手机转交给业主，先由业主签署后您在签署";

  /// 仓储-入库-选择物资
  static const String selectMaterialTip = "请选择物资";

  /// 仓储-入库-选择资产
  static const String selectPropertyTip = "请选择资产";

  /// 仓储-入库-选择仓库名称
  static const String selectWareHouseNameTip = "请选择仓库名称";

  /// 仓储-入库-选择类型
  static const String selectWareHouseTypeTip = "请选择类型";

  /// 仓储-入库-添加物资信息
  static const String addMaterialInfoTip = "请添加物资信息";

  /// 仓储-入库-添加资产信息
  static const String addPropertyInfoTip = "请添加资产信息";

  /// 仓储-入库-请选择物资类型
  static const String selectMaterialTypeTip = "请选择物资类型";

  /// 仓储-入库-请选择采购需求单
  static const String selectPurchaseIdTip = "请选择采购需求单";

  /// 仓储-入库-请选择入库日期
  static const String addInDateTip = "请选择入库日期";

  /// 仓储-入库-复制粘贴板
  static const String pasteBoardSuccessTip = "复制成功";

  /// 仓储-出库-出库确认成功
  static const String outboundConfirmSuccessTip = "出库确认成功";

  /// 仓储-新增出入库-添加物资之前提示
  static const String selectWarehouseTip = "请先选择仓库";

  /// 仓储-新增出入库-请选择领用部门提示
  static const String selectDepartmentTip = "请选择领用部门";

  /// 仓储-新增出入库-请选择领用人提示
  static const String selectUserTip = "请选择领用人";

  /// 仓储-新增调拨-请选择调入仓库
  static const String selectInWareHouseTip = "请选择调入仓库";

  /// 仓储-新增调拨-请选择调出仓库
  static const String selectOutWareHouseTip = "请选择调出仓库";

  /// 仓储-新增报损-请选择报损部门
  static const String selectFrmLossDepartment = "请选择报损部门";

  /// 仓储-新增报损-请选择报损人
  static const String selectFrmLossUser = "请选择报损人";

  /// 仓储-新增报损-请选择报损时间
  static const String selectFrmLossTime = "请选择报损时间";

  /// 仓储-新增任务-请选择任务名称
  static const String selectTaskName = "请选择任务名称";

  /// 仓储-新增任务-请选择开始时间
  static const String selectStartTime = "请选择开始时间";

  /// 仓储-新增任务-请选择结束时间
  static const String selectEndTime = "请选择结束时间";

  /// 仓储-新增报损-请选择处理人
  static const String selectOperatorName = "请选择处理人";

  /// 设置-注销账号提示
  static const String logOffTip = "你正在申请注销你在$appName下的账号。注销后，你将退出$appName，该账号将无法继续使用，账号下的所有数据也无法处理，请确认是否注销";

  /// 上传中tip
  static const String uploadingTip = "上传中...";

  /// 选择分类tip
  static const String selectMaterialCategoryTip = "请选择物资分类";

  /// 添加物资分类tip
  static const String addMaterialCategoryTip = "请添加物资分类";

  /// 添加资产分类tip
  static const String addPropertyCategoryTip = "请添加资产分类";

  /// 盘点-作废tip
  static const String checkCancelTip = "请确认是否作废？";

  /// 盘点-提交tip
  static const String checkSubmitTip = "盘点结果提交后不可修改，将自动生成盘盈入库单或盘亏出库单，并更新库存数量";

  /// 盘点-暂存成功tip
  static const String checkSaveSuccessTip = "暂存成功";

  /// 盘点-提交成功tip
  static const String checkSubmitSuccessTip = "提交成功";

  /// 选择使用部门tip
  static const String selectUserDepartment = "请选择使用部门";

  /// 新增盘点-请选择盘点部门
  static const String selectCheckDepartmentTip = "请选择盘点部门";

  /// 新增盘点-请选择盘点人
  static const String selectCheckUserTip = "请选择盘点人";

  /// 搜索框默认placeholder
  static const String searchViewDefaultPlaceholder = "请输入搜索内容";

  /// 采购需求单搜索框placeholder
  static const String purchaseSearchViewPlaceholder = "搜索采购需求单号";

  /// 采购单暂无物资tip
  static const String purchaseNoMaterialTip = "暂无物资";

  /// 选择维保部门tip
  static const String selectMaintenanceDepartment = "请选择维保部门";

  /// 选择维保人tip
  static const String selectMaintenanceUser = "请选择维保负责人";

  /// 统一维保单位tip
  static const String unifyMaintenanceCompanyTip = "选择“是”，\n提交或暂存将统一维保单位";

  /// 统一维保内容tip
  static const String unifyMaintenanceContentTip = "选择“是”，\n提交或暂存将统一维保内容";

  /// 巡查-请选择部门
  static const String selectPatrolDepartment = "请选择部门";

  /// 巡查-请选择人员
  static const String selectPatrolUser = "请选择转派人";

  /// 图片路径
  static const files = "/files/";
}