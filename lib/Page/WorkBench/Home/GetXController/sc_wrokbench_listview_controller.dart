
import 'package:get/get.dart';

import '../../../ApplicationModule/MaterialEntry/Model/sc_material_entry_model.dart';

/// listView-controller

class SCWorkBenchListViewController extends GetxController {

  /// 数据源
  List dataList = [];

  /// 物资入库
  List<SCMaterialEntryModel> materialEntryList = [];

  /// 物资出库
  List<SCMaterialEntryModel> materialOutList = [];

  /// 物资报损
  List<SCMaterialEntryModel> materialReportList = [];

  /// 物资调拨
  List<SCMaterialEntryModel> materialTransferList = [];

  String pageName = '';

  String tag = '';

}
