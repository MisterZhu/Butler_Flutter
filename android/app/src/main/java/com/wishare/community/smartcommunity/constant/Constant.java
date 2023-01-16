package com.wishare.community.smartcommunity.constant;

/**
 * Copyright (c), 浙江慧享信息科技有限公司
 * FileName: Constant
 * Author: wang tao
 * Email: wangtao1@lvchengfuwu.com
 * Date: 2023/1/16 14:20
 * Description:
 */
public class Constant {

    /**
     * flutter---原生通道 key
     */
    public static class FlutterChannelEnum {
        /// 原生调用flutter key
        public static String kNativeToFlutter = "native_flutter";
        /// flutter调用原生 key
        public static String kFlutterToNative = "flutter_native";
    }

    public static class FlutterChannelMethodEnum {
        public static String android_webview = "android_webview";
    }
}
