import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Constants/sc_asset.dart';
import '../GetXController/sc_setting_controller.dart';


/// 设置页面cell

// cell样式
enum SCSettingCellType {
  // 右边是箭头
  arrowType,
  // 右边是标题
  contentType,
  // 右边是标题箭头
  contentArrowType,
  // 右边是图片箭头
  imageArrowType,
  // 右边是开关
  switchType,
  // 右边是标签标题箭头
  contentArrowTagType,
}

class SCSettingCell extends StatelessWidget {

  /// title
  final String? title;

  /// content
  final String? content;

  /// image
  final String rightImage;

  /// cell样式
  final SCSettingCellType cellType;

  /// onTap
  final Function? onTap;

  /// 是否显示左边icon，默认不显示
  final bool showLeftIcon;

  /// leftIcon
  final String leftIcon;

  SCSettingCell({Key? key,
    this.title = '',
    this.content = '',
    this.rightImage = SCAsset.iconMineUserAvatarDefault,
    this.cellType = SCSettingCellType.arrowType,
    this.leftIcon = SCAsset.iconMineService,
    this.showLeftIcon = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return SizedBox(
      height: 48.0,
      child: bodyItem(),
    );
  }

  Widget bodyItem() {
    if (cellType == SCSettingCellType.switchType) {
      return rowItem();
    } else {
      return GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap?.call();
          }
        },
        child: rowItem(),
      );
    }
  }

  Widget rowItem() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leftIconItem(),
          Expanded(child: titleWidget()),
          rightWidget(),
        ],
      ),
    );
  }

  /// leftIcon
  Widget leftIconItem() {
    return Offstage(
      offstage: !showLeftIcon,
      child: Padding(
        padding: const EdgeInsets.only(right: 6.0),
        child: Image.asset(leftIcon, width: 22.0, height: 22.0, fit: BoxFit.cover,),),
    );
  }

  /// title
  Widget titleWidget() {
    String titleString = title ?? '';
    return Text(
      titleString, 
      textAlign: TextAlign.left, 
      maxLines: 1, 
      overflow: TextOverflow.ellipsis, 
      style: const TextStyle(
        fontSize: SCFonts.f16,
        fontWeight: FontWeight.w400,
        color: SCColors.color_1B1C33
    ),);
  }

  /// 右边的组件
  Widget rightWidget() {
    if (cellType == SCSettingCellType.contentType) {
      return contentWidget();
    } else if (cellType == SCSettingCellType.contentArrowType) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          contentWidget(),
          arrowIcon()
        ],
      );
    } else if (cellType == SCSettingCellType.imageArrowType) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          imageWidget(),
          arrowIcon()
        ],
      );
    } else if (cellType == SCSettingCellType.switchType) {
      return switchWidget();
    } else {
      return arrowIcon();
    }
  }

  /// content
  Widget contentWidget() {
    String contentString = content ?? '';
    return Text(
      contentString,
      textAlign: TextAlign.left,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: SCFonts.f14,
        fontWeight: FontWeight.w400,
        color: SCColors.color_5E5E66
    ),);
  }

  Widget imageWidget() {
    return Container(
        width: 34.0,
        height: 34.0,
        decoration: BoxDecoration(
            color: SCColors.color_F2F3F5,
            borderRadius: BorderRadius.circular(17.0),
            border: Border.all(color: SCColors.color_FFFFFF, width: 1)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(17.0),
          child: SCImage(
            url: rightImage,
            placeholder: SCAsset.iconUserDefault,
            fit: BoxFit.cover,
            width: 34.0,
            height: 34.0,
          ),
        )
    );
  }
  
  /// 箭头icon
  Widget arrowIcon() {
    return Image.asset(SCAsset.iconMineSettingArrow, width: 16.0, height: 16.0,);
  }

  /// 开关组件
  Widget switchWidget() {
    return GetBuilder<SCSettingController>(builder: (state) {
      return CupertinoSwitch(
          activeColor: SCColors.color_FF6C00,
          value: false,
          onChanged: (value) {

          });
    });
  }

}