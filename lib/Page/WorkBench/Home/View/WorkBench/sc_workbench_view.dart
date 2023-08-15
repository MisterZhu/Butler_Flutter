import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_hotel_order_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_verification_order_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_work_order_model.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../../Delegate/sc_sticky_tabbar_delegate.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../ApplicationModule/MaterialEntry/Model/sc_material_entry_model.dart';
import '../../GetXController/sc_workbench_controller.dart';
import '../AppBar/sc_workbench_card.dart';
import '../AppBar/sc_workbench_header.dart';

/// 工作台-view

class SCWorkBenchView extends StatelessWidget {
  SCWorkBenchView({
    Key? key,
    required this.state,
    required this.height,
    required this.tabController,
    required this.tabTitleList,
    this.tagAction,
    this.menuTap,
    this.detailAction,
    this.cardTimeAction,
    this.verificationDetailAction,
    this.hotelOrderDetailAction,
    this.showSpaceAlert,
    this.scanAction,
    this.messageAction,
    this.cardDetailAction,
    this.headerAction,
    this.searchAction,
    this.siftAction,
  }) : super(key: key);

  /// 工作台controller
  final SCWorkBenchController state;

  /// 组件高度
  final double height;

  /// tabController
  final TabController tabController;

  /// tab标题list
  final List tabTitleList;

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

  /// 显示空间弹窗
  final Function? showSpaceAlert;

  /// 扫一扫
  final Function? scanAction;

  /// 消息详情
  final Function? messageAction;

  /// 卡片详情
  final Function(int index)? cardDetailAction;

  /// 卡片时间筛选
  final Function()? cardTimeAction;

  /// 点击头像
  final Function? headerAction;

  /// 点击搜索
  final Function? searchAction;

  /// 点击筛选
  final Function? siftAction;

  @override
  Widget build(BuildContext context) {
    return listView();
  }

  /// listView
  Widget listView() {
    double headerHeight = 44.0;
    double contentHeight = height - headerHeight;
    return ExtendedNestedScrollView(
        controller: ScrollController(),
        onlyOneScrollInBody: true,
        pinnedHeaderSliverHeightBuilder: () {
          return headerHeight;
        },
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[scrollHeader(), stickyTabBar(headerHeight)];
        },
        body: pageView(contentHeight));
  }

  Widget scrollHeader() {
    return SliverToBoxAdapter(
      child: SCWorkBenchCard(
        data: state.numDataList,
        timeTypeTitle: state.selectTimeTypeList.first,
        onTap: (int index) {
          cardDetailAction?.call(index);
        },
        /// 卡片时间筛选
        downOnTap: (){
          cardTimeAction?.call();
        },
      ),
    );
  }

  /// tabBar
  Widget stickyTabBar(double height) {
    return SliverPersistentHeader(
        pinned: true,
        floating: false,
        delegate:
            SCStickyTabBarDelegate(child: headerView(height), height: height));
  }

  /// header
  Widget headerView(double height) {
    return SCWorkBenchHeader(
      state: state,
      height: height,
      tabTitleList: tabTitleList,
      tabController: tabController,
      currentTabIndex: state.currentWorkOrderIndex,
      switchSpaceAction: () {
        // switchAction(context);
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
      searchAction: () {
        searchAction?.call();
      },
      siftAction: () {
        siftAction?.call();
      },
    );
  }

  /// pageView
  Widget pageView(double height) {
    Widget tabBarView = SizedBox(
      height: height,
      child:
          TabBarView(controller: tabController, children: state.tabBarViewList),
    );
    return tabBarView;
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
    // if (type == SCWarehouseManageType.entry) {
    //   // 物资入库
    //   state.materialEntrySubmit(
    //       id: model.id ?? '',
    //       completeHandler: (success) {
    //         state.getMaterialEntryWaitList(isMore: false);
    //       });
    // } else if (type == SCWarehouseManageType.outbound) {
    //   // 物资出库
    //   state.materialOutSubmit(
    //       id: model.id ?? '',
    //       completeHandler: (success) {
    //         state.getMaterialOutWaitList(isMore: false);
    //       });
    // } else if (type == SCWarehouseManageType.frmLoss) {
    //   // 物资报损
    //   state.materialFrmLossSubmit(
    //       id: model.id ?? '',
    //       completeHandler: (success) {
    //         state.getMaterialFrmLossWaitList(isMore: false);
    //       });
    // } else if (type == SCWarehouseManageType.transfer) {
    //   // 物资调拨
    //   state.materialTransferSubmit(
    //       id: model.id ?? '',
    //       completeHandler: (success) {
    //         state.getMaterialTransferWaitList(isMore: false);
    //       });
    // } else {
    //   // 其他
    //
    // }
  }
}
