package com.wishare.community.smartcommunity.utils;

import android.text.TextUtils;
import android.util.Log;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Random;

/**
 * Copyright (C), 2018-2020, 浙江慧享信息科技有限公司
 * FileName: CommonUtils
 * Author: wang tao
 * Email: wangtao1@lvchengfuwu.com
 * Date: 2020/5/28 18:03
 * Description: 一些基本的工具方法
 */
public class CommonUtils {

    /**
     * 获取现在时间
     *
     * @return返回字符串格式 yyyy-MM-dd HH:mm:ss
     */
    public static String getStringDate() {
        Date currentTime = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateString = formatter.format(currentTime);
        return dateString;
    }

    public static String getStringDate(String format) {
        Date currentTime = new Date();
        if (CommonUtils.isEmpty(format)) {
            format = "yyyy-MM-dd HH:mm:ss";
        }
        SimpleDateFormat formatter = new SimpleDateFormat(format);
        String dateString = formatter.format(currentTime);
        return dateString;
    }

    public static boolean stringCompare(String str1, String str2) {
        return TextUtils.equals(str1, str2);
    }

    public static boolean isEmpty(String content) {
        if (content != null && !"null".equalsIgnoreCase(content) && !TextUtils.isEmpty(content)) {
            return false;
        }
        return true;
    }

    public static boolean isEmpty(List list) {
        return list == null || list.size() == 0;
    }

    public static boolean isEmpty(Object[] arrays) {
        return arrays == null || arrays.length == 0;
    }

    /**
     * 计算字符的长度，尤其用于汉字
     */
    public static int getCharsLen(String text) {
        if (text == null) {
            return 0;
        }

        int len = 0;
        int nchar = 0;
        int templen = text.length();
        for (int i = 0; i < templen; i++) {
            nchar = text.charAt(i);
            if (nchar > 0x80) {
                len += 2;
            } else {
                len += 1;
            }
        }
        return len;
    }


    /**
     * 获得四位的随机数
     */
    public static int getRandom() {
        Random random = new Random();
        return (int) (random.nextDouble() * 9999);
    }

    public static double toDouble(String value, double defValue) {
        try {
            return Double.parseDouble(value);
        } catch (Exception e) {
            Log.e("print", "toDouble: " + e);
        }
        return defValue;
    }

    public static int toInteger(String str, int defValue) {
        if (!isEmpty(str)) {
            try {
                return Integer.parseInt(str);
            } catch (Exception e) {
            }
        }
        return defValue;
    }

    public static float toFloat(String str, int defValue) {
        if (!isEmpty(str)) {
            try {
                return Float.parseFloat(str);
            } catch (Exception e) {
            }
        }
        return defValue;
    }

    public static boolean equals(String str1, String str2) {
        if (str1 == null && str2 == null) {
            return true;
        } else if (str1 != null) {
            return str1.equals(str2);
        }
        return false;
    }


    public static boolean equals(Integer int1, Integer int2) {
        if (int1 == null && int2 == null) {
            return true;
        } else if (int1 != null) {
            return int1.equals(int2);
        }
        return false;
    }

    public static boolean equals(Long param1, Long param2) {
        if (param1 == param2 && param2 == null) {
            return true;
        } else if (param1 != null) {
            return param1.equals(param2);
        }
        return false;
    }

    public static boolean equals(Object actual, Object expected) {
        return actual == expected || (actual != null && actual.equals(expected));
    }


    /**
     * list中内容拼接在一起
     *
     * @param split 分隔符
     */
    public static <T> String listToString(List<T> list, String split) {
        if (CommonUtils.isEmpty(list)) {
            return null;
        }
        StringBuilder sb = new StringBuilder();
        for (T t : list) {
            sb.append(t).append(split);
        }
        if (sb.length() > 0) {
            return sb.substring(0, sb.length() - 1);
        } else {
            return null;
        }
    }

