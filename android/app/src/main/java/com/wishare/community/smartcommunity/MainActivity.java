package com.wishare.community.smartcommunity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.wishare.community.smartcommunity.constant.Constant;
import com.wishare.community.smartcommunity.ui.webview.SSWebView;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private static final int toWebViewCode = 1;
    private MethodChannel.Result methodChannelResult;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        GeneratedPluginRegistrant.registerWith(flutterEngine);

        // flutter 调用 Android
        new MethodChannel(flutterEngine.getDartExecutor(), Constant.FlutterChannelEnum.kFlutterToNative).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                if (call.method.equals(Constant.FlutterChannelMethodEnum.android_webview)) {
                    methodChannelResult = result;
                    HashMap<String, String> arguments = (HashMap<String, String>) call.arguments;
                    Intent intent = new Intent(MainActivity.this, SSWebView.class);
                    intent.putExtra("title", arguments.get("title"));
                    intent.putExtra("url", arguments.get("url"));
                    startActivityForResult(intent, toWebViewCode);
                } else {
                    result.success("method is not match");
                }
            }
        });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == RESULT_OK) {
            if (requestCode == toWebViewCode) {
                if (methodChannelResult == null) {
                    return;
                }
                // 回调数据给flutter
                methodChannelResult.success("success");
            }
        }
    }
}
