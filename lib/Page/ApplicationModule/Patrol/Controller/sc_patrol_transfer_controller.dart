import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../MaterialEntry/Model/sc_selectcategory_model.dart';
import '../../MaterialEntry/Model/sc_selectcategory_tree_model.dart';
import '../../MaterialOutbound/Model/sc_receiver_model.dart';

/// 转派-controller

class SCPatrolTransferController extends GetxController {
  /// 部门
  String department = "";

  /// 部门id
  String departmentId = "";

  /// 人
  String user = "";

  /// 人id
  String userId = "";

  /// 更新部门信息
  updateDepartmentInfo(SCSelectCategoryModel model) {
    bool enable = model.enable ?? false;
    if (enable) {
      if (departmentId != (model.id ?? '')) {
        user = '';
        userId = '';
        departmentId = model.id ?? '';
        department = model.title ?? '';
        update();
      }
    } else {
      // 未选择数据
    }
  }

  /// 更新转派人员信息
  updateUserInfo(SCReceiverModel model) {
    userId = model.personId ?? '';
    user = model.personName ?? '';
    update();
  }
}
