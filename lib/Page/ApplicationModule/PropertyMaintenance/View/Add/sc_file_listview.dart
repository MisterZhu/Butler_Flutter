import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/ApplicationModule/PropertyMaintenance/Model/sc_attachment_model.dart';

/// 文件listView

class SCFileListView extends StatelessWidget {
  /// 数据源
  final List list;

  /// 删除
  final Function(int index)? deleteAction;

  const SCFileListView({Key? key, required this.list, this.deleteAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return cell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line(index);
        },
        itemCount: list.length);
  }

  /// cell
  Widget cell(int index) {
    SCAttachmentModel model = list[index];
    String title = model.name ?? '';
    return Container(
      constraints: BoxConstraints(
        maxWidth: Get.width - 48.0,
      ),
      height: 26.0,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: SCColors.color_F5F5F5,
            borderRadius: BorderRadius.circular(2.0)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 10.0,
            ),
            Image.asset(
              SCAsset.iconGreyFile,
              width: 16.0,
              height: 16.0,
            ),
            const SizedBox(
              width: 4.0,
            ),
            Expanded(
                child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_1B1D33),
            )),
            GestureDetector(
              onTap: () {
                deleteAction?.call(index);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Image.asset(
                  SCAsset.iconFileDelete,
                  width: 12.0,
                  height: 12.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// line
  Widget line(int index) {
    return const SizedBox(
      height: 12.0,
    );
  }
}
