
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_entry_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_search_item.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_sift_item.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../Controller/sc_material_entry_controller.dart';
import '../../Model/sc_material_entry_model.dart';
import '../Alert/sc_sift_alert.dart';
import '../Alert/sc_sort_alert.dart';

/// 物资入库view

class SCMaterialEntryView extends StatefulWidget {

  /// SCMaterialEntryController
  final SCMaterialEntryController state;

  SCMaterialEntryView({Key? key, required this.state}) : super(key: key);

  @override
  SCMaterialEntryViewState createState() => SCMaterialEntryViewState();
}

class SCMaterialEntryViewState extends State<SCMaterialEntryView> {

  List siftList =  ['状态', '类型', '排序'];

  List statusList = ['全部', '待提交', '审批中', '已拒绝', '已驳回', '已撤回', '已入库'];

  List typeList = ['全部', '采购入库', '调拨入库', '盘盈入库', '领料归还入库', '借用归还入库', '退货入库', '其他入库'];

  int selectStatus = 0;

  int selectType = 0;

  int sortIndex = 0;

  bool showStatusAlert = false;

  bool showTypeAlert = false;

  bool showSortAlert = false;

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
        SCMaterialSearchItem(searchAction: () {
          SCRouterHelper.pathPage(SCRouterPath.materialSearchPage, null);
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

  /// 新增入库按钮
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
          SCRouterHelper.pathPage(SCRouterPath.addReceiptPage, null);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(SCAsset.iconAddReceipt, width: 20.0, height: 20.0,),
            const SizedBox(width: 2.0,),
            const Text(
                '新增入库',
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
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          SCMaterialEntryModel model = widget.state.dataList[index];
          return SCMaterialEntryCell(
            model: model,
            type: 0,
            detailTapAction: () {
              detailAction(index);
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10.0,);
        },
        itemCount: widget.state.dataList.length);
  }


  /// 详情
  detailAction(int index) {
    SCRouterHelper.pathPage(SCRouterPath.materialDetailPage, null);
  }

  /// 入库状态弹窗
  Widget statusAlert() {
    return Offstage(
      offstage: !showStatusAlert,
      child: SCSiftAlert(
        title: '入库状态',
        list: statusList,
        selectIndex: selectStatus,
        tapAction: (value) {
          setState(() {
            showStatusAlert = false;
            selectStatus = value;
            siftList[0] = value == 0 ? '状态' : statusList[value];
          });
        },),
    );
  }

  /// 入库类型弹窗
  Widget typeAlert() {
    return Offstage(
      offstage: !showTypeAlert,
      child: SCSiftAlert(
        title: '入库类型',
        list: typeList,
        selectIndex: selectType,
        tapAction: (value) {
          setState(() {
            showTypeAlert = false;
            selectType = value;
            siftList[1] = value == 0 ? '类型' : typeList[value];
          });
        },),
    );
  }

  /// 排序弹窗
  Widget sortAlert() {
    return Offstage(
      offstage: !showSortAlert,
      child: SCSortAlert(selectIndex: sortIndex, tapAction: (index) {
        setState(() {
          showSortAlert = false;
          sortIndex = index;
        });
      },),
    );
  }

}
