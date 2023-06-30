import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_tools/sc_tools.dart';
import 'package:sc_uikit/src/image/sc_image.dart';
import 'package:sc_uikit/src/styles/sc_colors.dart';
import 'package:sc_uikit/src/styles/sc_fonts.dart';

import '../../../../Task/View/sc_task_time_item.dart';

/// 任务卡片cell

class SCPatrolTaskCardCell extends StatelessWidget {
  /// 时间显示类型，0显示年月日 时分秒，1显示时间差
  final int timeType;

  /// 标题-icon
  final String? titleIcon;

  /// 标题
  final String? title;

  /// 状态-title
  final String? statusTitle;

  /// 状态-title颜色
  final Color? statusTitleColor;

  /// 标签
  final List<String> tagList;

  /// 标签背景颜色
  final List<Color>? tagBGColorList;

  /// 标签文本颜色
  final List<Color>? tagTextColorList;

  /// content
  final String? content;

  final String? deviceSn;

  /// content行数
  final int? contentMaxLines;

  /// 位置icon
  final String? addressIcon;

  /// 位置
  final String? address;

  /// 联系人
  final String? contactUserName;

  /// 联系人icon
  final String? contactIcon;

  /// 时间
  final String? time;

  /// 时间差
  final int remainingTime;

  /// 是否隐藏按钮
  final bool? hideBtn;

  /// 按钮文字
  final String? btnText;

  /// 是否隐藏地址那一行
  final bool? hideAddressRow;

  /// 是否隐藏地址icon
  final bool? hideAddressIcon;

  /// 是否隐藏电话icon
  final bool? hideCallIcon;

  /// 是否隐藏底部
  final bool? hideBottomView;

  /// 打电话
  final Function? callAction;

  /// 按钮点击
  final Function? btnTapAction;

  /// 详情
  final Function? detailTapAction;

  const SCPatrolTaskCardCell({
    Key? key,
    required this.timeType,
    required this.tagList,
    required this.remainingTime,
    this.titleIcon,
    this.title,
    this.statusTitle,
    this.statusTitleColor,
    this.content,
    this.deviceSn,
    this.contentMaxLines,
    this.address,
    this.addressIcon,
    this.contactUserName,
    this.contactIcon,
    this.time,
    this.hideBtn,
    this.btnText,
    this.tagBGColorList,
    this.tagTextColorList,
    this.hideAddressRow,
    this.hideAddressIcon,
    this.hideCallIcon,
    this.hideBottomView,
    this.callAction,
    this.btnTapAction,
    this.detailTapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return GestureDetector(
      onTap: () {
        detailTapAction?.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(4.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleView(),
            const SizedBox(
              height: 12.0,
            ),
            tagsItem(),
            nameItem(content ?? ''),
            deviceItem(deviceSn ?? ''),
            addressInfoView(),
            bottomView()
          ],
        ),
      ),
    );
  }

