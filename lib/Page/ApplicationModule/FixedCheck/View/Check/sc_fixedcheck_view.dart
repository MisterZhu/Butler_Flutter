import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/FixedCheck/Controller/sc_fixedcheck_controller.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_entry_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_add_entry_button.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_entry_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_search_item.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_sift_item.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../MaterialEntry/Model/sc_material_list_model.dart';
import '../../../MaterialEntry/View/Alert/sc_sift_alert.dart';
import '../../../MaterialEntry/View/Alert/sc_sort_alert.dart';

/// 固定资产盘点view

class SCFixedCheckView extends StatefulWidget {
  /// SCFixedCheckController
  final SCFixedCheckController state;

  SCFixedCheckView({Key? key, required this.state}) : super(key: key);

  @override
  SCFixedCheckViewState createState() => SCFixedCheckViewState();
}

class SCFixedCheckViewState extends State<SCFixedCheckView> {
  List siftList = ['状态', '类型', '排序'];

  List statusList = [
    {'name': '全部', 'code': -1},
    {'name': '未开始', 'code': 0},
    {'name': '待盘点（超时）', 'code': 1},
    {'name': '待盘点', 'code': 2},
    {'name': '盘点中（超时）', 'code': 3},
    {'name': '盘点中', 'code': 4},
    {'name': '已完成（超时）', 'code': 5},
    {'name': '已完成', 'code': 6},
    {'name': '已作废', 'code': 7},
  ];
  List typeList = ['全部'];

  int selectStatus = 0;

  int selectType = 0;

  int sortIndex = 0;

  bool showStatusAlert = false;

  bool showTypeAlert = false;

  bool showSortAlert = false;

