import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_material_list_model.dart';

/// 新增物资controller

class SCAddMaterialController extends GetxController {

  int pageNum = 1;

  /// 仓库名称
  String wareHouseName = '';

  /// 仓库ID
  String wareHouseId = '';

  /// 分类ID
  String classifyId = '';

  /// 数据源
  List<SCMaterialListModel> materialList = [];

  /// 默认已选的数据
  List<SCMaterialListModel> originalList = [];

  @override
  onInit() {
    super.onInit();
    //loadMaterialSortData();
  }

  /// 物资列表数据
  loadMaterialListData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "classifyId": classifyId,  /// 分类id
        "deleted": false,
        "enabled": true,
        "fields": [],
        "wareHouseId": wareHouseId,  /// 仓库ID
      },
      "count": false,
      "last": false,
      "orderBy": [],
      "pageNum": pageNum,
      "pageSize": 20
    };
    SCHttpManager.instance.post(
        url: SCUrl.kMaterialListUrl,
        params: params,
        success: (value) {
          List list = value['records'];
          if (isLoadMore == true) {
            materialList.addAll(List<SCMaterialListModel>.from(
                list.map((e) => SCMaterialListModel.fromJson(e)).toList()));
          } else {
            materialList = List<SCMaterialListModel>.from(
                list.map((e) => SCMaterialListModel.fromJson(e)).toList());
          }
          for (SCMaterialListModel model in materialList) {
            for (SCMaterialListModel subModel in originalList) {
              if (model.id == subModel.id) {
                model.localNum = subModel.localNum;
                model.isSelect = true;
              }
            }
          }
          update();
          bool last = false;
          if (isLoadMore) {
            last = value['last'];
          }
          completeHandler?.call(true, last);
        },
        failure: (value) {
          if (isLoadMore) {
            pageNum--;
          }
          SCToast.showTip(value['message']);
          completeHandler?.call(false, false);
        });
  }

  /// 处理搜索的数据
  dealSearchData(List<SCMaterialListModel> list) {
    for (SCMaterialListModel model in list) {
      for (SCMaterialListModel subModel in materialList) {
        if (model.id == subModel.id) {
          subModel.localNum = model.localNum;
          subModel.isSelect = true;
        }
      }
    }
    update();
  }

  /// 物资分类数据
  loadMaterialSortData() {
    SCHttpManager.instance.post(
        url: SCUrl.kMaterialSortUrl,
        params: null,
        success: (value) {
          print('物资分类数据=================$value');

          update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
        });
  }
}
