package com.wishare.community.smartcommunity.utils;

import android.content.Context;

import java.io.File;

/**
 * Copyright (c), 浙江慧享信息科技有限公司
 * FileName: OCRUtil
 * Author: wang tao
 * Email: wangtao1@lvchengfuwu.com
 * Date: 2023/1/31 15:50
 * Description:
 */
public class OCRUtil {

    public static File getSaveFile(Context context) {
        File file = new File(context.getFilesDir(), "pic.jpg");
        return file;
    }
}
