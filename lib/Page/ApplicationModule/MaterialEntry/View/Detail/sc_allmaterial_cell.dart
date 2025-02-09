import 'package:flutter/widgets.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_allmaterial_titleview.dart';
import 'package:smartcommunity/Utils/Date/sc_date_utils.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../MaterialCheck/View/CheckDetail/sc_check_timer_view.dart';
import '../../Controller/sc_material_entry_detail_controller.dart';
import '../../Model/sc_material_assets_details_model.dart';
import '../../Model/sc_material_list_model.dart';
import '../../Model/sc_material_task_detail_model.dart';
import 'sc_allmaterial_listview.dart';
import 'sc_material_unfold_btn.dart';

/// 入库详情-所有物资cell

class SCAllMaterialCell extends StatefulWidget {
  final SCMaterialTaskDetailModel? model;

  /// 类型，type=entry入库详情，type=outbound出库详情
  final SCWarehouseManageType type;

  /// 盘点剩余时间
  final int? remainingTime;
  /// SCMaterialEntryDetailController
  final SCMaterialEntryDetailController state;

  /// 是否是资产
  final bool? isProperty;

  SCAllMaterialCell({Key? key, required this.state,required this.type, this.model, this.remainingTime, this.isProperty}) : super(key: key);

  @override
  SCAllMaterialCellState createState() => SCAllMaterialCellState();
}

class SCAllMaterialCellState extends State<SCAllMaterialCell> {
  /// 是否显示所有的数据
  bool isShowAll = false;

  /// 超过4个折叠显示
  int maxLength = 4;

  @override
  Widget build(BuildContext context) {
    bool hiddenUnfold = true;
    if (widget.isProperty == true) {
      if (widget.model?.assets != null && widget.model!.assets!.length > maxLength) {
        hiddenUnfold = false;
      }
    } else {
      if (widget.model?.materials != null && widget.model!.materials!.length > maxLength) {
        hiddenUnfold = false;
      }
    }
    if (widget.type == SCWarehouseManageType.check || widget.type == SCWarehouseManageType.fixedCheck) {
      hiddenUnfold = true;
    }
    return DecoratedBox(
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          timerView(),
          SCAllMaterialTitleView(type: widget.type, model: widget.model, isProperty: widget.isProperty),
          SCAllMaterialListView(
            list: getRealList(),
            propertyList: getPropertyList(),
            materialAssetsDetails: widget.state.model.materialAssetsDetails,
            isProperty: widget.isProperty,
            type: widget.type,
            status: widget.model?.status,
            onTap: (SCMaterialListModel model, int index) async {
              if (widget.type == SCWarehouseManageType.check) {
                /// 待盘点或盘点中时
                int subStatus = widget.model?.status ?? -1;
                if (subStatus == 1 || subStatus == 2 || subStatus == 3 || subStatus == 4) {
                  var backParams = await SCRouterHelper.pathPage(SCRouterPath.checkMaterialDetailPage, {'model': model});
                  if (backParams != null) {
                    setState(() {
                      model = backParams['model'];
                    });
                  }
                }
              } else if (widget.type == SCWarehouseManageType.fixedCheck) {
                /// 待盘点或盘点中时
                int subStatus = widget.model?.status ?? -1;
                if (subStatus == 3 || subStatus == 4) {
                  List<SCMaterialAssetsDetailsModel> materialAssetsDetails = widget.model?.materialAssetsDetails ?? [];
                  if (materialAssetsDetails.isNotEmpty) {
                    SCMaterialAssetsDetailsModel detailModel = materialAssetsDetails[index];
                    var backParams = await SCRouterHelper.pathPage(SCRouterPath.fixedCheckMaterialDetailPage, {'model': detailModel, 'checkId': widget.state.model.id ?? '', 'name' : model.name, 'unit' : model.unitName, 'norms' : model.norms});
                    if (backParams != null) {
                      var data = backParams['data'];
                      print("vvv===${data}");
                      widget.state.updateFixedList(index, data);
                      // setState(() {
                      //   widget.state.fixedList.ad
                      //   model = backParams['model'];
                      // });
                    }
                  }
                }
              }
            },
          ),
          Offstage(
            offstage: hiddenUnfold,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SCMaterialUnfoldBtn(
                    isUnfold: !isShowAll,
                    onPressed: (bool status) {
                      unfoldAction(status);
                    },
                  ),
                  const SizedBox(
                    height: 12.0,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4.0,
          )
        ],
      ),
    );
  }

  /// 定时器
  Widget timerView() {
    if (widget.type == SCWarehouseManageType.check || widget.type == SCWarehouseManageType.fixedCheck) {
      int status = widget.model?.status ?? -1;
      if (status == 2 || status == 4) {
        if ((widget.remainingTime ?? 0) <= 0) {
          return const SizedBox();
        } else {
          return Padding(padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0), child: SCCheckDetailTimerView(model: widget.model!, remainingTime: widget.remainingTime ?? 0,),);
        }
      } else {
        return const SizedBox();
      }
    } else {
      return const SizedBox();
    }
  }

  /// 数据
  getRealList() {
    if (widget.type == SCWarehouseManageType.fixedCheck) {
      List<SCMaterialAssetsDetailsModel> list = widget.state.model.materialAssetsDetails ?? [];
      List<SCMaterialListModel> newList = [];
      for (SCMaterialAssetsDetailsModel model in list) {
        SCMaterialListModel? subModel = model.materialInfo;
        newList.add(subModel ?? SCMaterialListModel());
      }
      return newList;
    }
    if (widget.type == SCWarehouseManageType.check || widget.type == SCWarehouseManageType.fixedCheck) {
      return widget.state.checkedList;
    } else {
      if (widget.model?.materials != null && widget.model!.materials!.length > maxLength) {
        if (!isShowAll) {
          return widget.model!.materials!.sublist(0, maxLength);
        } else {
          return widget.model!.materials!;
        }
      } else {
        return widget.model?.materials;
      }
    }
  }

  getPropertyList() {
    if (widget.type == SCWarehouseManageType.fixedCheck) {
      List<SCMaterialAssetsDetailsModel> list = widget.state.model.materialAssetsDetails ?? [];
      List<SCMaterialListModel> newList = [];
      for (SCMaterialAssetsDetailsModel model in list) {
        SCMaterialListModel? subModel = model.materialInfo;
        newList.add(subModel ?? SCMaterialListModel());
      }
      return newList;
    }
      if (widget.model?.assets != null && widget.model!.assets!.length > maxLength) {
        if (!isShowAll) {
          return widget.model!.assets!.sublist(0, maxLength);
        } else {
          return widget.model!.assets!;
        }
      } else {
        return widget.model?.assets;
      }
  }

  /// 展开/折叠
  unfoldAction(bool status) {
    setState(() {
      isShowAll = status;
    });
  }
}
