package com.wishare.community.smartcommunity.ui.webview.helper;

import android.Manifest;
import android.app.AlertDialog;
import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.DialogInterface.OnClickListener;
import android.graphics.Bitmap;
import android.net.Uri;
import android.widget.Toast;

import androidx.fragment.app.FragmentActivity;

import com.tbruyelle.rxpermissions2.RxPermissions;
import com.tencent.smtt.export.external.interfaces.WebResourceError;
import com.tencent.smtt.export.external.interfaces.WebResourceRequest;
import com.tencent.smtt.sdk.WebView;
import com.tencent.smtt.sdk.WebViewClient;
import com.wishare.community.smartcommunity.ui.webview.SSWebView;
import com.wishare.community.smartcommunity.utils.ImageUtil;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import io.reactivex.functions.Consumer;

public class BridgeWebViewClient extends WebViewClient {
    private BridgeWebView webView;
    private Context context;
    public WebClientListener listener;
    private FragmentActivity activity;

    public BridgeWebViewClient(Context context, BridgeWebView webView) {
        this.webView = webView;
        this.context = context;
    }

    public void setActivity(FragmentActivity activity) {
        this.activity = activity;
    }

    public boolean shouldOverrideUrlLoading(WebView view, String url) {
        if (url.contains("tel:")) {
            this.showDialogs(url);
            return true;
        } else if (url.contains("image://?")) {
            String temp = url.replace("image://?", "");
            String[] params = temp.split("&");
            String[] imgUrl = null;
            int index = 0;
            String[] var7 = params;
            int var8 = params.length;

            for(int var9 = 0; var9 < var8; ++var9) {
                String param = var7[var9];
                if (param.contains("url=")) {
                    param = param.replace("url=", "");
                    imgUrl = param.split(",");
                } else if (param.contains("currentIndex=")) {
                    param = param.replace("currentIndex=", "");

                    try {
                        index = Integer.parseInt(param);
                    } catch (NumberFormatException var12) {
                        index = 0;
                    }
                }
            }

            if (imgUrl != null && imgUrl.length > 0) {
                List<String> list = Arrays.asList(imgUrl);
                this.listener.webviewImageClick(list, index);
            }

            return true;
        } else {
            Intent intent;
            if (!url.startsWith("alipays://platformapi/startapp") && !url.startsWith("alipays://platformapi/startApp")) {
                if (!url.startsWith("http:") && !url.startsWith("https:")) {
                    if (url.startsWith("yy://")) {
                        try {
                            url = URLDecoder.decode(url, "UTF-8");
                        } catch (UnsupportedEncodingException var13) {
                            var13.printStackTrace();
                        }

                        if (url.startsWith("yy://return/")) {
                            this.webView.handlerReturnData(url);
                        } else {
                            this.webView.flushMessageQueue();
                        }

                        return true;
                    } else {
                        try {
                            intent = new Intent("android.intent.action.VIEW", Uri.parse(url));
                            this.context.startActivity(intent);
                        } catch (Exception var14) {
                            var14.printStackTrace();
                        }

                        return true;
                    }
                } else {
                    return super.shouldOverrideUrlLoading(view, url);
                }
            } else {
                try {
                    intent = new Intent("android.intent.action.VIEW", Uri.parse(url));
                    this.context.startActivity(intent);
                    return true;
                } catch (ActivityNotFoundException var15) {
                    Toast.makeText(this.context, "您还未安装支付宝客户端，请安装后重试", Toast.LENGTH_SHORT).show();
                    var15.printStackTrace();
                    return true;
                }
            }
        }
    }

    public void onPageStarted(WebView view, String url, Bitmap favicon) {
        super.onPageStarted(view, url, favicon);
    }

    public void onPageFinished(WebView view, String url) {
        super.onPageFinished(view, url);
        if ("WebViewJavascriptBridge.js" != null) {
            BridgeUtil.webViewLoadLocalJs(view, "WebViewJavascriptBridge.js");
        }

        if (this.webView.getStartupMessage() != null) {
            Iterator var3 = this.webView.getStartupMessage().iterator();

            while(var3.hasNext()) {
                Message m = (Message)var3.next();
                this.webView.dispatchMessage(m);
            }

            this.webView.setStartupMessage((List)null);
        }

        if (this.listener != null) {
            this.listener.pageLoadFinished();
        }

    }

    public void onReceivedError(WebView webView, WebResourceRequest webResourceRequest, WebResourceError webResourceError) {
        super.onReceivedError(webView, webResourceRequest, webResourceError);
        if (this.listener != null) {
            this.listener.setLoadFail();
        }

    }

    private void showDialogs(final String url) {
        String telNum = url.substring(url.indexOf(":", 1), url.length());
        (new AlertDialog.Builder(this.context)).setTitle("提示").setMessage("确认拨打 " + telNum).setPositiveButton("确定", new OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                try {
                    if (activity == null) {
                        return;
                    }
                    // 直接拨号
                   /* new RxPermissions(activity)
                            .request(Manifest.permission.CALL_PHONE)
                            .subscribe(new Consumer<Boolean>() {
                                @Override
                                public void accept(Boolean aBoolean) throws Exception {
                                    if (aBoolean) {
                                        Uri uri = Uri.parse(url);
                                        Intent it = new Intent("android.intent.action.CALL", uri);
                                        BridgeWebViewClient.this.context.startActivity(it);
                                    } else {
                                        Toast.makeText(activity, "缺少相关权限，暂时不能使用该功能", Toast.LENGTH_SHORT).show();
                                    }
                                }
                            });*/

                    // 跳转到拨号界面
                    Intent intent = new Intent(Intent.ACTION_DIAL);
                    intent.setData(Uri.parse(url));
                    BridgeWebViewClient.this.context.startActivity(intent);
                } catch (Exception var5) {
                    var5.printStackTrace();
                }

            }
        }).setNegativeButton("取消", new OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        }).create().show();
    }

    public void registWebClientListener(WebClientListener listener) {
        this.removeWebClientListener();
        this.listener = listener;
    }

    public void removeWebClientListener() {
        if (this.listener != null) {
            this.listener = null;
        }

    }

    public interface WebClientListener {
        void setLoadFail();

        void pageLoadFinished();

        void webviewImageClick(List<String> var1, int var2);
    }
}
