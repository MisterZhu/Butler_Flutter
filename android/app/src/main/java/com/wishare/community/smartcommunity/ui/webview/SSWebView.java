package com.wishare.community.smartcommunity.ui.webview;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.text.TextUtils;
import android.view.View;
import android.webkit.ValueCallback;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.FileProvider;

import com.gyf.immersionbar.ImmersionBar;
import com.tbruyelle.rxpermissions2.RxPermissions;
import com.tencent.smtt.export.external.interfaces.PermissionRequest;
import com.tencent.smtt.sdk.WebView;
import com.wishare.community.smartcommunity.R;
import com.wishare.community.smartcommunity.ui.webview.helper.BridgeWebChromeClient;
import com.wishare.community.smartcommunity.ui.webview.helper.BridgeWebView;
import com.wishare.community.smartcommunity.ui.webview.helper.BridgeWebViewClient;
import com.wishare.community.smartcommunity.utils.ImageUtil;

import java.io.File;
import java.util.List;

import io.reactivex.functions.Consumer;

/**
 * Copyright (c), 浙江慧享信息科技有限公司
 * FileName: SSWebView
 * Author: wang tao
 * Email: wangtao1@lvchengfuwu.com
 * Date: 2023/1/16 9:03
 * Description: 通用webView
 */
public class SSWebView extends AppCompatActivity implements BridgeWebChromeClient.FileChooserCallback, View.OnClickListener {

    private ImageView img_back;
    private ImageView img_close;
    private TextView tv_center_title;
    private BridgeWebView mWebView;

    private String title;
    private String url;
    private ValueCallback<Uri> mUploadMsgUri;
    private ValueCallback<Uri[]> mUploadMsgUris;
    private Intent mSourceIntent;

