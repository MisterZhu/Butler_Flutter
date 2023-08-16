import 'package:flutter/widgets.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/ApplicationModule/PropertyMaintenance/View/Detail/sc_unifycompany_detail_view.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../Model/sc_material_assets_details_model.dart';
import '../../Model/sc_material_list_model.dart';
import '../../Model/sc_material_task_detail_model.dart';

/// 入库详情-所有物资cell-titleview

class SCAllMaterialTitleView extends StatelessWidget {

  final SCMaterialTaskDetailModel? model;

  /// 类型，type=0入库详情，type=1出库详情
  final SCWarehouseManageType type;

  final bool? isProperty;
  SCAllMaterialTitleView({Key? key, required this.type, this.model, this.isProperty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0), child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        titleView(),
        numView(),
        propertyMaintenanceUnifyInfoView(),
      ],
    ),);
  }
  
  /// titleView
  Widget titleView() {
    String icon = SCAsset.iconMaterialIcon;
    if (type == SCWarehouseManageType.entry) {
      icon = SCAsset.iconMaterialEntry;
    } else if (type == SCWarehouseManageType.outbound) {
      icon = SCAsset.iconMaterialOutbound;
    } else if (type == SCWarehouseManageType.frmLoss) {
      icon = SCAsset.iconMaterialFrmLoss;
    } else if (type == SCWarehouseManageType.transfer) {
      icon = SCAsset.iconMaterialTransfer;
    } else if (type == SCWarehouseManageType.check) {
      icon = SCAsset.iconMaterialCheck;
    }
    String statusDesc = SCUtils.getEntryStatusText(model?.status ?? 0);
    Color statusColor = SCUtils.getEntryStatusTextColor(model?.status ?? 0);
    if (type == SCWarehouseManageType.entry) {
      statusDesc = SCUtils.getEntryStatusText(model?.status ?? 0);
      statusColor = SCUtils.getEntryStatusTextColor(model?.status ?? 0);
    } else if (type == SCWarehouseManageType.outbound) {
      statusDesc = SCUtils.getOutboundStatusText(model?.status ?? 0);
      statusColor = SCUtils.getOutboundStatusTextColor(model?.status ?? 0);
    } else if (type == SCWarehouseManageType.check) {
      int subStatus = model?.status ?? -1;
      if (subStatus == 2 || subStatus == 4) {
        statusDesc = '';
      } else {
        statusDesc = model?.statusDesc ?? '';
      }
      statusColor = SCUtils.getCheckStatusTextColor(model?.status ?? 0);
    } else if (type == SCWarehouseManageType.fixedCheck) {
      int subStatus = model?.status ?? -1;
      if (subStatus == 2 || subStatus == 4) {
        statusDesc = '';
      } else {
        statusDesc = model?.statusDesc ?? '';
      }
      statusColor = SCUtils.getCheckStatusTextColor(model?.status ?? 0);
    } else {
      statusDesc = model?.statusDesc ?? '';
      statusColor = SCUtils.getCheckStatusTextColor(model?.status ?? 0);
    }
    //任务状态(0：未开始，1：待盘点（超时），2：待盘点，3：盘点中（超时），4：盘点中，5：已完成（超时），6：已完成，7：已作废)
    return Container(
      height: 22.0,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Image.asset(icon, width: 18.0, height: 18.0,),
          const SizedBox(width: 6.0,),
          Expanded(child: Text(model?.typeName ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_1B1D33
          ),)),
          const SizedBox(width: 6.0,),
          Text(
            statusDesc,
            style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: statusColor,))
        ],
      ),
    );
  }
  
  /// 数量view 
  Widget numView() {
    String text = '';
    if (type == SCWarehouseManageType.fixedCheck) {
      List<SCMaterialAssetsDetailsModel>? materialAssetsDetails = model?.materialAssetsDetails ?? [];
      int count = 0;
      for (SCMaterialAssetsDetailsModel model in materialAssetsDetails) {
        count += (model.num ?? 0);
      }
      text = '共 ${model?.materialAssetsDetails?.length ?? 0} 种 总数量 $count';
    } else {
      if (isProperty == true) {
        text = '共 ${model?.assets?.length ?? 0} 种';
        if (type == SCWarehouseManageType.check) {
          if (model?.status == 0 || model?.status == 1 || model?.status == 2) {
            text = '共 ${model?.materials?.length ?? 0} 种 盘点数量 0';
          } else if (model?.status == 3 || model?.status == 4) {
            text = '共 0/${model?.materials?.length ?? 0}种 盘点数量 0';
            if (model?.materials != null) {
              List<SCMaterialListModel> list = model!.materials!;
              int checkNum = 0;
              int checkCount = 0;
              for (int i = 0; i < list.length; i++) {
                SCMaterialListModel model = list[i];
                if (model.checkNum != null) {
                  checkNum = checkNum + model.checkNum!;
                  checkCount = checkCount + 1;
                }
              }
              text = '共 $checkCount/${list.length}种 盘点数量 $checkNum';
            }
          }
        }
      } else {
        text = '共 ${model?.materials?.length ?? 0} 种 总数量 ${model?.materialNums ?? 0}';
        if (type == SCWarehouseManageType.check) {
          if (model?.status == 0 || model?.status == 1 || model?.status == 2) {
            text = '共 ${model?.materials?.length ?? 0} 种 盘点数量 0';
          } else if (model?.status == 3 || model?.status == 4) {
            text = '共 0/${model?.materials?.length ?? 0}种 盘点数量 0';
            if (model?.materials != null) {
              List<SCMaterialListModel> list = model!.materials!;
              int checkNum = 0;
              int checkCount = 0;
              for (int i = 0; i < list.length; i++) {
                SCMaterialListModel model = list[i];
                if (model.checkNum != null) {
                  checkNum = checkNum + model.checkNum!;
                  checkCount = checkCount + 1;
                }
              }
              text = '共 $checkCount/${list.length}种 盘点数量 $checkNum';
            }
          }
        }
      }
    }
    return Container(
      height: 22.0,
      alignment: Alignment.centerLeft,
      child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_5E5F66
      ),),
    );
  }

  /// 资产维保-统一信息
  Widget propertyMaintenanceUnifyInfoView() {
    bool unifyCompany = model?.unifyMaintenanceCompany ?? false;
    bool unifyContent = model?.unifyMaintenanceContent ?? false;
    return Offstage(
      offstage: type != SCWarehouseManageType.propertyMaintenance,
      child: SCUnifyCompanyDetailView(
        unifyCompany: unifyCompany,
        maintenanceCompany: model?.maintenanceCompany,
        unifyContent: unifyContent,
        maintenanceContent: model?.maintenanceContent,
      )
    );
  }
}