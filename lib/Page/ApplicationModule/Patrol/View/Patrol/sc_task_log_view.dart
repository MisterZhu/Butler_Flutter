
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
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
    return Column(
      children: [
        listview(),
        const Expanded(child: SizedBox())
      ],
    );
  }

  Widget listview() {
    if (state.dataList.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Container(
            decoration: BoxDecoration(
              color: SCColors.color_FFFFFF,
              borderRadius: BorderRadius.circular(4.0),),
            child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return cell(index);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox();
                },
                itemCount: state.dataList.length)
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget cell(int index) {
    return Stack(
      children: [
        Positioned(child: rightItem(index)),
        Positioned(
            left: 0,
            top: 0,
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
    SCTaskLogModel model = state.dataList[index];
    return Padding(
      padding: const EdgeInsets.only(left: 26.0),
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
    );
  }

  /// textListView
  Widget textListView(List list) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          Data data = list[index];
          return textItem(data.text ?? '', false);
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
          textList.add(option?.data);
        } else if (option?.data?.type == 'FILE') {
          imageList.add(option?.data);
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

  Widget imagesItem(List list) {
    if (list.isNotEmpty) {
      return SizedBox();

    } else {
      return SizedBox();
    }
  }
}