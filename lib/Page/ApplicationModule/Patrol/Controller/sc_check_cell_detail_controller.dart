import 'dart:developer';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_key.dart';
import 'package:smartcommunity/Network/sc_config.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_form_data_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_image_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_patrol_detail_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_task_check_model.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Date/sc_date_utils.dart';
import 'package:smartcommunity/utils/Router/sc_router_helper.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../../../Utils/Router/sc_router_path.dart';

/// 任务日志controller

class SCCheckCellDetailController extends GetxController {

  CellDetailList cellDetailList = CellDetailList();

  @override
  onInit() {
    super.onInit();
  }

  /// 初始化
  initParams(Map<String, dynamic> params) {
    if (params.isNotEmpty) {
      var model = params['cellDetailList'];
      if (model != null) {
        cellDetailList = model;
      }
    }
  }


  jumpToEdit(){
    SCRouterHelper.pathPage(SCRouterPath.patrolCheckCellPage, {
      'checkItem': checkItem,
      'model': detailCellModel,
      'patrolDetail': widget.state.model
    });
  }
}
