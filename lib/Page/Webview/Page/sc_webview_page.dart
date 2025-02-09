import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Constants/sc_key.dart';
import 'package:smartcommunity/Network/sc_config.dart';
import 'package:smartcommunity/Page/Webview/Constant/sc_flutter_h5_key.dart';
import 'package:smartcommunity/Page/Webview/Constant/sc_h5_flutter_key.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';
import 'package:smartcommunity/Utils/Location/sc_location_model.dart';
import 'package:smartcommunity/Utils/Permission/sc_permission_utils.dart';
import 'package:smartcommunity/Utils/Upload/sc_upload_utils.dart';
import 'package:smartcommunity/Utils/sc_sp_utils.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../Constants/sc_asset.dart';
import '../../../Utils/Router/sc_router_helper.dart';
import '../../../Utils/sc_string_utils.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_webview_page
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/8 14:40
/// Description: WebView加载
class SCWebViewPage extends StatefulWidget {
  final Map<String, dynamic>? arguments;

  const SCWebViewPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<SCWebViewPage> createState() => _SCWebViewPageState();
}

class _SCWebViewPageState extends State<SCWebViewPage> {
  WebViewController? webViewController;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  /// webView title
  String _title = "";

  /// webView url
  String _url = "";

  /// 如果是富文本 则传递richText
  String _richText = "";

  /// 是否需要拼接参数
  bool needJointParams = false;

  bool _isLocalUrl = false;

  /// 进度
  double progress = 0;

  @override
  void initState() {
    super.initState();
    dynamic params = Get.arguments;
    log('webView接收的参数：$params');
    _title = StringUtils.isNotNullOrEmpty(params?["title"]) ? params!["title"] : "";
    _richText = StringUtils.isNotNullOrEmpty(params?["richText"]) ? params!["richText"] : "";
    _isLocalUrl = params?["isLocalUrl"] ?? false;
    needJointParams = params["needJointParams"] ?? false;

    /// 是否需要拼接参数
    String subUrl =
        StringUtils.isNotNullOrEmpty(params?["url"]) ? params!["url"] : "";
    if (needJointParams) {
      _url = SCUtils.getWebViewUrl(url: subUrl,title: _title,  needJointParams: true);
    } else {
      _url = subUrl;
    }
    print("url=$_url");
  }

