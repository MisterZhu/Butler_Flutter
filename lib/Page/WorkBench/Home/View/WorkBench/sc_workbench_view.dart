import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/WorkBench/Home/GetXController/sc_wrokbench_listview_controller.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_hotel_order_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_verification_order_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_work_order_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Hotel/sc_hotel_listview.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Material/sc_workbench_material_listview.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/PageView/sc_workbench_listview.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/RealVerification/sc_realverification_listview.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

import '../../../../../Constants/sc_enum.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../ApplicationModule/MaterialEntry/Model/sc_material_entry_model.dart';
import '../../GetXController/sc_workbench_controller.dart';
import '../AppBar/sc_workbench_header.dart';
import '../PageView/sc_workbench_empty_view.dart';

/// 工作台-view

class SCWorkBenchView extends StatelessWidget {
  SCWorkBenchView(
      {Key? key,
      required this.state,
      required this.waitController,
      required this.doingController,
      required this.height,
      required this.tabController,
      required this.tabTitleList,
      required this.classificationList,
      this.tagAction,
      this.menuTap,
      this.onRefreshAction,
      this.detailAction,
      this.verificationDetailAction,
      this.hotelOrderDetailAction,
      this.showSpaceAlert,
      this.scanAction,
      this.messageAction,
      this.cardDetailAction,
      this.headerAction})
      : super(key: key);

  /// 工作台controller
  final SCWorkBenchController state;

  /// 待处理controller
  final SCWorkBenchListViewController waitController;

  /// 处理中controller
  final SCWorkBenchListViewController doingController;

  /// 组件高度
  final double height;

  /// tabController
  final TabController tabController;

  /// tab标题list
  final List tabTitleList;

  /// 分类list
  final List classificationList;

  /// 点击菜单
  final Function? menuTap;

  /// 点击标签
  final Function(int index)? tagAction;

  /// 详情
  final Function(SCWorkOrderModel model)? detailAction;

  /// 实地核验详情
  final Function(SCVerificationOrderModel model)? verificationDetailAction;

  /// 酒店订单处理详情
  final Function(SCHotelOrderModel model)? hotelOrderDetailAction;

  /// 下拉刷新
  final Function? onRefreshAction;

  /// 显示空间弹窗
  final Function? showSpaceAlert;

  /// 扫一扫
  final Function? scanAction;

  /// 消息详情
  final Function? messageAction;

  /// 卡片详情
  final Function(int index)? cardDetailAction;

