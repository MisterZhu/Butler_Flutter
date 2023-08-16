/// 上传图片
import 'package:dio/dio.dart' as DIO;
import 'package:http_parser/http_parser.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Network/sc_url.dart';

class SCUploadUtils {
  /// 上传头像
  static Future uploadHeadPic(
      {required String imagePath,
      Function? successHandler,
      Function? failureHandler}) async {
    List fileList = [];
    String imageName =
        imagePath.substring(imagePath.lastIndexOf("/") + 1, imagePath.length);
    var file = await DIO.MultipartFile.fromFile(imagePath,
        filename: imageName, contentType: MediaType('image', 'jpeg'));
    fileList.add(file);
    DIO.FormData formData = DIO.FormData.fromMap({'file': fileList});
    return SCHttpManager.instance.post(
        url: SCUrl.kUploadHeadPicUrl,
        params: formData,
        success: (value) {
          successHandler?.call(value);
        },
        failure: (value) {
          failureHandler?.call(value);
        });
  }

  /// 上传多张头像
  static uploadMoreHeadPic(
      {required List imagePathList, Function? successHandler}) async {
    List list = [];
    SCLoadingUtils.show();
    for (int i = 0; i < imagePathList.length; i++) {
      await uploadHeadPic(
          imagePath: imagePathList[i],
          successHandler: (value) {
            list.add(value);
          });
    }

    SCLoadingUtils.hide();
    successHandler?.call(list);
  }

  /// 上传一张图片
  static uploadOneImage(
      {required String imagePath,
      required String url,
      Function? successHandler,
      Function? failureHandler}) async {
    List fileList = [];
    String imageName =
        imagePath.substring(imagePath.lastIndexOf("/") + 1, imagePath.length);
    var file = await DIO.MultipartFile.fromFile(imagePath,
        filename: imageName, contentType: MediaType('image', 'jpeg'));
    fileList.add(file);
    DIO.FormData formData = DIO.FormData.fromMap({'file': fileList});
    return SCHttpManager.instance.post(
        url: url,
        params: formData,
        success: (value) {
          successHandler?.call(value);
        },
        failure: (value) {
          failureHandler?.call(value);
        });
  }

  /// 上传多张图片
  static uploadMoreImage(
      {required List imagePathList,
      required String url,
      Function? successHandler}) async {
    List list = [];
    SCLoadingUtils.show(text: SCDefaultValue.uploadingTip);
    for (int i = 0; i < imagePathList.length; i++) {
      await uploadOneImage(
          imagePath: imagePathList[i],
          url: url,
          successHandler: (value) {
            list.add(value);
          });
    }

    SCLoadingUtils.hide();
    successHandler?.call(list);
  }
}
