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





  static num ONE_MINUTE = 60000;
  static num ONE_HOUR = 3600000;
  static num ONE_DAY = 86400000;
  static num ONE_WEEK = 604800000;

  static String ONE_SECOND_AGO = "秒前";
  static String ONE_MINUTE_AGO = "分钟前";
  static String ONE_HOUR_AGO = "小时前";
  static String ONE_DAY_AGO = "天前";

  static num toSeconds(num date) {
    return date / 1000;
  }

  static num toMinutes(num date) {
    return toSeconds(date) / 60;
  }

  static num toHours(num date) {
    return toMinutes(date) / 60;
  }

  static num toDays(num date) {
    return toHours(date) / 24;
  }

  static num toMonths(num date) {
    return toDays(date) / 30;
  }

  static num toYears(num date) {
    return toMonths(date) / 365;
  }


  // 时间转换
  static String relativeDateFormat(DateTime date) {
    num delta = DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;
    if (delta < 1 * ONE_MINUTE) {
      num seconds = toSeconds(delta);
      return (seconds <= 0 ? 1 : seconds).toInt().toString() + ONE_SECOND_AGO;
    }
    if (delta < 60 * ONE_MINUTE) {
      num minutes = toMinutes(delta);
      return (minutes <= 0 ? 1 : minutes).toInt().toString() + ONE_MINUTE_AGO;
    }
    if (delta < 24 * ONE_HOUR) {
      num hours = toHours(delta);
      return (hours <= 0 ? 1 : hours).toInt().toString() + ONE_HOUR_AGO;
    }
    if (delta < 48 * ONE_HOUR) {
      return "昨天";
    }
    if (delta < 30 * ONE_DAY) {
      num days = toDays(delta);
      return (days <= 0 ? 1 : days).toInt().toString() + ONE_DAY_AGO;
    }
    if (delta < 12 * 4 * ONE_WEEK) {
      return transformDate(dateTime: date, formats: ['mm', '-', 'dd']);
    } else {
      return transformDate(dateTime: date, formats: ['yyyy', '-', 'mm', '-', 'dd']);
    }
  }

}