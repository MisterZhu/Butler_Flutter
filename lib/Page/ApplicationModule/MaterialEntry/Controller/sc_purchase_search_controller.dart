import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_list_model.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_purchase_model.dart';

/// 采购需求单搜索controller

class SCPurchaseSearchController extends GetxController {

  List<SCPurchaseModel> list = [];

  /// 搜索采购单
  searchData({required String text}) {
    var params= {
      "wareHousePurchaseId" : text
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kPurchaseSearchUrl,
        isQuery: true,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          if (value is List) {
            list = List.from(value.map((e) {
              return SCPurchaseModel.fromJson(e);
            }));
            update();
          }
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 采购单物资详情
  detail({required SCPurchaseModel model}) {
    var params= {
      "purchaseId" : model.id ?? ''
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kPurchaseDetailUrl,
        isQuery: true,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          if (value is List) {
            List<SCMaterialListModel> materialList = List.from(value.map((e) {
              return SCMaterialListModel.fromJson(e);
            }));
            if (materialList.isEmpty) {
              SCToast.showTip(SCDefaultValue.purchaseNoMaterialTip);
            } else {
              SCRouterHelper.back({
                "model" : model,
                "materialList" : materialList
              });
            }
          }
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

}