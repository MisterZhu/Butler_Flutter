import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 倒计时

class SCTaskTimeItem extends StatelessWidget {
  SCTaskTimeItem({Key? key, required this.time}) : super(key: key);

  final int time;

  String timeStr = '已超时';
  Color textColor = SCColors.color_FA4C41;

  /// 根据time获取时分秒,返回类型type=1为字符串，type=2为map
  dynamic getTimeData({required int type}) {

    /// 天
    int day = 0;

    String dayString = '';

    /// 时
    int hour = 0;

    /// 时
    String hourString = '00';

    /// 分
    int minute = 0;

    /// 分
    String minuteString = '00';

    /// 秒
    int second = 0;

    /// 秒
    String secondString = '00';

    int newTime = 0;
    if (time > 0) {
      timeStr = '剩余时间';
      textColor = SCColors.color_5E5E66;
      newTime = time;
    } else {
      newTime = -time;
    }

    day = newTime ~/ 24 ~/ 3600;
    hour = (newTime - day * 24 * 3600) ~/ 3600;
    minute = (newTime - day * 24 * 3600 - hour * 3600) ~/ 60;
    second = newTime - day * 24 * 3600 - hour * 3600 - minute * 60;

    if (day > 0) {
      dayString = '$day天';
    }
    if (hour == 0) {
      hourString = '00';
    } else if (hour < 10) {
      hourString = '0$hour';
    } else {
      hourString = '$hour';
    }

    if (minute == 0) {
      minuteString = '00';
    } else if (minute < 10) {
      minuteString = '0$minute';
    } else {
      minuteString = '$minute';
    }

    if (second == 0) {
      secondString = '00';
    } else if (second < 10) {
      secondString = '0$second';
    } else {
      secondString = '$second';
    }

    if (type == 1) {
      return '$timeStr$dayString$hourString小时$minuteString分钟';
    } else {
      return {"day" : dayString, "hour" : hourString, "minute" : minuteString, "second" : secondString};
    }
  }

  @override
  Widget build(BuildContext context) {
    if (time > 0) {
      Map<String, dynamic> timeMap = getTimeData(type: 2);
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          timeItem(timeMap['day']),
          const SizedBox(width: 6.0,),
          timeView(timeMap['hour']),
          colonView(),
          timeView(timeMap['minute']),
          colonView(),
          timeView(timeMap['second']),
        ],
      );
    } else if(time == 0) {
      return const SizedBox();
    } else {
      return timeItem(getTimeData(type: 1));
    }
  }

  /// timeItem
  Widget timeItem(String str) {
    return Text(
      str,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: textColor),
    );
  }

  /// item
  Widget timeView(String text) {
    return Container(
      width: 18.0,
      height: 18.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: SCColors.color_1B1D33,
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: SCFonts.f10,
            fontWeight: FontWeight.w500,
            color: SCColors.color_FFFFFF),
        strutStyle: const StrutStyle(
          fontSize: SCFonts.f10,
          height: 0.95,
          forceStrutHeight: true,
        ),
      ),
    );
  }

  /// 冒号
  Widget colonView() {
    return Container(
      width: 7.0,
      alignment: Alignment.center,
      child: const Text(
        ':',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: SCFonts.f10,
            fontWeight: FontWeight.w400,
            color: SCColors.color_5E5F66),
      ),
    );
  }
}