    private static final int REQUEST_CODE_PICK_IMAGE = 0;
    private static final int REQUEST_CODE_IMAGE_CAPTURE = 1;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(getLayoutId());
        initView();
        initImmersionBar();
        initWebView();
        initCommonBridge();
        initProjBridge();
        initListener();
    }

    /**
     * 布局
     *
     * @return
     */
    private int getLayoutId() {
        return R.layout.activity_webview;
    }

    /**
     * 初始化控件
     */
    private void initView() {
        img_back = findViewById(R.id.img_back);
        img_close = findViewById(R.id.img_close);
        tv_center_title = findViewById(R.id.tv_center_title);
        mWebView = findViewById(R.id.mWebView);

        img_back.setColorFilter(Color.parseColor("#1B1C33"));
        img_close.setColorFilter(Color.parseColor("#1B1C33"));

        title = getIntent().getStringExtra("title");
        url = getIntent().getStringExtra("url");
        if (!TextUtils.isEmpty(title)) {
            tv_center_title.setText(title);
        }
    }

    /**
     * 沉浸式状态栏
     */
    private void initImmersionBar() {
        ImmersionBar.with(this)
                .fitsSystemWindows(true)
                .statusBarColor(R.color.white)
                .statusBarDarkFont(true)
                .init();
    }

    private void initWebView() {
        mWebView.getSettings().setJavaScriptEnabled(true);
        mWebView.getSettings().setDomStorageEnabled(true);
        mWebView.getSettings().setUseWideViewPort(true);
        mWebView.getSettings().setLoadWithOverviewMode(true);
        mWebView.getSettings().setAllowFileAccess(true);
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
            mWebView.getSettings().setMixedContentMode(android.webkit.WebSettings.MIXED_CONTENT_ALWAYS_ALLOW);
        }

        if (TextUtils.isEmpty(url)) {
            Toast.makeText(this, "当前加载的url为空", Toast.LENGTH_SHORT).show();
            return;
        }

        mWebView.loadUrl(url);
    }

    /**
     * 初始化setWebChromeClient
     */
    private void initCommonBridge() {
        // 设置setWebChromeClient对象
        mWebView.setWebChromeClient(new BridgeWebChromeClient(this) {
            @Override
            public void onReceivedTitle(WebView view, String title) {
                super.onReceivedTitle(view, title);
                tv_center_title.setText(title);
            }

            @Override
            public void onPermissionRequest(PermissionRequest permissionRequest) {
                permissionRequest.grant(permissionRequest.getResources());
            }
        });
        BridgeWebViewClient webViewClient = (BridgeWebViewClient) mWebView.getWebViewClient();
        webViewClient.setActivity(this);
        webViewClient.registWebClientListener(new BridgeWebViewClient.WebClientListener() {
            @Override
            public void setLoadFail() {

            }

            @Override
            public void pageLoadFinished() {

            }

            @Override
            public void webviewImageClick(List<String> var1, int var2) {

            }
        });
    }

    @Override
    public void showFileChooserUris(ValueCallback<Uri[]> var1) {
        mUploadMsgUris = var1;
        showOptions();
    }

    @Override
    public void showFileChooserUri(ValueCallback<Uri> var1) {
        mUploadMsgUri = var1;
        showOptions();
    }

    /**
     * 初始化桥 原生跟H5交互的桥
     */
    private void initProjBridge() {
    }

    private void initListener() {
        img_back.setOnClickListener(this);
        img_close.setOnClickListener(this);
    }


    @SuppressLint("CheckResult")
    private void showOptions() {
        AlertDialog.Builder alertDialog = new AlertDialog.Builder(SSWebView.this);
        alertDialog.setOnCancelListener(new ReOnCancelListener());
        alertDialog.setTitle("");
        alertDialog.setItems(new String[]{"选择图片", "拍照"}, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        requestStoragePermissionForPhotos(which);
                    }
                }
        );
        alertDialog.show();


    }

    /**
     * 请求存储权限用于读取图片以供选择及保存拍摄图片
     */
    private void requestStoragePermissionForPhotos(int type) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            if (Environment.isExternalStorageManager()) {
                if (type == 0) {
                    mSourceIntent = ImageUtil.choosePicture();
                    startActivityForResult(mSourceIntent, REQUEST_CODE_PICK_IMAGE);
                } else {
                    gotoCarma();
                }
            } else {
                requestPermission(type);
            }

        } else {
            requestPermission(type);
        }
    }

    /**
     * 申请权限
     *
     * @param type
     */
    private void requestPermission(int type) {
        if (type == 0) {
            new RxPermissions(this)
                    .request(Manifest.permission.READ_EXTERNAL_STORAGE,
                            Manifest.permission.WRITE_EXTERNAL_STORAGE)
                    .subscribe(new Consumer<Boolean>() {
                        @Override
                        public void accept(Boolean aBoolean) throws Exception {
                            if (aBoolean) {
                                mSourceIntent = ImageUtil.choosePicture();
                                startActivityForResult(mSourceIntent, REQUEST_CODE_PICK_IMAGE);
                            } else {
                                Toast.makeText(SSWebView.this, "缺少相关权限，暂时不能使用该功能", Toast.LENGTH_SHORT).show();
                            }
                        }
                    });
        } else {
            new RxPermissions(this)
                    .request(Manifest.permission.CAMERA)
                    .subscribe(new Consumer<Boolean>() {
                        @Override
                        public void accept(Boolean aBoolean) throws Exception {
                            if (aBoolean) {
                                gotoCarma();
                            } else {
                                Toast.makeText(SSWebView.this, "缺少相关权限，暂时不能使用该功能", Toast.LENGTH_SHORT).show();
                            }
                        }
                    });
        }
    }

    private String cameraPath;

    private Uri photoUri;//记录图片地址

    private void gotoCarma() {
        Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
        // Build.VERSION.SDK_INT：获取当前系统sdk版本
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            // 适配Android 7.0文件权限，通过FileProvider创建一个content类型的Uri
            String fileName = String.format("%s.jpg", System.currentTimeMillis());
            File cropFile = new File(this.getExternalFilesDir(Environment.DIRECTORY_PICTURES), fileName);
            photoUri = FileProvider.getUriForFile(this, this.getPackageName() + ".fileProvider", cropFile);//7.0
        } else {
            photoUri = getDestinationUri();
        }
        // android11以后强制分区存储，外部资源无法访问，所以添加一个输出保存位置，然后取值操作
        intent.putExtra(MediaStore.EXTRA_OUTPUT, photoUri);
        startActivityForResult(intent, REQUEST_CODE_IMAGE_CAPTURE);

    }

    private Uri getDestinationUri() {
        String fileName = String.format("%s.jpg", System.currentTimeMillis());
        File cropFile = new File(this.getExternalFilesDir(Environment.DIRECTORY_PICTURES), fileName);
        return Uri.fromFile(cropFile);
    }


    @Override
    public void onBackPressed() {
        gobackOrFinish();
    }

    private void gobackOrFinish() {
        if (mWebView.canGoBack()) {
            mWebView.goBack();
        } else {
            Intent intent = new Intent();
            setResult(RESULT_OK, intent);
            finish();
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode != Activity.RESULT_OK) {
            if (requestCode == REQUEST_CODE_IMAGE_CAPTURE || requestCode == REQUEST_CODE_PICK_IMAGE) {
                setReceiveValueNull();
            }
            return;
        }
        if (requestCode == REQUEST_CODE_IMAGE_CAPTURE) {
            if (mUploadMsgUris == null) {
                return;
            }

            if (photoUri == null) {
                return;
            }
            Uri[] uris = new Uri[]{photoUri};
            mUploadMsgUris.onReceiveValue(uris);
        } else if (requestCode == REQUEST_CODE_PICK_IMAGE) {
            try {
                if (mUploadMsgUri == null && mUploadMsgUris == null) {
                    return;
                }
                String sourcePath = ImageUtil.retrievePath(this, mSourceIntent, data);
                cameraPath = data.getStringExtra("cameraPath");
                if (TextUtils.isEmpty(sourcePath) || !new File(sourcePath).exists()) {
                    if (TextUtils.isEmpty(cameraPath) || !new File(cameraPath).exists()) {
                    } else {
                        sourcePath = cameraPath;
                    }
                }
                Uri uri0 = Uri.fromFile(new File(sourcePath));
                Uri[] uris0 = new Uri[]{uri0};
                if (mUploadMsgUri != null) {
                    mUploadMsgUri.onReceiveValue(uri0);
                }
                if (mUploadMsgUris != null) {
                    mUploadMsgUris.onReceiveValue(uris0);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 置空  防止取消弹窗 图片上传弹窗不显示
     */
    private void setReceiveValueNull() {
        if (mUploadMsgUri != null) {
            mUploadMsgUri.onReceiveValue(null);
            mUploadMsgUri = null;
        }
        if (mUploadMsgUris != null) {
            mUploadMsgUris.onReceiveValue(null);
            mUploadMsgUris = null;
        }
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.img_back:
                onBackPressed();
                break;
            case R.id.img_close:
                Intent intent = new Intent();
                setResult(RESULT_OK, intent);
                finish();
                break;
        }
    }

    private class ReOnCancelListener implements DialogInterface.OnCancelListener {

        @Override
        public void onCancel(DialogInterface dialogInterface) {
            setReceiveValueNull();
        }
    }
}
