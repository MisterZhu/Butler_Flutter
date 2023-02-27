import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartcommunity/Utils/Date/sc_date_locale.dart';

/// 日期工具

class SCDateUtils {

  /// 日期转指定类型的日期字符串：formatDateWithString('2022-01-01', ['yyyy', '-', 'mm', '-', 'dd'])
  static String transformDate({required DateTime dateTime, required List<String> formats, DateLocale? locale}) {
    return formatDate(dateTime, formats, locale: locale ?? const SCDateLocale());
  }

  /// 时间戳
  static int timestamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// 字符串转DateTime
  static DateTime stringToDateTime({required String dateString, required String formateString}) {
    return DateFormat(formateString).parse(dateString);
  }

  /// 天数差
  static int difference(String start, String end) {
    DateTime startDateTime = DateTime.parse(start);
    DateTime endDateTime = DateTime.parse(end);
    return endDateTime.difference(startDateTime).inDays;
  }

  /// 获取星期几-短
  static String getShortWeekday({required int weekday}) {
    String weekdayText = '';
    switch (weekday) {
      case 1:
        {
          weekdayText = '周一';
        }
        break;
      case 2:
        {
          weekdayText = '周二';
        }
        break;
      case 3:
        {
          weekdayText = '周三';
        }
        break;
      case 4:
        {
          weekdayText = '周四';
        }
        break;
      case 5:
        {
          weekdayText = '周五';
        }
        break;
      case 6:
        {
          weekdayText = '周六';
        }
        break;
      case 7:
        {
          weekdayText = '周日';
        }
        break;
    }
    return weekdayText;
  }

  /// 日期格式转换
  static String formatDateStyle({required String format,required String date}) {
    var currentDate = DateTime.parse(date);
    DateFormat dateFormat = DateFormat(format, 'zh');
    return dateFormat.format(currentDate);
  }
}