
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_search_item.dart';
import 'package:smartcommunity/Page/ApplicationModule/OnlineMonitor/Model/sc_select_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/OnlineMonitor/View/sc_monitor_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/OnlineMonitor/View/sc_monitor_sift_alert.dart';
import 'package:smartcommunity/Page/ApplicationModule/OnlineMonitor/View/sc_select_listview.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../Constants/sc_asset.dart';
import '../../../../Utils/sc_utils.dart';
import '../Controller/sc_online_monitor_controller.dart';
import '../Model/sc_monitor_list_model.dart';

/// 在线监控view

class SCOnlineMonitorView extends StatefulWidget {
  /// SCOnlineMonitorController
  final SCOnlineMonitorController state;

  SCOnlineMonitorView({Key? key, required this.state}) : super(key: key);

  @override
  SCOnlineMonitorViewState createState() => SCOnlineMonitorViewState();
}

class SCOnlineMonitorViewState extends State<SCOnlineMonitorView> {

  int selectStatusIndex = 0;

  bool showStatusAlert = false;

  List<SCSelectModel> statusList = [];

  /// RefreshController
  RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    List list = [{'id': 0, 'name': '全部'}, {'id': 1, 'name': '在线'}, {'id': 2, 'name': '离线'}];
    statusList = list.map((e) => SCSelectModel.fromJson(e)).toList();
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
          name: '搜索摄像头名称',
          searchAction: () {
            SCRouterHelper.pathPage(SCRouterPath.monitorSearchPage, null);
          },
        ),
        siftItem(),
        Expanded(child: contentItem())
      ],
    );
  }

  /// 筛选
  Widget siftItem() {
    return Container(
      width: double.infinity,
      height: 40.0,
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          statusItem(),
          GestureDetector(
            onTap: () {
              if (showStatusAlert == true) {
                setState(() {
                  showStatusAlert = false;
                });
              }
              showSiftAlert();
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 52,
              height: 40.0,
              alignment: Alignment.center,
              child: Image.asset(SCAsset.iconMonitorStatusSift, fit: BoxFit.cover, width: 20.0, height: 20.0,),
            ),
          )
        ],
      ),
    );
  }

  /// 状态item
  Widget statusItem() {
    return GestureDetector(
      onTap: () {
        setState(() {
          showStatusAlert = !showStatusAlert;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 60.0,
        height: 40.0,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                statusList[selectStatusIndex].name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_1B1D33)),
            const SizedBox(width: 4.0,),
            Image.asset(SCAsset.iconMaterialArrowDown, width: 14.0, height: 14.0,),
          ],
        ),
      ),
    );
  }

  /// contentItem
  Widget contentItem() {
    return Stack(
      children: [
        Positioned(left: 0, top: 0, right: 0, bottom: 0, child: view()),
        Positioned(
          left: 0.0,
          right: 0.0,
          top: 0.0,
          bottom: 0.0,
          child: statusAlert(),
        ),
      ],
    );
  }

  /// view
  Widget view() {
    return SmartRefresher(
      controller: refreshController,
      enablePullUp: true,
      enablePullDown: true,
      header: const SCCustomHeader(
        style: SCCustomHeaderStyle.noNavigation,
      ),
      onRefresh: onRefresh,
      onLoading: loadMore,
      child: widget.state.dataList.isNotEmpty ? gridView() : emptyView()
    );
  }

  /// gridView
  Widget gridView() {
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        crossAxisCount: 2,
        shrinkWrap: true,
        itemCount: widget.state.dataList.length,
        itemBuilder: (context, index) {
          SCMonitorListModel model = widget.state.dataList[index];
          return SCMonitorCell(
            model: model,
            onTapAction: () {
              detailAction(model);
            },
          );
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

  /// 空白列表占位图
  Widget emptyView() {
    if (widget.state.loadDone == true) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 124.0,),
            Image.asset(SCAsset.iconMonitorEmptyDefault, width: 120.0, height: 120.0, fit: BoxFit.cover,),
            const SizedBox(height: 2.0,),
            const Text(
                '暂无监控记录',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_8D8E99)),
          ]
      );
    } else {
      return const SizedBox();
    }
  }

  /// 详情
  detailAction(SCMonitorListModel model) {
    widget.state.getMonitorPlayUrl(id: '${model.id}', completeHandler: (String url) {
      var params = {'title' : model.cameraName, 'url' : url};
      if (url.isNotEmpty && url != '') {
        SCRouterHelper.pathPage(SCRouterPath.webViewPath, params);
      }
    });
  }

  /// 筛选状态弹窗
  Widget statusAlert() {
    return Offstage(
      offstage: !showStatusAlert,
      child: Container(
        color: SCColors.color_000000.withOpacity(0.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SCSelectListView(
              list: statusList,
              selectId: selectStatusIndex,
              tapAction: (index) {
                if (selectStatusIndex != index) {
                  setState(() {
                    showStatusAlert = false;
                    selectStatusIndex = index;
                    widget.state.updateStatus(index);
                  });
                }
              },
            ),
            Expanded(child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    showStatusAlert = false;
                  });
                },
                child: Container(color: Colors.transparent,)),
            )
          ],
        ),
      )
    );
  }

  /// 筛选名称弹窗
  showSiftAlert() {
    widget.state.getSpaceData(isSearch: false, completeHandler: (status) {
      if (status == true) {
        SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
          SCDialogUtils().showCustomBottomDialog(
              isDismissible: true,
              context: context,
              widget: SCMonitorSiftAlert(
                monitorController: widget.state,
                selectId: widget.state.selectSpaceId,
                originalLength: widget.state.originalLength,
                tapAction: (id) {
                  widget.state.selectSpaceId = id;
                  widget.state.loadData(isMore: false);
                  Navigator.of(context).pop();
                },
              ));
        });
      }
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
