import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_space_model.dart';


/// 修改空间Controller

class SCChangeSpaceController extends GetxController {

  List<SCSpaceModel> dataList = [];

  /// 当前节点id，不传入就返回最顶级节点
  String currentId = '';

  /// 当前节点类型，不传入返回的是最顶级节点
  String flag = '';

  /// 是否需要组织节点，默认为true(返回组织节点)
  bool needOrgNode = true;

  @override
  onInit(){
    super.onInit();
    loadManageTreeData();
  }


  /// 获取管理空间树
  loadManageTreeData() {
    var params = {
      "currentId": currentId,
      "flag": flag,
      "needOrgNode": needOrgNode,
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kSpaceTreeUrl,
        params: params,
        success: (value){
          print('空间树==========$value');
          dataList = List<SCSpaceModel>.from(value.map((e) => SCSpaceModel.fromJson(e)).toList());
          update();
        });

  }
}