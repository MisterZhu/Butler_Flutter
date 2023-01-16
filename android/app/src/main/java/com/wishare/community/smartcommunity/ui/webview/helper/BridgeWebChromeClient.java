//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package com.wishare.community.smartcommunity.ui.webview.helper;

import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.content.DialogInterface;
import android.content.DialogInterface.OnCancelListener;
import android.content.DialogInterface.OnClickListener;
import android.content.DialogInterface.OnKeyListener;
import android.net.Uri;
import android.util.Log;
import android.view.KeyEvent;
import android.widget.EditText;
import com.tencent.smtt.export.external.interfaces.JsPromptResult;
import com.tencent.smtt.export.external.interfaces.JsResult;
import com.tencent.smtt.sdk.ValueCallback;
import com.tencent.smtt.sdk.WebChromeClient;
import com.tencent.smtt.sdk.WebView;
import com.tencent.smtt.sdk.WebChromeClient.FileChooserParams;

public class BridgeWebChromeClient extends WebChromeClient {
    private FileChooserCallback fileChooserCallback;

    public BridgeWebChromeClient(FileChooserCallback fileChooserCallback) {
        this.fileChooserCallback = fileChooserCallback;
    }

    public boolean onShowFileChooser(WebView webView, ValueCallback<Uri[]> valueCallback, FileChooserParams fileChooserParams) {
        if (this.fileChooserCallback != null) {
            this.fileChooserCallback.showFileChooserUris(valueCallback);
        }

        return true;
    }

    public void openFileChooser(android.webkit.ValueCallback<Uri> uploadMsg) {
        if (this.fileChooserCallback != null) {
            this.fileChooserCallback.showFileChooserUri(uploadMsg);
        }

    }

    public void openFileChooser(android.webkit.ValueCallback<Uri> uploadMsg, String acceptType) {
        this.openFileChooser(uploadMsg);
    }

    public void openFileChooser(android.webkit.ValueCallback<Uri> uploadMsg, String acceptType, String capture) {
        this.openFileChooser(uploadMsg, acceptType);
    }

    public boolean onJsAlert(WebView view, String url, String message, JsResult result) {
        Builder builder = new Builder(view.getContext());
        builder.setTitle("提示").setMessage(message).setPositiveButton("确定", (OnClickListener)null);
        builder.setOnKeyListener(new OnKeyListener() {
            public boolean onKey(DialogInterface dialog, int keyCode, KeyEvent event) {
                Log.v("onJsAlert", "keyCode==" + keyCode + "event=" + event);
                return true;
            }
        });
        builder.setCancelable(false);
        AlertDialog dialog = builder.create();
        dialog.show();
        result.confirm();
        return true;
    }

    public boolean onJsConfirm(WebView view, String url, String message, final JsResult result) {
        Builder builder = new Builder(view.getContext());
        builder.setTitle("提示").setMessage(message).setPositiveButton("确定", new OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                result.confirm();
            }
        }).setNeutralButton("取消", new OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                result.cancel();
            }
        });
        builder.setOnCancelListener(new OnCancelListener() {
            public void onCancel(DialogInterface dialog) {
                result.cancel();
            }
        });
        builder.setOnKeyListener(new OnKeyListener() {
            public boolean onKey(DialogInterface dialog, int keyCode, KeyEvent event) {
                Log.v("onJsConfirm", "keyCode==" + keyCode + "event=" + event);
                return true;
            }
        });
        builder.setCancelable(false);
        AlertDialog dialog = builder.create();
        dialog.show();
        return true;
    }

    public boolean onJsPrompt(WebView view, String url, String message, String defaultValue, final JsPromptResult result) {
        Builder builder = new Builder(view.getContext());
        builder.setTitle("提示").setMessage(message);
        final EditText et = new EditText(view.getContext());
        et.setSingleLine();
        et.setText(defaultValue);
        builder.setView(et).setPositiveButton("确定", new OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                result.confirm(et.getText().toString());
            }
        }).setNeutralButton("取消", new OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                result.cancel();
            }
        });
        builder.setOnKeyListener(new OnKeyListener() {
            public boolean onKey(DialogInterface dialog, int keyCode, KeyEvent event) {
                Log.v("onJsPrompt", "keyCode==" + keyCode + "event=" + event);
                return true;
            }
        });
        builder.setCancelable(false);
        AlertDialog dialog = builder.create();
        dialog.show();
        return true;
    }

    public interface FileChooserCallback {
        void showFileChooserUris(android.webkit.ValueCallback<Uri[]> var1);

        void showFileChooserUri(android.webkit.ValueCallback<Uri> var1);
    }
}
