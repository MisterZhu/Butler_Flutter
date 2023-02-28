package com.wishare.community.smartcommunity;

import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.baidu.ocr.sdk.OCR;
import com.baidu.ocr.sdk.OnResultListener;
import com.baidu.ocr.sdk.exception.OCRError;
import com.baidu.ocr.sdk.model.AccessToken;
import com.baidu.ocr.sdk.model.IDCardParams;
import com.baidu.ocr.sdk.model.IDCardResult;
import com.baidu.ocr.ui.camera.CameraActivity;
import com.google.gson.Gson;
import com.wishare.community.smartcommunity.constant.Constant;
import com.wishare.community.smartcommunity.entity.OCRInfoEntity;
import com.wishare.community.smartcommunity.ui.webview.SSWebView;
import com.wishare.community.smartcommunity.utils.CommonUtils;
import com.wishare.community.smartcommunity.utils.OCRUtil;
import com.wishare.community.smartcommunity.utils.RecognizeService;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private static final int toWebViewCode = 0x001;
    private MethodChannel.Result methodChannelResult;
    public static final int OCR_LICENSE_PLATE = 0x002;
    private MethodChannel.Result methodChannelResult_licensePlate;
    public static final int OCR_ID_CARD = 0x003;
    private MethodChannel.Result methodChannelResult_idCard;


    // 是否初始化成功了百度OCR
    private boolean hasGotToken = false;
    private String failedText = "";

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // 初始化百度OCR
        initOCR();
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
                    // webView
                    methodChannelResult = result;
                    HashMap<String, String> arguments = (HashMap<String, String>) call.arguments;
                    Intent intent = new Intent(MainActivity.this, SSWebView.class);
                    intent.putExtra("title", arguments.get("title"));
                    intent.putExtra("url", arguments.get("url"));
                    startActivityForResult(intent, toWebViewCode);
                } else if (call.method.equals(Constant.FlutterChannelMethodEnum.android_baidu_ocr)) {
                    /**
                     *     在调用ocr的地方调用以下方法
                     *     type: 0 识别身份证  1 识别车牌号
                     *     cardType 0 身份证正面  1 身份证反面
                     *
                     *     var params = {"type": "0", "cardType": "1"};
                     *     var channel = SCScaffoldManager.flutterToNative;
                     *     var result =
                     *         await channel.invokeMethod(SCScaffoldManager.android_baidu_ocr, params);
                     *     print("android返回数据：" + result);
                     */
                    // 百度OCR
                    if (checkOCRInitSuccess(true)) {
                        HashMap<String, String> arguments = (HashMap<String, String>) call.arguments;
                        String type = arguments.get("type");
                        if (type.equals(Constant.OCRTypeEnum.ID_CARD)) {
                            methodChannelResult_idCard = result;
                            // 识别的是身份证
                            String cardType = arguments.get("cardType");
                            if ("0".equals(cardType)) {
                                // 身份证正面
                                Intent intent = new Intent(MainActivity.this, CameraActivity.class);
                                intent.putExtra(CameraActivity.KEY_OUTPUT_FILE_PATH, OCRUtil.getSaveFile(getApplication()).getAbsolutePath());
                                intent.putExtra(CameraActivity.KEY_CONTENT_TYPE, CameraActivity.CONTENT_TYPE_ID_CARD_FRONT);
                                startActivityForResult(intent, OCR_ID_CARD);
                            } else {
                                // 身份证反面
                                Intent intent = new Intent(MainActivity.this, CameraActivity.class);
                                intent.putExtra(CameraActivity.KEY_OUTPUT_FILE_PATH, OCRUtil.getSaveFile(getApplication()).getAbsolutePath());
                                intent.putExtra(CameraActivity.KEY_CONTENT_TYPE, CameraActivity.CONTENT_TYPE_ID_CARD_BACK);
                                startActivityForResult(intent, OCR_ID_CARD);
                            }
                        } else if (type.equals(Constant.OCRTypeEnum.LICENSE_PLATE)) {
                            methodChannelResult_licensePlate = result;
                            // 识别的是车牌
                            Intent intent = new Intent(MainActivity.this, CameraActivity.class);
                            intent.putExtra(CameraActivity.KEY_OUTPUT_FILE_PATH, OCRUtil.getSaveFile(getApplicationContext()).getAbsolutePath());
                            intent.putExtra(CameraActivity.KEY_CONTENT_TYPE, CameraActivity.CONTENT_TYPE_GENERAL);
                            startActivityForResult(intent, OCR_LICENSE_PLATE);
                        } else {
                            // 默认是车牌
                            methodChannelResult_licensePlate = result;
                        }
                    }
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
//                methodChannelResult.success("success");
                if (methodChannelResult != null){
                    methodChannelResult.success(data.getStringExtra("orderId"));
                }
            } else if (requestCode == OCR_LICENSE_PLATE) {
                if (methodChannelResult_licensePlate == null) {
                    return;
                }
                RecognizeService.recGeneralBasic(getApplicationContext(), OCRUtil.getSaveFile(getApplicationContext()).getAbsolutePath(),
                        new RecognizeService.ServiceListener() {
                            @Override
                            public void onResult(String result) {
                                Map<String, String> map = new HashMap<>();
                                map.put("result", result);
                                methodChannelResult_licensePlate.success(result);
                            }
                        });
            } else if (requestCode == OCR_ID_CARD) {
                if (methodChannelResult_idCard == null) {
                    return;
                }
                if (data != null) {
                    String contentType = data.getStringExtra(CameraActivity.KEY_CONTENT_TYPE);
                    String filePath = OCRUtil.getSaveFile(getApplicationContext()).getAbsolutePath();
                    if (!TextUtils.isEmpty(contentType)) {
                        if (CameraActivity.CONTENT_TYPE_ID_CARD_FRONT.equals(contentType)) {
                            recIDCard(IDCardParams.ID_CARD_SIDE_FRONT, filePath);
                        } else if (CameraActivity.CONTENT_TYPE_ID_CARD_BACK.equals(contentType)) {
                            recIDCard(IDCardParams.ID_CARD_SIDE_BACK, filePath);
                        }
                    }
                }
            }
        }
    }

    /**
     * 初始化百度OCR
     * 通过aip-ocr.license鉴权文件初始化
     */
    private void initOCR() {
        OCR.getInstance(getApplicationContext()).initAccessToken(new OnResultListener<AccessToken>() {
            @Override
            public void onResult(AccessToken accessToken) {
                Log.d("print-->", "onResult: " + accessToken.getAccessToken());
                hasGotToken = true;
            }

            @Override
            public void onError(OCRError ocrError) {
                failedText = ocrError.getLocalizedMessage();
            }
        }, "aip-ocr.license", getApplicationContext());
    }

    private boolean checkOCRInitSuccess(boolean showErrorToast) {
        if (!hasGotToken && showErrorToast) {
            if (CommonUtils.isEmpty(failedText)) {
                failedText = "百度OCR初始化失败";
            }
            Toast.makeText(getApplicationContext(), failedText, Toast.LENGTH_SHORT).show();
        }
        return hasGotToken;
    }

    private void recIDCard(String idCardSide, String filePath) {
        IDCardParams param = new IDCardParams();
        param.setImageFile(new File(filePath));
        // 设置身份证正反面
        param.setIdCardSide(idCardSide);
        // 设置方向检测
        param.setDetectDirection(true);
        // 设置图像参数压缩质量0-100, 越大图像质量越好但是请求时间越长。 不设置则默认值为20
        param.setImageQuality(20);

        param.setDetectRisk(true);

        OCR.getInstance(this).recognizeIDCard(param, new OnResultListener<IDCardResult>() {
            @Override
            public void onResult(IDCardResult result) {
                if (result == null) {
                    Toast.makeText(getApplicationContext(), "身份证识别失败", Toast.LENGTH_SHORT).show();
                    return;
                }
                if (CommonUtils.equals(IDCardParams.ID_CARD_SIDE_FRONT, idCardSide)) {
                    // 解析数据
                    String name = result.getName().getWords();
                    String gender = result.getGender().getWords();
                    String idNumber = result.getIdNumber().getWords();
                    String ethnic = result.getEthnic().getWords();
                    String birthday = result.getBirthday().getWords();
                    String address = result.getAddress().getWords();
                    OCRInfoEntity ocrInfoEntity = new OCRInfoEntity();
                    ocrInfoEntity.setName(name);
                    ocrInfoEntity.setGender(gender);
                    ocrInfoEntity.setIdNumber(idNumber);
                    ocrInfoEntity.setEthnic(ethnic);
                    ocrInfoEntity.setBirthday(birthday);
                    ocrInfoEntity.setAddress(address);
                    String response = new Gson().toJson(ocrInfoEntity);
                    methodChannelResult_idCard.success(response);
                } else {
                    String signDate = result.getSignDate().getWords();
                    String expiryDate = result.getExpiryDate().getWords();
                    String issueAuthority = result.getIssueAuthority().getWords();
                    OCRInfoEntity ocrInfoEntity = new OCRInfoEntity();
                    ocrInfoEntity.setSignDate(signDate);
                    ocrInfoEntity.setExpiryDate(expiryDate);
                    ocrInfoEntity.setIssueAuthority(issueAuthority);
                    String response = new Gson().toJson(ocrInfoEntity);
                    methodChannelResult_idCard.success(response);
                }
            }

            @Override
            public void onError(OCRError error) {
                Log.d("print-->", "onError: " + error.getMessage());
            }
        });
    }
}
