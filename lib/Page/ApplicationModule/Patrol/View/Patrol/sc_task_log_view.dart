
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../Controller/sc_task_log_controller.dart';

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
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return cell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox();
        },
        itemCount: state.dataList.length);
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

  Widget rightItem(int index) {
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
                  '处理中',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: SCFonts.f16,
                    fontWeight: FontWeight.w500,
                    color: index == 0 ? SCColors.color_4285F4 : SCColors.color_8D8E99,
                  ),
                )),
                const Text(
                  '12-15 12:00:00',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: SCFonts.f12,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_8D8E99,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 6.0,),
          Text(
            '处理人：李四',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: index == 0 ? SCColors.color_1B1D33 : SCColors.color_8D8E99,
            ),
          ),
          contentItem(index),
          const SizedBox(height: 20.0,),
        ],
      ),
    );
  }

  /// contentItem
  Widget contentItem(int index) {
    return Offstage(
      offstage: (index == 0 || index == 3) ? false : true, //测试显示
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          decoration: BoxDecoration(
              color: SCColors.color_EDEDF0.withOpacity(0.8),
              borderRadius: BorderRadius.circular(4.0)
          ),
          child: Column(
            children: const [
              Text(
                '添加日志：已处理完成已处理完成已处理完成已处理完成',
                style: TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_5E5F66,
                ),
              ),
              SizedBox(height: 10.0,),

            ],
          ),
        ),
      ),
    );
  }
}