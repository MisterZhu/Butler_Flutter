import 'package:flutter/cupertino.dart';
import 'package:sc_tools/sc_tools.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 消息cell

class SCMessageCardCell extends StatelessWidget {

  /// 类型,0-只显示一行内容,1-显示两行内容,2-显示图片+内容+内容描述
  final int type;

  /// icon
  final String? icon;

  /// 标题
  final String? title;

  /// 时间
  final String? time;

  /// 是否未读
  final bool? isUnread;

  /// 显示更多按钮
  final bool? showMoreBtn;

  /// head
  final String? head;

  /// 内容
  final String? content;

  /// 内容图标
  final String? contentIcon;

  /// 底部内容数组
  final List? bottomContentList;

  /// 按钮点击
  final Function? moreBtnTapAction;

  /// 详情
  final Function? detailTapAction;

  SCMessageCardCell({Key? key,
    required this.type,
    this.icon,
    this.title,
    this.time,
    this.isUnread,
    this.showMoreBtn,
    this.head,
    this.content,
    this.contentIcon,
    this.bottomContentList,
    this.moreBtnTapAction,
    this.detailTapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return GestureDetector(
      onTap: () {
        detailTapAction?.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(4.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topView(),
            const SizedBox(
              height: 16.0,
            ),
            middleItem(),
            const SizedBox(
              height: 16.0,
            ),
            bottomItem()
          ],
        )
      ),
    );
  }

  /// middleItem
  Widget middleItem() {
    if (type == 1) {// 显示两行内容
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          contentDescItem(head ?? ''),
          const SizedBox(
            height: 6.0,
          ),
          priceItem(content ?? ''),
        ],
      );
    } else if (type == 2) {// 显示图片+内容+内容描述
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          contentIconItem(),
          const SizedBox(
            height: 6.0,
          ),
          contentItem(head ?? ''),
          const SizedBox(
            height: 6.0,
          ),
          contentDescItem(content ?? ''),
        ],
      );
    } else {// 只显示一行内容
      return contentItem(content ?? '');
    }
  }

  /// topView
  Widget topView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(9.0),
          child: SCImage(url: icon ?? 'images/message/icon_message_type.png', width: 18.0, height: 18.0, fit: BoxFit.cover, package: 'sc_uikit'),
        ),
        const SizedBox(
          width: 6.0,
        ),
        SizedBox(
          width: 138.0,
          child: Text(title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_1B1D33)),
        ),
        const Expanded(child: SizedBox()),
        Offstage(
          offstage: isUnread == true ? false : true,
          child: Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
                color: SCColors.color_FF4040,
                borderRadius: BorderRadius.circular(4.0)),
          ),
        ),
        const SizedBox(
          width: 7.0,
        ),
        Text(time ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: const TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w400,
                color: SCColors.color_B0B1B8)),
        Offstage(
          offstage: showMoreBtn == true ? false : true,
          child: GestureDetector(
            onTap: () {
              moreBtnTapAction?.call();
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 24.0,
              height: 22.0,
              alignment: Alignment.centerRight,
              child: Image.asset(
                'images/message/icon_message_more.png',
                package: 'sc_uikit',
                width: 16.0,
                height: 16.0,
              ),
            ),
          ),
        )
      ],
    );
  }

  /// 价格
  Widget priceItem(String text) {
    return SizedBox(
      width: double.infinity,
      height: 36,
      child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: SCFonts.f24,
              fontWeight: FontWeight.w500,
              fontFamilyFallback: SCToolsConfig.getPFSCForIOS(),
              color: SCColors.color_1B1D33)),
    );
  }

  /// 内容
  Widget contentItem(String text) {
    return SizedBox(
      width: double.infinity,
      height: 27,
      child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: SCFonts.f18,
              fontWeight: FontWeight.w500,
              fontFamilyFallback: SCToolsConfig.getPFSCForIOS(),
              color: SCColors.color_1B1D33)),
    );
  }

  /// 内容描述
  Widget contentDescItem(String text) {
    return Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: SCFonts.f12,
            fontWeight: FontWeight.w400,
            color: SCColors.color_8D8E99));
  }

  /// 内容图片
  Widget contentIconItem() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: SCImage(
        url: contentIcon ?? 'images/message/icon_message_content_default.png',
        width: 79.0,
        height: 79.0,
        package: 'sc_uikit',
        fit: BoxFit.fill,),);
  }

  /// bottomItem
  Widget bottomItem() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var dic = bottomContentList?[index];
          return bottomCell(dic['title'] ?? '', dic['content'] ?? '');
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 8.0,);
        },
        itemCount: bottomContentList?.length ?? 0);
  }

  /// bottomCell
  Widget bottomCell(String leftText, String rightText) {
    return SizedBox(
      height: 18.0,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 60.0,
              child: Text(
                  leftText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: SCFonts.f12,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_8D8E99)),
            ),
            const SizedBox(width: 8.0,),
            Expanded(child: Text(
                rightText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: SCFonts.f12,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_1B1D33)),)
          ]
      ),
    );
  }

}