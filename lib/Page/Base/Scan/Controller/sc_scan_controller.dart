import 'dart:convert';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/Router/sc_router_path.dart';
import '../../../../Utils/sc_utils.dart';
import '../../../ApplicationModule/Patrol/Model/sc_form_data_model.dart';

/// 扫一扫controller
class SCScanController extends GetxController {
  /// 是否开启闪光灯
  bool isOpenFlash = false;

  /// 开启闪光灯
  openFlash({required bool isOpen}) {
    isOpenFlash = isOpen;
    update();
  }

  deviceBasic(var id) {
    SCLoadingUtils.show();
    print("id ======  $id");

    SCHttpManager.instance.get(
        url: SCUrl.deviceBasicUrl + id,
        success: (value) {
          SCLoadingUtils.hide();
          Device device = Device.fromJson(value);
          SCRouterHelper.pathPage(SCRouterPath.patrolPage,
              {"pageType": 2, "deviceCode": device.deviceCode});
        },
        failure: (value) {
          // if (value['message'] != null) {
          //   String message = value['message'];
          //   SCToast.showTip(message);
          // }
        });
  }

  qrcodeCheck(var id) {
    print("id ======  $id");

    SCHttpManager.instance.get(
        url: "${SCUrl.qrCodeTypeUrl}?qrCode=$id",
        success: (value) {
          List<dynamic> jsonData = json.decode(value);
          List<DeviceTypeModel> items = [];
          for (var itemJson in jsonData) {
            DeviceTypeModel item = DeviceTypeModel.fromJson(itemJson);
            items.add(item);
          }
          if (items.length == 1) {
            DeviceTypeModel fistModel = items[0];
            if (fistModel.type == 'DEVICE') {
              //设备
              deviceBasic(id);
            } else if (fistModel.type == 'VISITOR') {
              ///访客
            }
          } else if (items.length == 2) {
            DeviceTypeModel fistModel = items[0];
            DeviceTypeModel lastModel = items[1];
            if (fistModel.type == lastModel.type) {
              if (fistModel.type == 'DEVICE') {
                //设备
                deviceBasic(id);
              } else if (fistModel.type == 'VISITOR') {
                ///访客

              }
            }else{
              //弹框处理
              popHandle(items);
            }
          }
        },
        failure: (value) {});
  }
  popHandle(List<DeviceTypeModel> items) {
    DeviceTypeModel fistModel = items[0];
    DeviceTypeModel lastModel = items[1];
    List<SCBottomSheetModel> dataList = [
      SCBottomSheetModel(
          title: "巡检设备",
          color: SCColors.color_1B1C33,
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w400),
      SCBottomSheetModel(
          title: '访客设备',
          color: SCColors.color_1B1C33,
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w400)
    ];
    SCUtils.getCurrentContext(completionHandler: (context) async {
      SCDialogUtils.instance.showBottomDialog(
          context: context,
          dataList: dataList,
          onTap: (index, context) {
            if (index == 0) {
              // 相机

            } else {
              // 相册

            }
          });
    });
  }
}
