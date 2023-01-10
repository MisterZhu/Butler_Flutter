import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_agreement.dart';
import 'package:smartcommunity/Constants/sc_type_define.dart';
import 'package:smartcommunity/Page/Login/Home/View/sc_login_agreement.dart';
import 'package:smartcommunity/Page/Login/Home/View/sc_login_textfield.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';
import '../../../../Constants/sc_asset.dart';
import '../../../../Utils/Colors/sc_color_hex.dart';
import '../GetXController/sc_login_controller.dart';


/// 登录页listview

class SCLoginListView extends StatelessWidget {

  SCLoginController state = Get.find<SCLoginController>();

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  Widget body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        listView(context),
        Expanded(child: bottomImageItem()),
      ],
    );
  }

  Widget listView(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index: index, context: context);
        },
        separatorBuilder: (BuildContext context, int index) {
          return getSeparateItem(index: index);
        },
        itemCount: 3);
  }

  /// cell
  Widget getCell({required int index, required BuildContext context}) {
    if (index == SCTypeDefine.SC_LOGIN_TYPE_TITLE) {
      return headerItem();
    } else if (index == SCTypeDefine.SC_LOGIN_TYPE_TEXTFIELD) {
      return textFieldItem();
    } else if (index == SCTypeDefine.SC_LOGIN_TYPE_LOGIN_BUTTON) {
      return loginBtnItem(context);
    } {
      return const SizedBox();
    }
  }

  /// 分割线
  Widget getSeparateItem({required int index}) {
    if (index == SCTypeDefine.SC_LOGIN_TYPE_TEXTFIELD) {
      return const SizedBox(
        height: 44.0,
      );
    } else {
      return const SizedBox();
    }
  }

  /// header
  Widget headerItem() {
    return const Padding(
      padding: EdgeInsets.only(top: 118.0, bottom: 55.0),
      child: Text(
          '账号登录',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SCFonts.f30,
            fontWeight: FontWeight.w600,
            color: SCColors.color_1B1D33,
          )),
    );
  }

  /// 手机号验证码输入框
  Widget textFieldItem() {
    return GetBuilder<SCLoginController>(builder: (state) {
      return SCLoginTextField();
    });
  }

  /// 登录按钮
  Widget loginBtnItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: SizedBox(
        width: double.infinity,
        height: 48.0,
        child: CupertinoButton(
            padding: EdgeInsets.zero,
            color: SCColors.color_4285F4,
            borderRadius: BorderRadius.circular(8.0),
            child: const Text(
              '登录',
              style: TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w500,
                color: SCColors.color_FFFFFF,
              ),
            ),
            onPressed: () {
              SCUtils().hideKeyboard(context: context);
              loginBtnClick();
            }),
      ),
    );
  }

  /// 点击登录
  loginBtnClick() {
    if (state.phone.isEmpty) {
      SCToast.showTip('手机号不能为空');
      return;
    }
    if (state.code.isEmpty) {
      SCToast.showTip('验证码不能为空');
      return;
    }
    if (state.phone.length != 11) {
      SCToast.showTip('请输入正确的手机号码');
      return;
    }

    // if (state.isAgree == false) {
    //   SCToast.showTipWithGravity(msg: '请同意用户服务协议和隐私协议', gravity: ToastGravity.BOTTOM);
    //   return;
    // }
    state.login();
  }

  Widget bottomImageItem() {
    return Image.asset(
        SCAsset.iconLoginBottomImage,
        width: double.infinity,
        height: 406.0,
        fit: BoxFit.cover,
    );
  }


  /// 用户协议和隐私政策
  Widget agreementItem() {
    List<dynamic> list = [
      {
        'type': SCTypeDefine.richTextTypeText,
        'title': '我已阅读并同意',
        'imageUrl': '',
        'url': '',
        'color': SCHexColor.colorToString(SCColors.color_1B1C33)
      },
      {
        'type': SCTypeDefine.richTextTypeText,
        'title': '《用户服务协议》',
        'imageUrl': '',
        'url': SCAgreement.userAgreementUrl,
        'color': SCHexColor.colorToString(SCColors.color_FF6C00)
      },
      {
        'type': SCTypeDefine.richTextTypeText,
        'title': '',
        'imageUrl': '',
        'url': '',
        'color': SCHexColor.colorToString(SCColors.color_FF6C00)
      },
      {
        'type': SCTypeDefine.richTextTypeText,
        'title': '《隐私协议》',
        'imageUrl': '',
        'url': SCAgreement.privacyProtocolUrl,
        'color': SCHexColor.colorToString(SCColors.color_FF6C00)
      },
      {
        'type': SCTypeDefine.richTextTypeText,
        'title': '并使用本机号码登录',
        'imageUrl': '',
        'url': '',
        'color': SCHexColor.colorToString(SCColors.color_1B1C33)
      },
    ];
    return GetBuilder<SCLoginController>(builder: (state) {
      return SCLoginAgreement(
        list: list,
        isAgree: state.isAgree,
        agreeAction: () {
          state.updateAgreementState();
        },
        agreementDetailAction: (String title, String url) {
          var params = {'title' : title, 'url' : url,'removeLoginCheck' : true};
          SCRouterHelper.pathPage(SCRouterPath.webViewPath, params);
        },
      );
    });
  }

}
