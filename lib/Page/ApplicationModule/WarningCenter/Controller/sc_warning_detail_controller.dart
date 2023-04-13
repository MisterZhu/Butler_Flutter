
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_warningcenter_detail_model.dart';

/// 预警详情controller

class SCWarningDetailController extends GetxController {

  /// 数据是否加载成功
  bool success = false;

  /// 预警id
  String id = '';

  SCWarningCenterDetailModel detailModel = SCWarningCenterDetailModel();

  List warnDetailList = [];

  List spaceInfoList = [];

  List dealDetailList = [];
  @override
  onInit() {
    super.onInit();
    warnDetailList = [
      {'name': '网关编号', 'content': '001'},
      {'name': '回路号', 'content': '002'},
      {'name': '地址号', 'content': '003'},
      {'name': '设备位置', 'content': '004'},
      {'name': '预警事件', 'content': '火灾报警'},
      {'name': '处理时间', 'content': '2023-03-08 14:00:00'},
    ];

    spaceInfoList = [
      {'name': '空间名称', 'content': '玫瑰园小区', 'isContact': false},
      {'name': '空间类型', 'content': '住宅', 'isContact': false},
      {'name': '地址', 'content': '杭州市西湖区三墩镇杭州市西湖区三墩镇', 'isContact': false},
      {'name': '一级联系人', 'content': '刘大美', 'isContact': true, 'mobile': '123446544'},
      {'name': '二级联系人', 'content': '汪洁', 'isContact': true, 'mobile': '123446544'},
    ];
    dealDetailList = [
      {'name': '处理人', 'content': '哈哈'},
      {'name': '处理时间', 'content': '2023-03-08 14:00:00'},
      {'name': '处理结果', 'content': '经电话与项目部核实为月度消防测试'},
    ];
  }

  /// 预警详情
  loadWarningDetailData() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kWarningDetailUrl+id,
        params: null,
        success: (value) {
          SCLoadingUtils.hide();
          success = true;
          detailModel = SCWarningCenterDetailModel.fromJson(value);
          update();
        },
        failure: (value) {
          success = false;
          SCToast.showTip(value['message']);
        });
  }
}

