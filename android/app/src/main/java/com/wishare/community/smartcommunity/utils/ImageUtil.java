/**
 * Project Name:my_project
 * File Name:ImageUtil.java
 * Package Name:com.lvman.utils
 * Date:2014年9月17日上午11:12:10
 * Copyright (c) 2014.
 */

package com.wishare.community.smartcommunity.utils;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.provider.MediaStore;
import android.text.TextUtils;
import android.util.Log;

import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * ClassName:ImageUtil <br/>
 * Function:  图像相关处理的类 Reason:  ADD REASON. <br/>
 * Date: 2014年9月17日 上午11:12:10 <br/>
 *
 * @author Administrator
 * @see
 * @since JDK 1.6
 */
public class ImageUtil {

    // Bitmap转换成byte[]
    public static byte[] Bitmap2Bytes(Bitmap bm) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        bm.compress(Bitmap.CompressFormat.PNG, 100, baos);
        try {
            baos.flush();
            baos.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return baos.toByteArray();
    }

    public static int max = 0;

    /**
     * 根据规则获取图片url type取"_small"这样传递:
     */
    public static String getImageSmallUrl(String baseUrl) {
        StringBuilder sb = new StringBuilder();
        String urls[] = baseUrl.split("\\.");
        if (urls.length >= 2) {
            for (int i = 0; i < urls.length; i++) {
                sb.append(urls[i]);
                if (i == urls.length - 1) {
                } else if (i == urls.length - 2) {
                    sb.append("_small.");
                } else {
                    sb.append(".");
                }
            }
        }
        return sb.toString();
    }

    /**
     * 通过流得到bitmap
     *
     * @param uri
     * @return
     */
    public static Bitmap decodeUriAsBitmap(Context mContext, Uri uri) {
        Bitmap bitmap = null;
        try {
            bitmap = BitmapFactory.decodeStream(mContext.getContentResolver()
                    .openInputStream(uri));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return null;
        }
        return bitmap;
    }

    /**
     * 保存 图片到文加件 lvman>lvapp
     *
     * @param bm
     * @param fileName
     * @throws IOException
     */
    public static String saveAndGetFile(Bitmap bm, String fileName, Context mContext, boolean inSysPic) throws IOException {
        String path = mContext.getExternalFilesDir("").toString() + File.separator + "images" + File.separator;
        File dirFile = new File(path);
        if (!dirFile.exists()) {
            dirFile.mkdir();
        }
        File myCaptureFile = new File(path + fileName);
        BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(myCaptureFile));
        bm.compress(Bitmap.CompressFormat.JPEG, 100, bos);
        if (inSysPic) {
            // 其次把文件插入到系统图库
            MediaStore.Images.Media.insertImage(mContext.getContentResolver(), bm, fileName, null);
            // 最后通知图库更新
            mContext.sendBroadcast(new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, Uri.parse("file://" + path
                    + fileName)));
        }
        bos.flush();
        bos.close();
        return myCaptureFile.getAbsolutePath();
    }

    /**
     * use by web
     *
     * @return
     */

    public static Intent choosePicture() {
        Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
        intent.setType("image/*");
        return Intent.createChooser(intent, null);
    }

    private static final String TAG = "ImageUtil";

    public static String retrievePath(Context context, Intent sourceIntent, Intent dataIntent) {
        String picPath = null;
        try {
            Uri uri;
            if (dataIntent != null) {
                uri = dataIntent.getData();
                if (uri != null) {
                    picPath = ContentUtil.getPath(context, uri);
                }
                if (isFileExists(picPath)) {
                    return picPath;
                }

                Log.w(TAG, String.format("retrievePath failed from dataIntent:%s, extras:%s", dataIntent, dataIntent.getExtras()));
            }

            if (sourceIntent != null) {
                uri = sourceIntent.getParcelableExtra(MediaStore.EXTRA_OUTPUT);
                if (uri != null) {
                    String scheme = uri.getScheme();
                    if (scheme != null && scheme.startsWith("file")) {
                        picPath = uri.getPath();
                    }
                }
                if (!TextUtils.isEmpty(picPath)) {
                    File file = new File(picPath);
                    if (!file.exists() || !file.isFile()) {
                        Log.w(TAG, String.format("retrievePath file not found from sourceIntent path:%s", picPath));
                    }
                }
            }
            return picPath;
        } finally {
            Log.d(TAG, "retrievePath(" + sourceIntent + "," + dataIntent + ") ret: " + picPath);
        }
    }

    private static boolean isFileExists(String path) {
        if (TextUtils.isEmpty(path)) {
            return false;
        }
        File f = new File(path);
        if (!f.exists()) {
            return false;
        }
        return true;
    }
}