    /**
     * 删除列表中项目
     */
    public static <T> void removeListItem(List<T> list, T item) {
        if (list == null || item == null) {
            return;
        }
        for (T t : list) {
            if (item.equals(t)) {
                list.remove(t);
                return;
            }
        }
    }

    /**
     * 保留两位小数
     *
     * @param d
     * @return
     */
    public static String double2String(double d) {
        try {
            DecimalFormat df = new DecimalFormat("0.00");
            return df.format(d);
        } catch (Exception e) {
        }
        return String.format("%.2f", d);

    }

    //double相加
    public static double add(double v1, double v2) {
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.add(b2).doubleValue();
    }

    //double 相乘
    public static double mul(double v1, double v2) {
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.multiply(b2).doubleValue();
    }


    private static SimpleDateFormat sdf = null;

    public static String formatUTC(long l, String strPattern) {
        if (TextUtils.isEmpty(strPattern)) {
            strPattern = "yyyy-MM-dd HH:mm:ss";
        }
        if (sdf == null) {
            try {
                sdf = new SimpleDateFormat(strPattern, Locale.CHINA);
            } catch (Throwable e) {
            }
        } else {
            sdf.applyPattern(strPattern);
        }
        return sdf == null ? "" : sdf.format(l * 1000);
    }

    /**
     * 将秒转化为 时分秒 格式
     * t 标识时间
     */
    public static String formatLongToTimeStr(int t) {
        int hour = 0;
        int minute = 0;
        int second = t;
        if (second >= 60) {
            minute = second / 60;         //取整
            second = second % 60;         //取余
            if (second == 60) {
                second = 0;
                minute += 1;
            }
        }
        if (minute >= 60) {
            hour = minute / 60;
            minute = minute % 60;
            if (minute == 60) {
                minute = 0;
                hour += 1;
            }
        }
        String strTime = hour + ":" + minute + ":" + second;

        String[] timeArr = strTime.split(":");
        for (int i = 0; i < timeArr.length; i++) {
            if (timeArr[0].length() == 1) {
                timeArr[0] = "0" + timeArr[0];
            } else {
                timeArr[0] = timeArr[0];
            }
            if (timeArr[1].length() == 1) {
                timeArr[1] = "0" + timeArr[1];
            } else {
                timeArr[1] = timeArr[1];
            }
            if (timeArr[2].length() == 1) {
                timeArr[2] = "0" + timeArr[2];
            } else {
                timeArr[2] = timeArr[2];
            }
        }
        return timeArr[0] + "时" + timeArr[1] + "分" + timeArr[2] + "秒";
    }

    /**
     * 将秒转化为 分秒 格式
     * t 标识时间
     */
    public static String formatToMinAndSec(int t) {
        int minute = 0;
        int second = t;
        if (second >= 60) {
            minute = second / 60;         //取整
            second = second % 60;         //取余
            if (second == 60) {
                second = 0;
                minute += 1;
            }
        }
        String strTime = minute + ":" + second;
        String[] timeArr = strTime.split(":");
        for (int i = 0; i < timeArr.length; i++) {
            if (timeArr[0].length() == 1) {
                timeArr[0] = "0" + timeArr[0];
            } else {
                timeArr[0] = timeArr[0];
            }
            if (timeArr[1].length() == 1) {
                timeArr[1] = "0" + timeArr[1];
            } else {
                timeArr[1] = timeArr[1];
            }
        }
        return timeArr[0] + ":" + timeArr[1];
    }

    /**
     * 判断剩余时间
     * 大于一天   显示天数
     * 小于一天   大于一小时   显示小时数
     * 小于一天   小于一小时   显示分钟数
     * 小于一天   小于一小时   小于一分钟  显示描述
     *
     * @param endTime 要转化时间  单位：秒
     */
    public static String getEndTime(int endTime) {
        String str;
        if (endTime <= 0) {
            str = "已结束";
        } else {
            int days = endTime / (3600 * 24);
            if (days > 0) {
                str = days + "天";
            } else {
                int hour = endTime / 3600;
                if (hour > 0) {
                    str = hour + "小时";
                } else {
                    int min = endTime / 60;
                    if (min > 0) {
                        str = min + "分钟";
                    } else {
                        str = endTime + "秒";
                    }
                }
            }
        }
        return str;
    }


