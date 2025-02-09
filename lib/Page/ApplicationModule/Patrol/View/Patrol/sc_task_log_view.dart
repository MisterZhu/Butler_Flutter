
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Network/sc_config.dart';
import '../../../../../Utils/Preview/sc_image_preview_utils.dart';
import '../../Controller/sc_task_log_controller.dart';
import '../../Model/sc_task_log_model.dart';

/// 任务日志view

class SCTaskLogView extends StatelessWidget {

  final SCTaskLogController state;

  SCTaskLogView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    if (state.dataList.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return cell(index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox();
            },
            itemCount: state.dataList.length),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget cell(int index) {
    return Stack(
      children: [
        rightItem(index),
        Positioned(
            left: 12,
            top: index == 0 ? 12.0 : 0.0,
            bottom: 0,
            width: 8,
            child: leftItem(index))
      ],
    );
  }

  /// leftItem
  Widget leftItem(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox( height: 8.0,),
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
              color: index == 0 ? SCColors.color_4285F4 : SCColors.color_B0B1B8,
              borderRadius: BorderRadius.circular(4.0)
          ),
        ),
        const SizedBox( height: 8.0,),
        Expanded(child: Container(
          width: 1,
          color: index == state.dataList.length - 1 ? SCColors.color_FFFFFF : SCColors.color_B0B1B8,
          ),
        )
      ],
    );
  }

  /// rightItem
  Widget rightItem(int index) {
    BorderRadiusGeometry borderRadius;
    if (index == 0) {
      if (state.dataList.length == 1) {
        borderRadius = BorderRadius.circular(4.0);
      } else {
        borderRadius = const BorderRadius.only(topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0));
      }
    } else {
      borderRadius = const BorderRadius.only(bottomLeft: Radius.circular(4.0), bottomRight: Radius.circular(4.0));
    }
    SCTaskLogModel model = state.dataList[index];
    return DecoratedBox(decoration: BoxDecoration(
      color: SCColors.color_FFFFFF,
      borderRadius: borderRadius
    ), child: Padding(
      padding: EdgeInsets.only(left: 38.0, top: index == 0 ? 12.0 : 0.0, right: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 24.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Text(
                  model.action?.value ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: SCFonts.f16,
                    fontWeight: FontWeight.w500,
                    color: index == 0 ? SCColors.color_4285F4 : SCColors.color_8D8E99,
                  ),
                )),
                Text(
                  model.operateTime ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: SCFonts.f12,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_8D8E99,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 4.0,),
          textItem(model.title ?? '', (index == 0) ? true : false),
          const SizedBox(height: 4.0,),
          contentItem(index),
          const SizedBox(height: 20.0,),
        ],
      ),
    ),);
  }

  /// textListView
  Widget textListView(List list) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return textItem(list[index] ?? '', false);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 20.0,);
        },
        itemCount: list.length);
  }

  /// textItem
  Widget textItem(String text, bool isLast) {
    return Text(
      text,
      style: TextStyle(
        fontSize: SCFonts.f14,
        fontWeight: FontWeight.w400,
        color: isLast == true ? SCColors.color_1B1D33 : SCColors.color_8D8E99,
      ),
    );
  }

  /// contentItem
  Widget contentItem(int section) {
    SCTaskLogModel model = state.dataList[section];
    List textList = [];
    List imageList = [];
    if ((model.content?.options ?? []).isNotEmpty) {
      for (int i = 0; i < (model.content?.options ?? []).length; i++) {
        Options? option = model.content?.options![i];
        if (option?.data?.type == 'TEXT') {
          textList.add(option?.data?.text);
        } else if (option?.data?.type == 'FILE') {
          if (option?.data?.fileUrl != '') {
            String url = SCConfig.getImageUrl(option?.data?.fileUrl ?? '');
            imageList.add(url);
          }
        }
      }
      return Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          decoration: BoxDecoration(
              color: SCColors.color_F7F8FA,
              borderRadius: BorderRadius.circular(4.0)
          ),
          child: Column(
            children: [
              textListView(textList),
              const SizedBox(height: 10.0,),
              imagesItem(imageList),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  /// 图片item
  Widget imagesItem(List list) {
    if (list.isNotEmpty) {
      return SCImagesCell(
        list: list,
        contentPadding: EdgeInsets.zero,
        onTap: (int imageIndex, List imageList) {
          SCImagePreviewUtils.previewImage(imageList: [imageList[imageIndex]]);
        },
      );
    } else {
      return const SizedBox();
    }
  }
}