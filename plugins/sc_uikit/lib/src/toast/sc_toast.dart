import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

/// toast工具类

class SCToast {
  /// toast
  static Future showTip(String msg) async {
    if (Platform.isAndroid || Platform.isIOS) {
      Fluttertoast.cancel();
    }
    Fluttertoast.showToast(
        webPosition: 'center',
        webBgColor: '#1B1D33',
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
    return Future.delayed(const Duration(seconds: 2));
  }

  /// 自定义tip位置
  static void showTipWithGravity({String? msg, ToastGravity? gravity}) {
    String message = msg ?? '';
    if (Platform.isAndroid || Platform.isIOS) {
      Fluttertoast.cancel();
    }
    Fluttertoast.showToast(
        webPosition: 'center',
        webBgColor: '#1B1D33',
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity);
  }
}