    //将时间转换为时间戳
    public static long dateToStamp(String s, String format) {
        if (isEmpty(format)) {
            format = "yyyy-MM-dd HH:mm:ss";
        }
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
        long time = 0;
        try {
            Date date = simpleDateFormat.parse(s);
            time = date.getTime();

        } catch (Exception e) {
            time = 0;
        }

        return time;
    }

    //将时间转换为时间戳
    public static long dateToStamp(String s, SimpleDateFormat simpleDateFormat) {
        if (simpleDateFormat == null) {
            simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        }
        long time = 0;
        try {
            Date date = simpleDateFormat.parse(s);
            time = date.getTime();

        } catch (Exception e) {
        }

        return time;
    }

    //将时间戳转换为时间
    public static String stampToTime(long s, String format) {
        String res;
        if (isEmpty(format)) {
            format = "yyyy-MM-dd HH:mm:ss";
        }
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
        Date date = new Date(s); //将时间调整为yyyy-MM-dd HH:mm:ss时间样式
        res = simpleDateFormat.format(date);
        return res;
    }

    //将时间戳转换为时间
    public static String stampToTime(long s, SimpleDateFormat simpleDateFormat) {
        String res;
        if(simpleDateFormat == null){
            simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        }
        Date date = new Date(s); //将时间调整为yyyy-MM-dd HH:mm:ss时间样式
        res = simpleDateFormat.format(date);
        return res;
    }

    /**
     * 混淆电话号码
     *
     * @param phoneNumber
     * @return
     */
    public static String mixPhoneNumber(String phoneNumber) {
        if (isEmpty(phoneNumber) || phoneNumber.length() <= 6) {
            return phoneNumber;
        }
        return phoneNumber.substring(0, 3) + "****" + phoneNumber.substring(7, phoneNumber.length());
    }

    /**
     * 混淆身份证号码
     *
     * @param idNumber
     * @return
     */
    public static String mixIDCardNumber(String idNumber) {
        if (isEmpty(idNumber)) {
            return idNumber;
        }
        //15位的身份证
        if (idNumber.trim().length() == 15) {
            return idNumber.substring(0, 6) + "*****" + idNumber.substring(11, idNumber.length());
        }
        if (idNumber.trim().length() == 18) {
            return idNumber.substring(0, 6) + "********" + idNumber.substring(14, idNumber.length());
        }
        return idNumber;
    }

    /**
     * 验证手机号的正则
     *
     * @param phone
     * @return
     */
    public static boolean isMatchPhone(String phone) {
        if (isEmpty(phone)) {
            return false;
        }
        if (phone.matches("^(?:\\+?86)?1(?:3\\d{3}|5[^4\\D]\\d{2}|8\\d{3}|7(?:[235-8]\\d{2}|4(?:0\\d|1[0-2]|9\\d))|9[0-35-9]\\d{2}|66\\d{2})\\d{6}$")) {
            return true;
        }
        return false;
    }

    /**
     * 验证身份证号码的正则
     *
     * @param idCardNum
     * @return
     */
    public static boolean isMatchIDCard(String idCardNum) {
        if (isEmpty(idCardNum)) {
            return false;
        }
        if (idCardNum.matches("(^\\d{8}(0\\d|10|11|12)([0-2]\\d|30|31)\\d{3}$)|(^\\d{6}(18|19|20)\\d{2}(0[1-9]|10|11|12)([0-2]\\d|30|31)\\d{3}(\\d|X|x)$)")) {
            return true;
        }
        return false;
    }
}