  /// title
  Widget titleView() {
    String titleText = title ?? '';
    String statusText = statusTitle ?? '';
    Color statusTextColor = statusTitleColor ?? SCColors.color_1B1D33;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SCImage(url: titleIcon ?? 'images/message/icon_material_icon.png', width: 18.0, height: 18.0, package: (titleIcon ?? '').isEmpty ? 'sc_uikit' : null,),
          const SizedBox(
            width: 6.0,
          ),
          Expanded(
            child: Text(titleText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_1B1D33)),
          ),
          const SizedBox(
            width: 20.0,
          ),
          SizedBox(
            width: 82.0,
            child: Text(statusText,
                maxLines: 1,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w400,
                    color: statusTextColor)),
          )
        ],
      ),
    );
  }

  /// 标签
  Widget tagsItem() {
    if (tagList.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: SizedBox(
          height: 17.0,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return tagCell(index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 8.0,
                );
              },
              itemCount: tagList.length),
        ),
      );
    } else {
      return const SizedBox(
        height: 0.0,
      );
    }
  }

  /// 标签cell
  Widget tagCell(int index) {
    /// 背景颜色
    Color bgColor = tagBGColorList == null ? SCColors.color_F2F3F5 : tagBGColorList![index];
    /// 文本颜色
    Color textColor = tagTextColorList == null ? SCColors.color_5E5F66 : tagTextColorList![index];
    return Container(
        height: 17.0,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Text(
          tagList[index],
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: SCFonts.f12,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
          strutStyle: const StrutStyle(
            fontSize: SCFonts.f12,
            fontWeight: FontWeight.w400,
            leading: 0,
            height: 1.25,
            forceStrutHeight: true,
          ),
        ));
  }

  /// nameItem
  Widget nameItem(String name) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
        child: Text(
          name,
          maxLines: contentMaxLines ?? 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w500,
              fontFamilyFallback: SCToolsConfig.getPFSCForIOS(),
              color: SCColors.color_1B1D33),
        ));
  }

  /// deviceItem
  Widget deviceItem(String name) {
    if(name.isNotEmpty){
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
          child: Text(
            "设备编号：$name",
            maxLines: contentMaxLines ?? 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w400,
                fontFamilyFallback: SCToolsConfig.getPFSCForIOS(),
                color: SCColors.color_1B1D33),
          ));
    }else{
      return const SizedBox();
    }
  }

  /// 地址等信息
  Widget addressInfoView() {
    if (hideAddressRow == true) {
      return const SizedBox();
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 6.0, left: 12.0, right: 12.0),
        child: Row(
          children: [
            Offstage(
              offstage: hideAddressIcon ?? false,
              child: SCImage(url: 'images/message/icon_address.png', width: 16.0, height: 16.0, package: 'sc_uikit',),
            ),
            SizedBox(
              width: hideAddressIcon ?? false ? 0.0 : 4.0,
            ),
            Expanded(
                child: Text(
                  address ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: SCFonts.f12,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_5E5F66),
                )),
            const SizedBox(
              width: 30.0,
            ),
            GestureDetector(
              onTap: () {
                callAction?.call();
              },
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: 106.0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: Text(
                          contactUserName ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                              fontSize: SCFonts.f12,
                              fontWeight: FontWeight.w400,
                              color: SCColors.color_5E5F66),
                        )),
                    SizedBox(
                      width: hideCallIcon ?? false ? 0.0 : 6.0,
                    ),
                    Offstage(
                      offstage: hideCallIcon ?? false,
                      child: SCImage(url: 'images/message/icon_contact_phone.png', width: 16.0, height: 16.0, package: 'sc_uikit',),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  /// bottomView
  Widget bottomView() {
    if (hideBottomView == true) {
      return const SizedBox();
    } else {
      return Column(
        children: [
          const SizedBox(
            height: 12.0,
          ),
          line(),
          const SizedBox(
            height: 12.0,
          ),
          bottomItem()
        ],
      );
    }
  }

  /// 横线
  Widget line() {
    return const Padding(
      padding: EdgeInsets.only(left: 12.0),
      child: Divider(
        height: 0.5,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  /// bottomItem
  Widget bottomItem() {
    bool showBtn = false;
    if (hideBtn == false) {
      showBtn = true;
    }
    return Container(
        height: 40.0,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: timeItem()),
            const SizedBox(
              width: 35.0,
            ),
            SizedBox(
              width: 100.0,
              height: 40.0,
              child: Offstage(
                offstage: !showBtn,
                child: CupertinoButton(
                    alignment: Alignment.center,
                    borderRadius: BorderRadius.circular(4.0),
                    minSize: 40.0,
                    color: SCColors.color_4285F4,
                    padding: EdgeInsets.zero,
                    child: Text(
                      btnText ?? '',
                      style: const TextStyle(
                          fontSize: SCFonts.f16,
                          fontWeight: FontWeight.w400,
                          color: SCColors.color_FFFFFF),
                    ),
                    onPressed: () {
                      btnTapAction?.call();
                    }),
              ),
            )
          ],
        ));
  }

  /// 时间，默认0：显示时间年-月-日 时分秒，1：显示时间差
  Widget timeItem() {
    if (timeType == 0) {
      return Text(
        time ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: SCColors.color_5E5F66),
      );
    } else {
      if (remainingTime > 0) {
        return Row(mainAxisSize: MainAxisSize.min, children: [
          const Text(
            '剩余时间',
            style: TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w400,
                color: SCColors.color_5E5F66),
          ),
          const SizedBox(
            width: 6.0,
          ),
          Expanded(
            child: SCTaskTimeItem(time: remainingTime),
          )
        ]);
      } else {
        return SCTaskTimeItem(time: remainingTime);
      }
    }
  }
}
