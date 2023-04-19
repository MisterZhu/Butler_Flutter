import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Constants/sc_asset.dart';
import '../../../../utils/sc_utils.dart';

/// 我的-头部item
class SCMineHeaderItem extends StatelessWidget {
  /// 背景图片比例
  final double bgImageScale = 375 / 175.0;

  SCMineHeaderItem({
    Key? key,
    this.avatar = SCAsset.iconUserDefault,
    this.nickname = '',
    this.space = '',
    this.qrCodeTapAction,
    this.settingTapAction,
    this.userInfoTapAction,
    this.switchTapAction,
    this.avatarTapAction,
  }) : super(key: key);

  /// 头像
  final String avatar;

  /// 昵称
  final String nickname;

  /// 空间
  final String space;

  /// 点击二维码
  final Function? qrCodeTapAction;

  /// 点击设置
  final Function? settingTapAction;

  /// 点击头像、昵称
  final Function? avatarTapAction;

  /// 点击切换
  final Function? switchTapAction;

  /// 点击个人资料
  final Function? userInfoTapAction;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return SizedBox(
      width: double.infinity,
      height: SCUtils().getScreenWidth() / bgImageScale,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            SCAsset.iconMineBgImage,
            fit: BoxFit.fitWidth,
            width: double.infinity,
            height: SCUtils().getScreenWidth() / bgImageScale,
          ),
          contentItem(),
        ],
      ),
    );
  }

  /// contentItem
  Widget contentItem() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topItem(),
          const SizedBox(
            height: 20.0,
          ),
          userInfoItem(),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  /// topItem
  Widget topItem() {
    return const SizedBox(
      height: 30.0,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 16.0,
        ),
        CupertinoButton(
            padding: EdgeInsets.zero,
            minSize: 30.0,
            child: Image.asset(
              SCAsset.iconMineQRCode,
              fit: BoxFit.cover,
              width: 30.0,
              height: 30.0,
            ),
            onPressed: () {
              qrCodeTapAction?.call();
            }),
        const SizedBox(
          width: 16.0,
        ),
        CupertinoButton(
            padding: EdgeInsets.zero,
            minSize: 30.0,
            child: Image.asset(
              SCAsset.iconMineSetting,
              fit: BoxFit.cover,
              width: 30.0,
              height: 30.0,
            ),
            onPressed: () {
              settingTapAction?.call();
            }),
      ],
    );
  }

  /// 用户头像、昵称
  Widget userInfoItem() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          avatarItem(),
          const SizedBox(
            width: 16,
          ),
          Expanded(child: identityItem()),
          const SizedBox(
            width: 12,
          ),
          infoItem(),
        ],
      ),
    );
  }

  /// 头像
  Widget avatarItem() {
    double borderWidth = 1.0;
    if (avatar == SCAsset.iconUserDefault) {
      borderWidth = 0.0;
    }
    return GestureDetector(
      onTap: () {
        avatarTapAction?.call();
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 6.0),
        child: Container(
          width: 42.0,
          height: 42.0,
          decoration: BoxDecoration(
              color: SCColors.color_FFFFFF,
              borderRadius: BorderRadius.circular(21.0),
              border: Border.all(color: SCColors.color_FFFFFF, width: borderWidth)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(21.0),
            child: SCImage(
              url: avatar,
              fit: BoxFit.cover,
              width: 42.0,
              height: 42.0,
            ),
          )
        )
      ),
    );
  }

  /// 名字、空间
  Widget identityItem() {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nameItem(),
          const SizedBox(
            height: 2.0,
          ),
          switchItem(constraints.maxWidth),
        ],
      );
    });
  }

  /// 昵称
  Widget nameItem() {
    return GestureDetector(
        onTap: () {
          avatarTapAction?.call();
        },
        behavior: HitTestBehavior.opaque,
        child: Text(
          nickname,
          textAlign: TextAlign.left,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: SCFonts.f18,
            fontWeight: FontWeight.w500,
            color: SCColors.color_FFFFFF,
          ),
        ));
  }

  /// 切换
  Widget switchItem(double maxWidth) {
    return GestureDetector(
      onTap: () {
        switchTapAction?.call();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        height: 24.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
                color: SCColors.color_FFFFFF.withOpacity(0.5), width: 0.5)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth - 60),
              child: Text(
                space,
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_FFFFFF,
                ),
              ),
            ),
            const SizedBox(
              width: 7.0,
            ),
            Image.asset(
              SCAsset.iconMineUserSwitch,
              fit: BoxFit.cover,
              width: 16.0,
              height: 16.0,
            )
          ],
        ),
      ),
    );
  }

  /// 个人资料
  Widget infoItem() {
    return Padding(
      padding: const EdgeInsets.only(top: 7.0, right: 16.0),
      child: GestureDetector(
        onTap: () {
          userInfoTapAction?.call();
        },
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '个人资料',
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: SCFonts.f12,
                fontWeight: FontWeight.w400,
                color: SCColors.color_FFFFFF,
              ),
            ),
            const SizedBox(
              width: 2.0,
            ),
            Image.asset(
              SCAsset.iconMineUserInfoArrow,
              fit: BoxFit.cover,
              width: 12.0,
              height: 12.0,
            )
          ],
        ),
      ),
    );
  }
}