  /// RefreshController
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    sortIndex = widget.state.sort == true ? 0 : 1;
    widget.state.loadTypeData(() {
      List list = widget.state.typeList.map((e) => e.name).toList();
      setState(() {
        typeList.addAll(list);
      });
    });
  }

  @override
  dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SCMaterialSearchItem(
          name: '搜索资产名称/操作人',
          searchAction: () {
            SCRouterHelper.pathPage(SCRouterPath.entrySearchPage,
                {'type': SCWarehouseManageType.fixedCheck});
          },
        ),
        SCMaterialSiftItem(
          tagList: siftList,
          tapAction: (index) {
            if (index == 0) {
              setState(() {
                showStatusAlert = !showStatusAlert;
                showTypeAlert = false;
                showSortAlert = false;
              });
            } else if (index == 1) {
              setState(() {
                showStatusAlert = false;
                showTypeAlert = !showTypeAlert;
                showSortAlert = false;
              });
            } else if (index == 2) {
              setState(() {
                showStatusAlert = false;
                showTypeAlert = false;
                showSortAlert = !showSortAlert;
              });
            }
          },
        ),
        Expanded(child: contentItem())
      ],
    );
  }

  /// contentItem
  Widget contentItem() {
    return Stack(
      children: [
        Positioned(left: 0, top: 0, right: 0, bottom: 0, child: listview()),
        Positioned(
          right: 16,
          bottom: SCUtils().getBottomSafeArea() + 40,
          width: 71.0,
          height: 71.0,
          child: addItem(),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          top: 0.0,
          bottom: 0.0,
          child: statusAlert(),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          top: 0.0,
          bottom: 0.0,
          child: typeAlert(),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          top: 0.0,
          bottom: 0.0,
          child: sortAlert(),
        ),
      ],
    );
  }

  /// 新增任务按钮
  Widget addItem() {
    return SCAddEntryButton(
      name: '新增任务',
      tapAction: () {
        SCRouterHelper.pathPage(SCRouterPath.addFixedCheckPage, null);
      },
    );
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
      onRefresh: onRefresh,
      onLoading: loadMore,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            SCMaterialEntryModel model = widget.state.dataList[index];
            return SCMaterialEntryCell(
              model: model,
              type: SCWarehouseManageType.fixedCheck,
              detailTapAction: () {
                detailAction(model);
              },
              btnTapAction: () {
                btnTapAction(model);
              },
              callAction: (String phone) {
                call(phone);
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10.0,
            );
          },
          itemCount: widget.state.dataList.length),
    );
  }

  /// 按钮点击
  btnTapAction(SCMaterialEntryModel model) {
    int status = model.status ?? -1;
    bool canEdit = (status == 0);
    if (status == 0) {
      editAction(model);
    } else {
      SCRouterHelper.pathPage(SCRouterPath.checkDetailPage, {'id': model.id, 'canEdit' : canEdit, 'isFixedCheck': true});
    }
  }

  /// 详情
  detailAction(SCMaterialEntryModel model) {
    int status = model.status ?? -1;
    bool canEdit = (status == 0);
    SCRouterHelper.pathPage(SCRouterPath.checkDetailPage, {'id': model.id, 'canEdit' : canEdit, 'isFixedCheck': true});
  }

  /// 编辑
  editAction(SCMaterialEntryModel model) async {
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
      widget.state.loadData(isMore: false);
    });
  }

  /// 状态弹窗
  Widget statusAlert() {
    List list = [];
    for (int i = 0; i < statusList.length; i++) {
      list.add(statusList[i]['name']);
    }
    return Offstage(
      offstage: !showStatusAlert,
      child: SCSiftAlert(
        title: '任务状态',
        list: list,
        selectIndex: selectStatus,
        closeAction: () {
          setState(() {
            showStatusAlert = false;
          });
        },
        tapAction: (value) {
          if (selectStatus != value) {
            setState(() {
              showStatusAlert = false;
              selectStatus = value;
              siftList[0] = value == 0 ? '状态' : statusList[value]['name'];
              widget.state.updateStatus(statusList[value]['code']);
            });
          }
        },
      ),
    );
  }

  /// 类型弹窗
  Widget typeAlert() {
    return Offstage(
      offstage: !showTypeAlert,
      child: SCSiftAlert(
        title: '任务类型',
        list: typeList,
        selectIndex: selectType,
        closeAction: () {
          setState(() {
            showTypeAlert = false;
          });
        },
        tapAction: (value) {
          if (selectType != value) {
            setState(() {
              showTypeAlert = false;
              selectType = value;
              siftList[1] = value == 0 ? '类型' : typeList[value];
              widget.state.updateType(value == 0
                  ? -1
                  : widget.state.typeList[value - 1].code ?? -1);
            });
          }
        },
      ),
    );
  }

  /// 排序弹窗
  Widget sortAlert() {
    return Offstage(
      offstage: !showSortAlert,
      child: SCSortAlert(
        selectIndex: sortIndex,
        closeAction: () {
          setState(() {
            showSortAlert = false;
          });
        },
        tapAction: (index) {
          if (sortIndex != index) {
            setState(() {
              showSortAlert = false;
              sortIndex = index;
              widget.state.updateSort(index == 0 ? true : false);
            });
          }
        },
      ),
    );
  }

  /// 打电话
  call(String phone) {
    SCUtils.call(phone);
  }

  /// 提交
  submit(int index) {
    SCMaterialEntryModel model = widget.state.dataList[index];
    widget.state.submit(
        id: model.id ?? '',
        completeHandler: (bool success) {
          widget.state.loadData(isMore: false);
        });
  }

  /// 下拉刷新
  Future onRefresh() async {
    widget.state.loadData(
        isMore: false,
        completeHandler: (bool success, bool last) {
          refreshController.refreshCompleted();
          refreshController.loadComplete();
        });
  }

  /// 上拉加载
  void loadMore() async {
    widget.state.loadData(
        isMore: true,
        completeHandler: (bool success, bool last) {
          if (last) {
            refreshController.loadNoData();
          } else {
            refreshController.loadComplete();
          }
        });
  }
}
