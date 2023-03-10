import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_entry_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_add_entry_button.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_entry_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_search_item.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_sift_item.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../MaterialEntry/View/Alert/sc_sift_alert.dart';
import '../../MaterialEntry/View/Alert/sc_sort_alert.dart';
import '../Controller/sc_material_requisition_controller.dart';

/// 物资入库view

class SCMaterialRequisitionView extends StatefulWidget {
  /// SCMaterialRequisitionController
  final SCMaterialRequisitionController state;

  SCMaterialRequisitionView({Key? key, required this.state}) : super(key: key);

  @override
  SCMaterialRequisitionViewState createState() => SCMaterialRequisitionViewState();
}

class SCMaterialRequisitionViewState extends State<SCMaterialRequisitionView> {
  List siftList = ['状态', '排序'];

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
    return Stack(
      children: [
        Positioned(left: 0, top: 0, right: 0, bottom: 0, child: contentItem()),
        Positioned(
          left: 0.0,
          right: 0.0,
          top: 44.0,
          bottom: 0.0,
          child: statusAlert(),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          top: 44.0,
          bottom: 0.0,
          child: sortAlert(),
        ),
      ],
    );
  }


  /// contentItem
  Widget contentItem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SCMaterialSearchItem(
        //   name: '搜索仓库名称/操作人',
        //   searchAction: () {
        //     SCRouterHelper.pathPage(SCRouterPath.entrySearchPage,
        //         {'type': SCWarehouseManageType.entry});
        //   },
        // ),
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
                showTypeAlert = false;
                showSortAlert = !showSortAlert;
              });
            }
          },
        ),
        topCategoryView(),
        Expanded(child: listview())
      ],
    );
  }

  /// 新增入库按钮
  Widget addItem() {
    return SCAddEntryButton(
      name: '新增入库',
      tapAction: () {
        SCRouterHelper.pathPage(SCRouterPath.addEntryPage, null);
      },
    );
  }

  /// 分类
  Widget topCategoryView() {
    List list = ['物资申领', '物资归还'];
    return Padding(padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0, bottom: 10.0), child: Row(
      children: [
        categoryBtn(widget.state.categoryIndex == 0, list[0], () {
          if (widget.state.categoryIndex != 0) {
            //setState(() {
              showStatusAlert = false;
              selectStatus = 0;
              siftList[0] = '状态';
            //});
            widget.state.updateCategoryIndex(0);
            widget.state.update();
          }
        }),
        const SizedBox(width: 13.0,),
        categoryBtn(widget.state.categoryIndex == 1, list[1], () {
          if (widget.state.categoryIndex != 1) {
            //setState(() {
              showStatusAlert = false;
              selectStatus = 0;
              siftList[0] = '状态';
            //});
            widget.state.updateCategoryIndex(1);
            widget.state.update();
          }
        }),
      ],
    ),);
  }

  /// 分类按钮
  Widget categoryBtn(bool isSelect, String title, Function sure) {
    return Container(
      width: 84.0,
      height: 26.0,
      decoration: BoxDecoration(
        color: isSelect ? SCColors.color_EBF2FF : SCColors.color_EDEDF0,
        borderRadius: BorderRadius.circular(13.0),
        border: Border.all(width: 0.5, color: isSelect ? SCColors.color_4285F4 : Colors.transparent)
      ),
      child: CupertinoButton(
        minSize: 26.0,
        padding: EdgeInsets.zero,
          child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(
        fontSize: SCFonts.f14,
        fontWeight: FontWeight.w400,
        color: isSelect ? SCColors.color_4285F4 : SCColors.color_5E5F66
      ),), onPressed: (){
        sure.call();
      }),
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
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 14.0),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            SCMaterialEntryModel model = widget.state.dataList[index];
            bool hideBtn = true;
            if (widget.state.categoryIndex == 0 && model.status == 7) {
              hideBtn = false;
            }
            return SCMaterialEntryCell(
              model: model,
              type: widget.state.categoryIndex == 0 ? SCWarehouseManageType.outbound : SCWarehouseManageType.entry,
              hideBtn: hideBtn,
              btnText: '归还',
              detailTapAction: () {
                detailAction(model);
              },
              callAction: (String phone) {
                call(phone);
              },
              btnTapAction: () {
                SCRouterHelper.pathPage(SCRouterPath.addEntryPage, {'orderId': widget.state.orderId, 'entryModel': model, 'isReturnEntry': true});
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

  /// 详情
  detailAction(SCMaterialEntryModel model) {
    int status = model.status ?? -1;
    bool canEdit = (status == 0);
    print("status===$status");
    if (widget.state.categoryIndex == 0) {
      SCRouterHelper.pathPage(SCRouterPath.outboundDetailPage, {'id': model.id, 'canEdit': canEdit, 'status' : status, 'hideBottomBtn' : true});
    } else {
      SCRouterHelper.pathPage(SCRouterPath.entryDetailPage, {'id': model.id, 'canEdit': canEdit, 'status' : status, 'hideBottomBtn' : true});
    }
  }

  /// 状态弹窗
  Widget statusAlert() {
    List list = [];
    for (int i = 0; i < widget.state.statusList.length; i++) {
      list.add(widget.state.statusList[i]['name']);
    }
    return Offstage(
      offstage: !showStatusAlert,
      child: SCSiftAlert(
        title: '状态',
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
              siftList[0] = value == 0 ? '状态' : widget.state.statusList[value]['name'];
              widget.state.updateStatus(widget.state.statusList[value]['code']);
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
          //widget.state.loadData(isMore: false);
        });
  }

  /// 下拉刷新
  Future onRefresh() async {
    if (widget.state.categoryIndex == 0) {
      widget.state.loadOutboundData(
          isMore: false,
          completeHandler: (bool success, bool last) {
            refreshController.refreshCompleted();
            refreshController.loadComplete();
          });
    } else {
      widget.state.loadEntryData(
          isMore: false,
          completeHandler: (bool success, bool last) {
            refreshController.refreshCompleted();
            refreshController.loadComplete();
          });
    }

  }

  /// 上拉加载
  void loadMore() async {
    if (widget.state.categoryIndex == 0) {
      widget.state.loadOutboundData(
          isMore: true,
          completeHandler: (bool success, bool last) {
            if (last) {
              refreshController.loadNoData();
            } else {
              refreshController.loadComplete();
            }
          });
    } else {
      widget.state.loadEntryData(
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
}
