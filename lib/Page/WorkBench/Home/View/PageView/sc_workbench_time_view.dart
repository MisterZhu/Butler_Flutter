import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 倒计时

class SCWorkBenchTimeView extends StatelessWidget{

  SCWorkBenchTimeView({Key? key, required this.time}) : super(key: key);

  final int time;

  /// 根据time获取时分秒
  Map<String, dynamic> getTimeData() {
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
      if (time <= 0) {
        hour = 0;
        minute = 0;
        second = 0;
        hourString = '00';
        minuteString = '00';
        secondString = '00';
      } else {
        hour = time ~/ 3600;
        minute = (time - hour * 3600) ~/ 60;
        second = time - hour * 3600 - minute * 60;
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
      }
      return {
        'hour' : hourString,
        'minute' : minuteString,
        'second' : secondString
      };
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> timeMap = getTimeData();
    return Row(
      children: [
        timeView(timeMap['hour']),
        colonView(),
        timeView(timeMap['minute']),
        colonView(),
        timeView(timeMap['second']),
      ],
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
