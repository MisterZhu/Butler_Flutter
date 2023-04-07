import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/PropertyMaintenance/View/Add/sc_file_listview.dart';

import '../../../../../Constants/sc_asset.dart';

/// 添加附件view

class SCAddFileView extends StatelessWidget {

  /// 新增文件
  final Function? addAction;

  const SCAddFileView({Key? key, this.addAction}) : super(key: key);

  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 12.0), child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleItem(),
        desItem(),
        const SizedBox(
          height: 12.0,
        ),
        listView(),
      ],
    ),);
  }

  /// titleItem
  Widget titleItem() {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text('附件',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: SCFonts.f16,
                      fontWeight: FontWeight.w500,
                      color: SCColors.color_1B1D33)),
            ),
            topRightItem(),
          ],
        ));
  }

  /// 上传
  Widget topRightItem() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        addAction?.call();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            SCAsset.iconUploadFile,
            width: 18.0,
            height: 18.0,
          ),
          const SizedBox(
            width: 6.0,
          ),
          const Text('上传',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_4285F4)),
        ],
      ),
    );
  }

  /// 描述
  Widget desItem() {
    String desText = "支持上传word/excel/ppt/pdf/zip/rar格式，限制大小5M";
    return Text(desText,
        style: const TextStyle(
            fontSize: SCFonts.f12,
            fontWeight: FontWeight.w400,
            color: SCColors.color_B0B1B8));
  }

  /// listView
  Widget listView() {
    return SCFileListView(list: ['', '', '']);
  }
}