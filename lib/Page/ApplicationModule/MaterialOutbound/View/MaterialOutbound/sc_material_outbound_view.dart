
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_entry_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_entry_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_search_item.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_sift_item.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../MaterialEntry/View/Alert/sc_sift_alert.dart';
import '../../../MaterialEntry/View/Alert/sc_sort_alert.dart';
import '../../Controller/sc_material_outbound_controller.dart';


/// 物资出库view

class SCMaterialOutboundView extends StatefulWidget {

  /// SCMaterialOutboundController
  final SCMaterialOutboundController state;

  SCMaterialOutboundView({Key? key, required this.state}) : super(key: key);

  @override
  SCMaterialOutboundViewState createState() => SCMaterialOutboundViewState();
}

class SCMaterialOutboundViewState extends State<SCMaterialOutboundView> {

  List siftList =  ['状态', '类型', '排序'];

  List statusList = [
    {'name': '全部', 'code': -1},
    {'name': '待提交', 'code': 0},
    {'name': '待审批', 'code': 1},
    {'name': '审批中', 'code': 2},
    {'name': '已拒绝', 'code': 3},
    {'name': '已驳回', 'code': 4},
    {'name': '已撤回', 'code': 5},
    {'name': '已通过', 'code': 6},
    {'name': '已审批', 'code': 7},
  ];
  List typeList = ['全部'];

  int selectStatus = 0;

  int selectType = 0;

  int sortIndex = 0;

  bool showStatusAlert = false;

  bool showTypeAlert = false;

  bool showSortAlert = false;

  /// RefreshController
  RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    sortIndex = widget.state.sort == true ? 0 : 1;
    widget.state.loadOutboundType(() {
      List list = widget.state.outboundList.map((e) => e.name).toList();
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
        SCMaterialSearchItem(name: '搜索仓库名称', searchAction: () {
          SCRouterHelper.pathPage(SCRouterPath.entrySearchPage, {'type': 1});
        },),
        SCMaterialSiftItem(tagList:siftList, tapAction: (index) {
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
        },),
        Expanded(child: contentItem())
      ],
    );
  }

  /// contentItem
  Widget contentItem() {
    return Stack(
      children: [
        Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: listview()),
        Positioned(
          right: 16,
          bottom: SCUtils().getBottomSafeArea() + 40,
          width: 60.0,
          height: 60.0,
          child: addItem(),),
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

  /// 新增出库按钮
  Widget addItem() {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: SCColors.color_E3E3E5, width: 0.5)
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          SCRouterHelper.pathPage(SCRouterPath.addOutboundPage, null);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(SCAsset.iconAddReceipt, width: 20.0, height: 20.0,),
            const SizedBox(width: 2.0,),
            const Text(
                '新增出库',
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SCFonts.f11,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_1B1D33)),
          ],
        ),
      ),
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
      onRefresh: onRefresh, onLoading: loadMore, child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          SCMaterialEntryModel model = widget.state.dataList[index];
          return SCMaterialEntryCell(
            type: 1,
            model: model,
            detailTapAction: () {
              /// 详情
              detailAction(model);
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
        itemCount: widget.state.dataList.length));
  }

  /// 详情
  detailAction(SCMaterialEntryModel model) {
    int status = model.status ?? -1;
    bool canEdit = (status == 0);
    SCRouterHelper.pathPage(SCRouterPath.outboundDetailPage, {'id': model.id, 'canEdit': canEdit});
  }

  /// 出库状态弹窗
  Widget statusAlert() {
    List list = [];
    for (int i = 0; i < statusList.length; i++) {
      list.add(statusList[i]['name']);
    }
    return Offstage(
      offstage: !showStatusAlert,
      child: SCSiftAlert(
        title: '出库状态',
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
        },),
    );
  }

  /// 出库类型弹窗
  Widget typeAlert() {
    return Offstage(
      offstage: !showTypeAlert,
      child: SCSiftAlert(
        title: '出库类型',
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
              widget.state.updateType(value == 0 ? -1 : widget.state.outboundList[value - 1].code ?? -1);
            });
          }
        },),
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
        },),
    );
  }

  /// 打电话
  call(String phone) {
    SCUtils.call(phone);
  }

  /// 提交
  submit(int index) {
    SCMaterialEntryModel model = widget.state.dataList[index];
    widget.state.submit(id: model.id ?? '', completeHandler: (bool success){
      widget.state.loadOutboundListData(isMore: false);
    });
  }

  /// 下拉刷新
  Future onRefresh() async {
    widget.state.loadOutboundListData(isMore: false, completeHandler: (bool success, bool last){
      refreshController.refreshCompleted();
      refreshController.loadComplete();
    });
  }

  /// 上拉加载
  void loadMore() async{
    widget.state.loadOutboundListData(isMore: true, completeHandler: (bool success, bool last){
      if (last) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    });
  }

}
