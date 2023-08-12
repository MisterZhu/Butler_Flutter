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
    print("id ==111====  $id");

    SCHttpManager.instance.get(
        url: SCUrl.deviceBasicUrl + id,
        success: (value) {
          SCLoadingUtils.hide();
          Device device = Device.fromJson(value);
          SCRouterHelper.pathPage(SCRouterPath.patrolPage,
              {"pageType": 2, "deviceCode": device.deviceCode});
        },
        failure: (value) {
          SCLoadingUtils.hide();

          // if (value['message'] != null) {
          //   String message = value['message'];
          //   SCToast.showTip(message);
          // }
        });
  }

  ///查询二维码类型
  qrcodeCheck(var id) {
    SCLoadingUtils.show();

    print("id ===222===  $id");
    SCHttpManager.instance.get(
        url: "${SCUrl.qrCodeTypeUrl}?qrCode=$id",
        success: (value) {
          SCLoadingUtils.hide();
          // List<dynamic> jsonData = json.decode(value);
          // List<Map<String, dynamic>> jsonData = List<Map<String, dynamic>>.from(json.decode(value));
          List<DeviceTypeModel> items = [];
          for (var itemJson in value) {
            DeviceTypeModel item = DeviceTypeModel.fromJson(itemJson);
            items.add(item);
          }
          if (items.length == 1) {
            // DeviceTypeModel fistModel = items[0];
            //
            // deviceOrVisitor(fistModel);
            popHandle(items);

          } else if (items.length == 2) {
            DeviceTypeModel fistModel = items[0];
            DeviceTypeModel lastModel = items[1];
            if (fistModel.type == lastModel.type) {
              deviceOrVisitor(fistModel);
            } else {
              //弹框处理
              popHandle(items);
            }
          }
        },
        failure: (value) {
          SCLoadingUtils.hide();
        });
  }

  popHandle(List<DeviceTypeModel> items) {
    DeviceTypeModel fistModel = items[0];
    DeviceTypeModel lastModel = items[0];
    var name = "";
    var name1 = "";
    if (fistModel.type == 'DEVICE') {
      //设备
      name = "巡检设备";
      name1 = "访客设备";
    } else if (fistModel.type == 'VISITOR') {
      ///访客
      name = "访客设备";
      name1 = "巡检设备";
    }
    List<SCBottomSheetModel> dataList = [
      SCBottomSheetModel(
          title: name,
          color: SCColors.color_1B1C33,
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w400),
      SCBottomSheetModel(
          title: name1,
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
              deviceOrVisitor(fistModel);
            } else {
              deviceOrVisitor(lastModel);
            }
          });
    });
  }

  deviceOrVisitor(DeviceTypeModel item) {
    if (item.type == 'DEVICE') {
      //设备
      deviceBasic(item.qrCode);
    } else if (item.type == 'VISITOR') {
      ///访客

    }
  }
}
