import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Page/Login/Home/Model/sc_user_model.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';

import '../../../../Constants/sc_asset.dart';
import '../Model/sc_work_order_model.dart';

/// 工作台Controller

class SCWorkBenchController extends GetxController {

  String pageName = '';

  String tag = '';

  List<SCWorkOrderModel> dataList = [];

  /// 进行中数量
  int processOrder = 0;

  /// 新增数量
  int newOrder = 0;

  /// 我的关注数量
  int myAttention = 0;

  List numDataList = [];

  @override
  onInit(){
    super.onInit();
    loadData();

  }

  /// 更新头部数量数据
  updateNumData() {
    numDataList = [
      {'number': newOrder, 'description': '今日新增', 'iconUrl': SCAsset.iconTodayAdd},
      {'number': processOrder, 'description': '进行中', 'iconUrl': SCAsset.iconDoing},
      {'number': myAttention, 'description': '我的关注', 'iconUrl': SCAsset.iconLike}
    ];
    update();
  }

  /// 加载数据
  loadData() {
    getUserInfo();
    getWorkOrderNumber();
    getWorkOrderList();
  }

  /// 获取用户信息
  getUserInfo() {
    if (SCScaffoldManager.instance.isLogin) {
      String token = SCScaffoldManager.instance.user.token ?? '';
      var params = {
        'id' : SCScaffoldManager.instance.user.id
      };
      SCHttpManager.instance.get(url: SCUrl.kUserInfoUrl, params: params, success: (value){
        value['token'] = token;
        SCUserModel userModel = SCUserModel.fromJson(value);
        SCScaffoldManager.instance.user = userModel;
        Get.forceAppUpdate();
      });
    }
  }

  /// 获取默认配置
  getDefaultConfig() {
    if (SCScaffoldManager.instance.isLogin) {
      SCHttpManager.instance.get(url: SCUrl.kUserDefaultConfigUrl, params: null, success: (value){
      });
    }
  }

  /// 获取工单数量
  getWorkOrderNumber() {
    SCHttpManager.instance.get(
        url: SCUrl.kWorkOrderNumberUrl,
        params: null,
        success: (value){
          processOrder = value['processOrder'];
          newOrder = value['newOrder'];
          updateNumData();
    });

  }

  /// 获取工单列表
  getWorkOrderList() {
    var params = {
      "conditions": {
        "fields": [{
          "map": {},
          "method": 1,
          "name": "wo.status",
          "value": 2
        }, {
          "map": {},
          "method": 1,
          "name": "wo.process_user_id",
          "value": "11165121145828"
        }]
      },
      "count": true,
      "last": true,
      "orderBy": [{
        "asc": false,
        "field": "wo.create_time"
      }],
      "pageNum": 1,
      "pageSize": 10
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kWorkOrderListUrl,
        params: params,
        success: (value){
          print('工单列表==========$value');
          List list = value['records'];
          dataList = List<SCWorkOrderModel>.from(list.map((e) => SCWorkOrderModel.fromJson(e)).toList());
          update();
        });

  }
}