  /// 点击头像
  final Function? headerAction;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
        enableScrollWhenRefreshCompleted: true,
        child: SmartRefresher(
          controller: refreshController,
          enablePullUp: false,
          enablePullDown: true,
          header: const SCCustomHeader(
            style: SCCustomHeaderStyle.noNavigation,
          ),
          onRefresh: onRefresh,
          child: listView(),
        ));
  }

  /// listView
  Widget listView() {
    // double headerHeight = 305.0 + SCUtils().getTopSafeArea();
    double headerHeight = 255.0 + SCUtils().getTopSafeArea();
    double contentHeight = height - headerHeight;
    return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return SCStickyHeader(
              header: headerView(headerHeight, context),
              content: pageView(contentHeight));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox();
        },
        itemCount: 1);
  }

  /// header
  Widget headerView(double height, BuildContext context) {
    return SCWorkBenchHeader(
      state: state,
      height: height,
      tabTitleList: tabTitleList,
      classificationList: classificationList,
      tabController: tabController,
      currentTabIndex: state.currentWorkOrderIndex,
      currentTagIndex: state.currentPlateIndex,
      tagAction: (index) {
        tagAction?.call(index);
      },
      tagMenuAction: () {
        menuTap?.call();
      },
      switchSpaceAction: () {
        switchAction(context);
      },
      scanAction: () {
        scanAction?.call();
      },
      messageAction: () {
        messageAction?.call();
      },
      cardDetailAction: (int index) {
        cardDetailAction?.call(index);
      },
      headerAction: () {
        headerAction?.call();
      },
    );
  }

  /// pageView
  Widget pageView(double height) {
    Widget tabBarView = SizedBox(
      height: height,
      child: TabBarView(controller: tabController, children: [
        GetBuilder<SCWorkBenchListViewController>(
            tag: waitController.tag,
            init: waitController,
            builder: (value) {
              if (state.currentPlateIndex == 0) {
                // 工单处理
                return SCWorkBenchListView(
                  state: state,
                  dataList: waitController.dataList,
                  detailAction: (SCWorkOrderModel model) {
                    detail(model);
                  },
                  callAction: (String phone) {
                    SCUtils.call(phone);
                  },
                );
              } else if (state.currentPlateIndex == 1) {
                // 实地核验
                return SCRealVerificationListView(
                  state: state,
                  dataList: waitController.dataList,
                  callAction: (phone) {
                    callAction(phone);
                  },
                  doneAction: (SCVerificationOrderModel model) {
                    verificationDoneAction(model);
                  },
                );
              } else if (state.currentPlateIndex == 2) {
                // 订单处理
                return SCHotelListView(
                  state: state,
                  dataList: waitController.dataList,
                  callAction: (phone) {
                    callAction(phone);
                  },
                  doneAction: (SCHotelOrderModel model) {
                    hotelOrderDoneAction(model);
                  },
                );
              } else if (state.currentPlateIndex >= 3 &&
                  state.currentPlateIndex <= 6) {
                // 物资入库、物资出库、物资报损、物资调拨
                List<SCMaterialEntryModel> list = [];
                SCWarehouseManageType type = SCWarehouseManageType.entry;
                bool isLast = false;
                if (state.currentPlateIndex == 3) {
                  // 物资入库
                  list = waitController.materialEntryList;
                  type = SCWarehouseManageType.entry;
                  isLast = waitController.isEntryListLast;
                } else if (state.currentPlateIndex == 4) {
                  // 物资出库
                  list = waitController.materialOutList;
                  type = SCWarehouseManageType.outbound;
                } else if (state.currentPlateIndex == 5) {
                  // 物资报损
                  list = waitController.materialReportList;
                  type = SCWarehouseManageType.frmLoss;
                } else if (state.currentPlateIndex == 6) {
                  // 物资调拨
                  list = waitController.materialTransferList;
                  type = SCWarehouseManageType.transfer;
                } else {
                  // 其他
                  list = [];
                  type = SCWarehouseManageType.entry;
                }
                return SCWorkBenchMaterialListView(
                  dataList: list,
                  state: state,
                  isLast: isLast,
                  type: type,
                  callAction: (phone) {
                    callAction(phone);
                  },
                  detailAction: (subModel) {
                    wareHouseDetail(subModel, type);
                  },
                  submitAction: (subModel) {
                    materialSubmit(subModel, type);
                  },
                );
              } else {
                return const SizedBox();
              }
            }),
        GetBuilder<SCWorkBenchListViewController>(
            tag: doingController.tag,
            init: doingController,
            builder: (value) {
              if (state.currentPlateIndex == 0) {
                // 工单处理
                return SCWorkBenchListView(
                  state: state,
                  dataList: doingController.dataList,
                  detailAction: (SCWorkOrderModel model) {
                    detail(model);
                  },
                  callAction: (String phone) {
                    callAction(phone);
                  },
                );
              } else if (state.currentPlateIndex == 1) {
                // 实地核验
                return SCRealVerificationListView(
                  state: state,
                  dataList: doingController.dataList,
                  callAction: (phone) {
                    callAction(phone);
                  },
                  doneAction: (SCVerificationOrderModel model) {
                    verificationDoneAction(model);
                  },
                );
              } else if (state.currentPlateIndex == 2) {
                // 订单处理
                return SCHotelListView(
                  state: state,
                  dataList: doingController.dataList,
                  callAction: (phone) {
                    callAction(phone);
                  },
                  doneAction: (SCHotelOrderModel model) {
                    hotelOrderDoneAction(model);
                  },
                );
              } else if (state.currentPlateIndex >= 3 &&
                  state.currentPlateIndex <= 6) {
                // 物资入库、物资出库、物资报损、物资调拨
                return SCWorkBenchEmptyView();
              } else {
                return const SizedBox();
              }
            }),
      ]),
    );
    return tabBarView;
  }

  /// 下拉刷新
  Future onRefresh() async {
    Future.delayed(const Duration(milliseconds: 1500), () {
      refreshController.refreshCompleted();
      onRefreshAction?.call();
    });
  }

  /// 切换空间
  switchAction(BuildContext context) {
    showSpaceAlert?.call();
  }

  /// 详情
  detail(SCWorkOrderModel model) {
    detailAction?.call(model);
  }

  /// 打电话
  callAction(String phone) {
    SCUtils.call(phone);
  }

  /// 实地核验完成
  verificationDoneAction(SCVerificationOrderModel model) {
    verificationDetailAction?.call(model);
  }

  /// 订单处理完成
  hotelOrderDoneAction(SCHotelOrderModel model) {
    hotelOrderDetailAction?.call(model);
  }

  /// 仓库详情
  wareHouseDetail(SCMaterialEntryModel model, SCWarehouseManageType type) {
    if (type == SCWarehouseManageType.entry) {
      // 物资入库
      int status = model.status ?? -1;
      SCRouterHelper.pathPage(SCRouterPath.entryDetailPage,
          {'id': model.id, 'canEdit': false, 'status': status});
    } else if (type == SCWarehouseManageType.outbound) {
      // 物资出库
      SCRouterHelper.pathPage(
          SCRouterPath.outboundDetailPage, {'id': model.id, 'canEdit': false});
    } else if (type == SCWarehouseManageType.frmLoss) {
      // 物资报损
      SCRouterHelper.pathPage(
          SCRouterPath.frmLossDetailPage, {'id': model.id, 'canEdit': false});
    } else if (type == SCWarehouseManageType.transfer) {
      // 物资调拨
      SCRouterHelper.pathPage(
          SCRouterPath.transferDetailPage, {'id': model.id, 'canEdit': false});
    } else {
      // 其他

    }
  }

  /// 物资提交
  materialSubmit(SCMaterialEntryModel model, SCWarehouseManageType type) {
    if (type == SCWarehouseManageType.entry) {
      // 物资入库
      state.materialEntrySubmit(
          id: model.id ?? '',
          completeHandler: (success) {
            state.getMaterialEntryWaitList(isMore: false);
          });
    } else if (type == SCWarehouseManageType.outbound) {
      // 物资出库
      state.materialOutSubmit(
          id: model.id ?? '',
          completeHandler: (success) {
            state.getMaterialOutWaitList(isMore: false);
          });
    } else if (type == SCWarehouseManageType.frmLoss) {
      // 物资报损
      state.materialFrmLossSubmit(
          id: model.id ?? '',
          completeHandler: (success) {
            state.getMaterialFrmLossWaitList(isMore: false);
          });
    } else if (type == SCWarehouseManageType.transfer) {
      // 物资调拨
      state.materialTransferSubmit(
          id: model.id ?? '',
          completeHandler: (success) {
            state.getMaterialTransferWaitList(isMore: false);
          });
    } else {
      // 其他

    }
  }
}
