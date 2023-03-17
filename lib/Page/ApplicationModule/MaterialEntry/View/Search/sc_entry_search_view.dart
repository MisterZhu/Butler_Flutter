
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../Controller/sc_entry_search_controller.dart';
import '../../Controller/sc_material_entry_controller.dart';
import '../../Model/sc_material_entry_model.dart';
import '../../Model/sc_material_list_model.dart';
import '../MaterialEntry/sc_material_entry_cell.dart';

/// 出入库搜索view

class SCEntrySearchView extends StatefulWidget {

  /// SCEntrySearchController
  final SCEntrySearchController state;

  SCEntrySearchView({Key? key, required this.state}) : super(key: key);

  @override
  SCEntrySearchViewState createState() => SCEntrySearchViewState();
}

class SCEntrySearchViewState extends State<SCEntrySearchView> {

  final TextEditingController controller = TextEditingController();

  final FocusNode node = FocusNode();

  bool showCancel = true;

  /// RefreshController
  RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  initState() {
    super.initState();
    showKeyboard(context);
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// 弹出键盘
  showKeyboard(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100),(){
      node.requestFocus();
    });
  }

  /// body
  Widget body() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerItem(),
          Expanded(child: contentView())
        ]
    );
  }

  /// 搜索
  Widget headerItem() {
    return Container(
      color: SCColors.color_FFFFFF,
      height: 44.0,
      padding: EdgeInsets.only(left: 16.0, right: showCancel ? 0 : 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: searchItem()),
          cancelBtn(),
        ],
      ),
    );
  }

  /// 搜索框
  Widget searchItem() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 30.0,
      decoration: BoxDecoration(
          color: SCColors.color_F2F3F5,
          borderRadius: BorderRadius.circular(15.0)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            SCAsset.iconGreySearch,
            width: 16.0,
            height: 16.0,
          ),
          const SizedBox(
            width: 8.0,
          ),
          textField(),
        ],
      ),
    );
  }

  /// 输入框
  Widget textField() {
    String hintText = widget.state.type == SCWarehouseManageType.fixedCheck ? "搜索资产名称/操作人" : "搜索仓库名称/操作人";
    return Expanded(
        child: TextField(
          controller: controller,
          maxLines: 1,
          cursorColor: SCColors.color_1B1C33,
          cursorWidth: 2,
          focusNode: node,
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_1B1C33),
          keyboardType: TextInputType.text,
          keyboardAppearance: Brightness.light,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 4),
            hintText: hintText,
            hintStyle: const TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w400,
                color: SCColors.color_B0B1B8),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent)),
            disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent)),
            border: const OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent)),
            isCollapsed: true,
          ),
          onChanged: (value) {

          },
          onSubmitted: (value) {
            widget.state.updateSearchString(value);
            widget.state.searchData(isMore: false);
            node.unfocus();
          },
          onTap: () {
            if (!showCancel) {
              setState(() {
                showCancel = true;
              });
            }
          },
        ));
  }

  /// 取消按钮
  Widget cancelBtn() {
    return Offstage(
      offstage: !showCancel,
      child: CupertinoButton(
          minSize: 64.0,
          padding: EdgeInsets.zero,
          child: const Text(
            '取消',
            style: TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w400,
                color: SCColors.color_1B1D33),
          ),
          onPressed: () {
            node.unfocus();
            setState(() {
              showCancel = false;
            });
          }),
    );
  }

  /// contentView
  Widget contentView() {
    if (widget.state.dataList.isNotEmpty) {
      return listview();
    } else {
      return emptyItem();
    }
  }

  /// listview
  Widget listview() {
    return SmartRefresher(
      controller: refreshController,
      enablePullUp: true,
      enablePullDown: true,
      header: const SCCustomHeader(
        style: SCCustomHeaderStyle.noNavigation,
      ),
      onRefresh: onRefresh, onLoading: loadMore, child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          SCMaterialEntryModel model = widget.state.dataList[index];
          return SCMaterialEntryCell(
            model: model,
            type: widget.state.type,
            detailTapAction: () {
              int status = model.status ?? -1;
              bool canEdit = (status == 0);
              if (widget.state.type == SCWarehouseManageType.entry) {
                /// 入库详情
                SCRouterHelper.pathPage(SCRouterPath.entryDetailPage, {'id': model.id, 'canEdit' : canEdit});
              } else if (widget.state.type == SCWarehouseManageType.outbound) {
                /// 出库详情
                SCRouterHelper.pathPage(SCRouterPath.outboundDetailPage, {'id': model.id, 'canEdit': canEdit});
              } else if (widget.state.type == SCWarehouseManageType.frmLoss) {
                /// 报损详情
                SCRouterHelper.pathPage(SCRouterPath.frmLossDetailPage, {'id': model.id, 'canEdit': canEdit});
              } else if (widget.state.type == SCWarehouseManageType.transfer) {
                /// 调拨详情
                SCRouterHelper.pathPage(SCRouterPath.transferDetailPage, {'id': model.id, 'canEdit': canEdit});
              } else if (widget.state.type == SCWarehouseManageType.check) {
                /// 盘点详情
                SCRouterHelper.pathPage(SCRouterPath.checkDetailPage, {'id': model.id, 'canEdit': canEdit});
              } else if (widget.state.type == SCWarehouseManageType.fixedCheck) {
                /// 固定资产盘点详情
                SCRouterHelper.pathPage(SCRouterPath.checkDetailPage, {'id': model.id, 'canEdit' : canEdit, 'isFixedCheck': true});
              }
            },
            btnTapAction: () {
              submit(index);
            },
            callAction: (String phone) {
              call(phone);
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10.0,);
        },
        itemCount: widget.state.dataList.length),);
  }

  /// 无搜索结果
  Widget emptyItem() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 104.0),
      child: Text(
          widget.state.tips,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_8D8E99)),
    );
  }


  /// 提交入库
  submit(int index) {
    SCMaterialEntryModel model = widget.state.dataList[index];
    if (widget.state.type == SCWarehouseManageType.fixedCheck) {
      fixedCheckEditAction(model);
      return;
    } else if (widget.state.type == SCWarehouseManageType.check) {
      checkEditAction(model);
      return;
    }
    SCMaterialEntryController entryController = SCMaterialEntryController();
    entryController.submit(id:model.id ?? '', completeHandler: (bool success){
      if (success) {
        onRefresh();
      }
    });
  }

  /// 盘点编辑
  checkEditAction(SCMaterialEntryModel model) async {
    String wareHouseName = model.wareHouseName ?? '';
    String wareHouseId = model.wareHouseId ?? '';
    String typeName = model.typeName ?? '';
    int type = model.type ?? 0;
    String remark = model.remark ?? '';
    List<SCMaterialListModel> materials = model.materials ?? [];
    String id = model.id ?? '';
    String taskName = model.taskName ?? '';
    String taskStartTime = model.taskStartTime ?? '';
    String taskEndTime = model.taskEndTime ?? '';
    String dealOrgName = model.dealOrgName ?? '';
    String dealOrgId = model.dealOrgId ?? '';
    String dealUserName = model.dealUserName ?? '';
    String dealUserId = model.dealUserId ?? '';
    int rangeValue = model.rangeValue ?? 1;

    for (SCMaterialListModel model in materials) {
      model.localNum = model.number ?? 1;
      model.isSelect = true;
      model.name = model.materialName ?? '';
    }
    var params = {
      'isEdit': true,
      'data': materials,
      "wareHouseName": wareHouseName,
      "wareHouseId": wareHouseId,
      "typeName": typeName,
      "type": type,
      "remark": remark,
      "id": id,
      "taskName": taskName,
      "startTime": taskStartTime,
      "endTime": taskEndTime,
      "dealOrgName": dealOrgName,
      "dealOrgId": dealOrgId,
      "dealUserName": dealUserName,
      "dealUserId": dealUserId,
      "rangeValue": rangeValue
    };
    SCRouterHelper.pathPage(SCRouterPath.addCheckPage, params)?.then((value) {
      onRefresh();
    });
  }

  /// 固定资产编辑
  fixedCheckEditAction(SCMaterialEntryModel model) async {
    String wareHouseName = model.wareHouseName ?? '';
    String wareHouseId = model.wareHouseId ?? '';
    String typeName = model.typeName ?? '';
    int type = model.type ?? 0;
    String remark = model.remark ?? '';
    List<SCMaterialListModel> materials = model.materials ?? [];
    String id = model.id ?? '';
    String taskName = model.taskName ?? '';
    String taskStartTime = model.taskStartTime ?? '';
    String taskEndTime = model.taskEndTime ?? '';
    String orgName = model.dealOrgName ?? '';
    String orgId = model.dealOrgId ?? '';
    String dealUserName = model.dealUserName ?? '';
    String dealUserId = model.dealUserId ?? '';
    int rangeValue = model.rangeValue ?? 1;

    for (SCMaterialListModel model in materials) {
      model.localNum = model.number ?? 1;
      model.isSelect = true;
      model.name = model.materialName ?? '';
    }
    var params = {
      'isEdit': true,
      'data': materials,
      "wareHouseName": wareHouseName,
      "wareHouseId": wareHouseId,
      "typeName": typeName,
      "type": type,
      "remark": remark,
      "id": id,
      "taskName": taskName,
      "startTime": taskStartTime,
      "endTime": taskEndTime,
      "dealOrgName": orgName,
      "dealOrgId": orgId,
      "dealUserName": dealUserName,
      "dealUserId": dealUserId,
      "rangeValue": rangeValue
    };
    SCRouterHelper.pathPage(SCRouterPath.addFixedCheckPage, params)?.then((value) {
      onRefresh();
    });
  }

  /// 下拉刷新
  Future onRefresh() async {
    widget.state.searchData(isMore: false, completeHandler: (bool success, bool last){
      refreshController.refreshCompleted();
      refreshController.loadComplete();
    });
  }

  /// 上拉加载
  void loadMore() async{
    widget.state.searchData(isMore: true, completeHandler: (bool success, bool last){
      if (last) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    });
  }

  @override
  dispose() {
    super.dispose();
    controller.dispose();
    node.dispose();
  }

  /// 打电话
  call(String phone) {
    SCUtils.call(phone);
  }
}