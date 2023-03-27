
import 'dart:async';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Page/Login/Home/Model/sc_user_model.dart';
import 'package:smartcommunity/Utils/JPush/sc_jpush.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/Router/sc_router_path.dart';


class SCLoginController extends GetxController {
  /// 是否同意相关协议，默认不同意
  bool isAgree = false;

  /// 手机号
  String phone = '';

  /// 验证码
  String code = '';

  /// 获取验证码按钮是否可以点击
  bool codeBtnEnable = false;

  /// 是否显示关闭按钮，默认不显示
  late bool showCloseBtn = false;

  /// 验证码定时器
  late Timer? codeTimer;

  /// 倒计时
  late int codeTime = 60;

  /// 验证码按钮text
  String codeText = '获取验证码';

  /// 获取验证码按钮是否可以点击
  updateCodeButtonState({required bool enable}) {
    codeBtnEnable = enable;
    update();
  }

  /// 更新勾选协议状态
  updateAgreementState() {
    isAgree = !isAgree;
    update();
  }

  /// 初始化定时器
  initTimer() {
    codeBtnEnable = false;
    codeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      codeTime--;
      if (codeTime <= 0) {
        codeTime = 60;
        codeBtnEnable = true;
        codeText = "重新获取";
        disposeTimer();
      } else {
        codeText = '重新获取(${codeTime}s)';
      }
      update();
    });
  }

  /// 销毁定时器
  disposeTimer() {
    codeTimer?.cancel();
    codeTimer = null;
  }

  @override
  dispose() {
    super.dispose();
    disposeTimer();
  }

  /// 发送验证码
  sendCode({required Function(bool success) resultHandler}) {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kSendCodeUrl,
        params: {'mobileNum' : phone},
        success: (value) {
          SCLoadingUtils.success(text:'验证码发送成功');
          resultHandler(true);
        },
        failure: (value) {
          SCLoadingUtils.hide();
          if (value['message'] != null) {
            String message = value['message'];
            SCToast.showTip(message);
          }
          resultHandler(false);
        });
  }

  /// 请求登录接口
  login() {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kPhoneCodeLoginUrl,
        isQuery: true,
        params: {'mobileNum' : phone, 'code' : code, 'appCode' : SCDefaultValue.appCode},
        success: (value) {
          SCLoadingUtils.hide();
          var userParams = value['userInfoV'];
          SCUserModel userModel = SCUserModel.fromJson(userParams);
          SCScaffoldManager.instance.user = userModel;
          SCScaffoldManager.instance.isLogin = true;
          bindJPush(userModel);
          if (showCloseBtn) {
            SCRouterHelper.back(null);
            Get.forceAppUpdate();
          } else {
            SCRouterHelper.pathOffAllPage(SCRouterPath.tabPath, null);
          }
        },
        failure: (value) {
          if (value['message'] != null) {
            String message = value['message'];
            SCToast.showTip(message);
          }
        });
  }

  /// 绑定极光
  bindJPush(SCUserModel model) {
    SCJPush.deleteAlias().then((value) async{
      SCJPush.bindAlias(model.id ?? '');
      String registrationID = await SCJPush.getRegistrationID();
      var params = {
        'userId' : model.id,
        'tenantId' : model.tenantId,
        'registrationId' : registrationID
      };
      SCHttpManager.instance.get(url: SCUrl.kBindJPushRegistrationIdUrl, params: params);
    });
  }
}