  @override
  void dispose() {
    // EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
      leading: _leading(),
      leadingWidth: 100,
      body: _body(),
      centerTitle: true,
      showBackIcon: true,
      showBackgroundImage: false,
      title: _title,
    );
  }

  /// leading
  Widget _leading() {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 24,
            height: 44,
            child: CupertinoButton(
                padding: EdgeInsets.zero,
                minSize: 44.0,
                child: Image.asset(
                  SCAsset.iconNavigationBack,
                  width: 24.0,
                  height: 24.0,
                ),
                onPressed: () {
                  goBack();
                }),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 24,
            height: 44,
            child: CupertinoButton(
                padding: EdgeInsets.zero,
                minSize: 44.0,
                child: Image.asset(
                  SCAsset.iconNavigationClose,
                  width: 24.0,
                  height: 24.0,
                ),
                onPressed: () {
                  SCRouterHelper.back(null);
                }),
          ),
        ],
      ),
    );
  }

  /// body
  Widget _body() {
    return ((StringUtils.isNullOrEmpty(_url) && !_isLocalUrl) ||
            (_isLocalUrl &&
                (StringUtils.isNullOrEmpty(_richText) &&
                    StringUtils.isNullOrEmpty(_url))))
        ? Container(
            padding: const EdgeInsets.all(16),
            child: const Center(
              child: Text("当前路径为空"),
            ),
          )
        : _isLocalUrl && StringUtils.isNotNullOrEmpty(_richText)
            ? RichText(
                text: TextSpan(text: _richText),
              )
            : contentItem();
  }

  /// content
  Widget contentItem() {
    return Stack(
      children: [
        webViewItem(),
        progressIndicator(),
      ],
    );
  }

  /// webView
  Widget webViewItem() {
    return WebView(
      initialUrl: _isLocalUrl ? "" : _url,

      /// 是否开启JS
      javascriptMode: JavascriptMode.unrestricted,

      /// 跟H5交互的方法到此处处理
      javascriptChannels: {
        jxTokenChannel(context),
        getLocationChannel(context),
        scanChannel(context),
        userInfoChannel(context),
        cameraChannel(context),
        photosChannel(context),
        phoneChannel(context),
        gobackNativeChannel(context),
        // albumAlertChannel(context),
        reloadWorkBenchChannel(context),
      },

      ///WebView创建
      onWebViewCreated: _onWebViewCreated,

      ///页面开始加载
      onPageStarted: _onPageStarted,

      ///页面加载结束
      onPageFinished: _onPageFinished,

      onProgress: _onProgress,

      ///如果出现错误
      onWebResourceError: (WebResourceError error) =>
          debugPrint('error:${error.description}'),
    );
  }

  /// 进度条
  Widget progressIndicator() {
    bool offstage = progress < 1.0 ? false : true;
    return Positioned(
        left: 0,
        right: 0,
        top: 0,
        child: Offstage(
          offstage: offstage,
          child: LinearProgressIndicator(
            backgroundColor: Colors.transparent,
            color: SCColors.primaryColor,
            value: progress,
          ),
        ));
  }

  /// webView创建
  void _onWebViewCreated(WebViewController controller) async {
    webViewController = controller;

    print("webViewController====>$webViewController");
    if (_isLocalUrl) {
      await _loadHtmlFromAssets();
    }
    _controller.complete(controller);
    webViewController!.clearCache();
  }

  /// webView开始加载
  void _onPageStarted(String url) {
    // EasyLoading.show();
  }

  /// webView加载结束
  void _onPageFinished(String url) async {
    // EasyLoading.dismiss();
  }

  void _onProgress(int progress) {
    if (mounted) {
      setState(() {
        this.progress = progress / 100;
      });
    }
  }

  _loadHtmlFromAssets() async {
    // String fileHtmlContents = await rootBundle.loadString(_url);
    // webViewController?.loadUrl(Uri.dataFromString(fileHtmlContents,
    //         mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
    //     .toString());
  }

  // 后退
  goBack() async {
    if (webViewController == null) {
      SCRouterHelper.back(null);
      return;
    }
    bool goBack = await webViewController!.canGoBack();
    if (goBack) {
      webViewController!.goBack();
    } else {
      SCRouterHelper.back(null);
    }
  }

  /// 建信租房token-channel
  JavascriptChannel jxTokenChannel(BuildContext context) => JavascriptChannel(
      name: SCH5FlutterKey.jxToken,
      onMessageReceived: (JavascriptMessage message) {
        String token = jsonDecode(message.message);
        cacheJXToken(token);
      });

  ///  获取定位-channel
  JavascriptChannel getLocationChannel(BuildContext context) =>
      JavascriptChannel(
          name: SCH5FlutterKey.location,
          onMessageReceived: (JavascriptMessage message) {
            SCPermissionUtils.startLocationWithPrivacyAlert(
                completionHandler: (dynamic value, SCLocationModel? model) {
              webViewController?.runJavascript(SCUtils().flutterCallH5(
                  h5Name: SCFlutterH5Key.location, params: value));
            });
          });

  ///  扫码-channel
  JavascriptChannel scanChannel(BuildContext context) => JavascriptChannel(
      name: SCH5FlutterKey.scan,

      onMessageReceived: (JavascriptMessage message) {
        SCPermissionUtils.scanCodeReadWithPrivacyAlert(completionHandler: (value) {
          var params =value;
          webViewController?.runJavascript(SCUtils()
              .flutterCallH5(h5Name: SCFlutterH5Key.scan, params: params));
        });
      });

  ///  用户信息-channel
  JavascriptChannel userInfoChannel(BuildContext context) => JavascriptChannel(
      name: SCH5FlutterKey.userInfo,
      onMessageReceived: (JavascriptMessage message) {
        var params = {
          "status": 1,
          "data": {
            'token': SCScaffoldManager.instance.user.token,
            'phone': SCScaffoldManager.instance.user.mobileNum,
            'userName': SCScaffoldManager.instance.user.userName,
          }
        };
        webViewController?.runJavascript(SCUtils()
            .flutterCallH5(h5Name: SCFlutterH5Key.userInfo, params: params));
      });

  ///  相机-channel
  JavascriptChannel cameraChannel(BuildContext context) => JavascriptChannel(
      name: SCH5FlutterKey.camera,
      onMessageReceived: (JavascriptMessage message) {
        SCPermissionUtils.takePhoto((String path) async {
          String base64 = await SCUtils().localImageToBase64(path);
          var params = {
            "status": 1,
            "data": {"result": base64}
          };
          webViewController?.runJavascript(SCUtils()
              .flutterCallH5(h5Name: SCFlutterH5Key.camera, params: params));
        });
      });

  //  相册-channel
  JavascriptChannel photosChannel(BuildContext context) => JavascriptChannel(
      name: SCH5FlutterKey.photos,
      onMessageReceived: (JavascriptMessage message) {
        SCPermissionUtils.photoPicker(completionHandler: (List pathList) async {
          List list = [];
          for (String path in pathList) {
            String base64 = await SCUtils().localImageToBase64(path);
            list.add(base64);
          }
          var params = {
            "status": 1,
            "data": {"result": list}
          };
          webViewController?.runJavascript(SCUtils()
              .flutterCallH5(h5Name: SCFlutterH5Key.photos, params: params));
        });
      });
  /// 返回原生页面
  JavascriptChannel gobackNativeChannel(BuildContext context) => JavascriptChannel(
      name: SCH5FlutterKey.goback,
      onMessageReceived: (JavascriptMessage message) {
        SCRouterHelper.back(null);
      });

  //  打电话-channel
  JavascriptChannel phoneChannel(BuildContext context) => JavascriptChannel(
      name: SCH5FlutterKey.phone,
      onMessageReceived: (JavascriptMessage message) {
        var json = jsonDecode(message.message);
        String phone = json['phone'];
        SCUtils.call(phone);
      });

  //  弹窗选择拍照或相册-channel
  JavascriptChannel albumAlertChannel(BuildContext context) =>
      JavascriptChannel(
          name: SCH5FlutterKey.albumAlert,
          onMessageReceived: (JavascriptMessage message) {
            var json = jsonDecode(message.message);
            int maxLength = json['maxLength'];
            SCPermissionUtils.showImagePicker(
                maxLength: maxLength,
                completionHandler: (imageList) async {
                  List list = [];
                  for (String path in imageList) {
                    File file = File(path);
                    List<int> imageBytes = await file.readAsBytes();
                    list.add(base64Encode(imageBytes));
                  }
                  var params = {
                    "status": 1,
                    "data": {"result": list}
                  };
                  webViewController?.runJavascript(SCUtils().flutterCallH5(
                      h5Name: SCFlutterH5Key.albumAlert, params: params));
                });
          });

  //  刷新工作台-channel
  JavascriptChannel reloadWorkBenchChannel(BuildContext context) =>
      JavascriptChannel(
          name: SCH5FlutterKey.reloadWorkBench,
          onMessageReceived: (JavascriptMessage message) {
            print("刷新工作台数据");
            var params = {"key": SCKey.kSwitchEnterprise};
            SCScaffoldManager.instance.eventBus.fire(params);
          });

  /// 缓存建信租房token
  cacheJXToken(String token) {
    SCSpUtil.setString(SCKey.kJianXinRentingToken, token);
  }

  /// 拼接参数
  String jointParams(String url) {
    String token = SCScaffoldManager.instance.user.token ?? "";
    String client = SCDefaultValue.client;
    String defOrgId = SCScaffoldManager.instance.user.tenantId ?? '';
    String phoneNum = SCScaffoldManager.instance.user.mobileNum ?? '';
    String defOrgName =
        Uri.encodeComponent(SCScaffoldManager.instance.user.tenantName ?? '');
    String userId = SCScaffoldManager.instance.user.id ?? '';
    String spaceIds = SCScaffoldManager.instance.spaceIds ?? '';
    String userName =
        Uri.encodeComponent(SCScaffoldManager.instance.user.userName ?? '');

    /// 拼接符号
    String jointSymbol = "";

    /// 经度
    double latitude = SCScaffoldManager.instance.latitude;

    /// 纬度
    double longitude = SCScaffoldManager.instance.longitude;

    /// h5渠道-key
    String h5ChannelKey = SCKey.kH5Channel;

    /// h5渠道-value
    int h5ChannelValue = SCDefaultValue.h5Channel;

    if (spaceIds.isEmpty) {
      spaceIds = SCScaffoldManager.instance.user.tenantId ?? '';
    }
    if (url.contains('?')) {
      jointSymbol = "&";
    } else {
      jointSymbol = "?";
    }
    String newUrl =
        "$url${jointSymbol}Authorization=$token&client=$client&defOrgId=$defOrgId&defOrgName=$defOrgName&tenantId=$defOrgId&phoneNum=$phoneNum&spaceIds=$spaceIds&userId=$userId&userName=$userName&fromQw=1&latitude=$latitude&longitude=$longitude&$h5ChannelKey=$h5ChannelValue";
    return newUrl;
  }
}
