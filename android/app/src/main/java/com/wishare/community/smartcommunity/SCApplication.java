package com.wishare.community.smartcommunity;

import android.app.Application;

import com.wishare.community.smartcommunity.ui.webview.helper.QbSdkHelper;

/**
 * Copyright (c), 浙江慧享信息科技有限公司
 * FileName: SCApplication
 * Author: wang tao
 * Email: wangtao1@lvchengfuwu.com
 * Date: 2023/1/16 9:43
 * Description:
 */
public class SCApplication extends Application {

    private Application mApplication;

    @Override
    public void onCreate() {
        super.onCreate();
        mApplication = this;

        QbSdkHelper.init(mApplication);
    }
}
