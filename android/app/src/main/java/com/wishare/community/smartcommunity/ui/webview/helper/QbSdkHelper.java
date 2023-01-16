package com.wishare.community.smartcommunity.ui.webview.helper;

import android.content.Context;
import android.util.Log;

import com.tencent.smtt.export.external.TbsCoreSettings;
import com.tencent.smtt.sdk.QbSdk;
import com.tencent.smtt.sdk.TbsListener;

import java.util.HashMap;

public class QbSdkHelper {
    /**
     * 初始化x5内核
     * @param mApplication
     */
    public static void init(Context mApplication) {
        // 在调用TBS初始化、创建WebView之前进行如下配置
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put(TbsCoreSettings.TBS_SETTINGS_USE_SPEEDY_CLASSLOADER, true);
        map.put(TbsCoreSettings.TBS_SETTINGS_USE_DEXLOADER_SERVICE, true);
        QbSdk.initTbsSettings(map);

        QbSdk.setDownloadWithoutWifi(true);
        QbSdk.setTbsListener(new TbsListener() {
            @Override
            public void onDownloadFinish(int i) {
                Log.e("QbSdk", "onDownloadFinish -->下载X5内核完成：" + i);
            }

            @Override
            public void onInstallFinish(int i) {
                Log.e("QbSdk", "onInstallFinish -->安装X5内核进度：" + i);
            }

            @Override
            public void onDownloadProgress(int i) {
                Log.e("QbSdk", "onDownloadProgress -->下载X5内核进度：" + i);
            }
        });

        QbSdk.PreInitCallback cb = new QbSdk.PreInitCallback() {
            @Override
            public void onViewInitFinished(boolean isX5Core) {
                // x5內核初始化完成的回调，true表x5内核加载成功，否则表加载失败，会自动切换到系统内核。
                Log.e("QbSdk", " 内核加载：" + (isX5Core ? "x5内核加载成功" : "切换到系统内核"));
            }

            @Override
            public void onCoreInitFinished() {
                Log.e("QbSdk", "x5内核初始化完成");
            }
        };

        // x5内核初始化接口
        QbSdk.initX5Environment(mApplication, cb);

    }
}
