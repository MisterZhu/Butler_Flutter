import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Login/Home/View/sc_agreement_item.dart';
import '../../../../Constants/sc_asset.dart';

/// 登录-协议item

class SCLoginAgreement extends StatelessWidget {
  SCLoginAgreement(
      {Key? key,
      required this.list,
      this.isAgree = false,
      this.agreementDetailAction,
      this.agreeAction,
      }) : super(key: key);

  final List list;

  /// 是否同意用户协议和隐私政策
  final bool isAgree;

  /// 协议详情
  final Function(String title,String url)? agreementDetailAction;

  /// 勾选协议
  final Function? agreeAction;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return privacyItem();
  }

  /// 用户协议和隐私政策
  Widget privacyItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          selectItem(),
          agreementItem()
        ],
      )
    );
  }

  /// 勾选框
  Widget selectItem() {
    return Padding(padding: const EdgeInsets.only(top: 0.0),
      child: GestureDetector(
        onTap: () {
          if (agreeAction != null) {
            agreeAction?.call();
          }
        },
        child: Container(
          width: 32,
          height: 32,
          alignment: Alignment.topCenter,
          color: Colors.transparent,
          child: Image.asset(
            isAgree ? SCAsset.iconSelectRadio : SCAsset.iconNormalRadio,
            color: isAgree ? SCColors.color_4285F4 : SCColors.color_8D8E99,
            width: 22.0,
            height: 22.0,
          ),
        ),
      ),
    );
  }

  /// 内容
  Widget agreementItem() {
    return Expanded(child: SCAgreementItem(
      list: list,
      isAgree: isAgree,
      agreeAction: () {
        if (agreeAction != null) {
          agreeAction?.call();
        }
      },
      agreementDetailAction: (title, url) {
        if (agreementDetailAction != null && url.isNotEmpty) {
          agreementDetailAction?.call(title, url);
        }
      },
    ));
  }

}
