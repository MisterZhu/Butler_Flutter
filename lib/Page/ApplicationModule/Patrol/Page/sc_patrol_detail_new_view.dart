import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_patrol_detail_model.dart';

import '../../../../Constants/sc_h5.dart';
import '../../../../Constants/sc_type_define.dart';
import '../../../../Network/sc_config.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/Router/sc_router_path.dart';
import '../../../../Utils/sc_utils.dart';
import '../../MaterialEntry/View/Alert/sc_reject_alert.dart';
import '../Controller/sc_patrol_detail_controller.dart';
import '../View/Alert/sc_check_palce_dialog.dart';
import '../View/Alert/sc_select_deal_dialog.dart';
import '../View/Patrol/sc_common_top_item.dart';
import '../View/Patrol/sc_patrol_derivelist_view.dart';
import '../View/Patrol/sc_patrol_detial_checklist_view.dart';
import '../View/Patrol/sc_patrol_route_list_view.dart';

class PatrolDetailNewView extends StatefulWidget {

  final SCPatrolDetailController state;

  const PatrolDetailNewView({Key? key, required this.state}) : super(key: key);

  @override
  State<PatrolDetailNewView> createState() => _PatrolDetailNewViewState();
}

class _PatrolDetailNewViewState extends State<PatrolDetailNewView> with SingleTickerProviderStateMixin{


  List tabList = ['详情信息', '被派生/关联'];


  RefreshController refreshController2 = RefreshController(initialRefresh: false);

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: tabList.length, vsync: this);
    tabController.addListener(() {
      if (widget.state.currentIndex != tabController.index) {
        widget.state.updateCurrentIndex(tabController.index);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index: index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10.0,
          );
        },
        itemCount: widget.state.dataList.length);
  }

  /// cell
    /// cell
    Widget getCell({required int index}) {
      int type = widget.state.dataList[index]['type'];
      List list = widget.state.dataList[index]['data'];
      if (type == SCTypeDefine.SC_PATROL_TYPE_TITLE) {
        return cell1(list);
      } else if (type == SCTypeDefine.SC_PATROL_TYPE_LOG) {
        return logCell(list);
      } else if (type == SCTypeDefine.SC_PATROL_TYPE_CHECK) {
        return checkCell(list);
      } else if (type == SCTypeDefine.SC_PATROL_TYPE_INFO) {
        return cell1(list);
      } else if(type == SCTypeDefine.SC_PATROL_TYPE_PINGFEN){
         return cell1(list);
      }else if(type == SCTypeDefine.SC_PATROL_TYPE_TAB){
        return tabPage(list);
      } else {
        return const SizedBox();
      }
    }


    Widget tabPage(List list){
       return Container(
           height: 200,
           decoration: const BoxDecoration(
               color: SCColors.color_FFFFFF,
           ),
           child:  Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               CommonTabTopItem(tabController: tabController, titleList: tabList),
               const SCLineCell(
                    padding: EdgeInsets.only(left: 0),
               ),
               Expanded(child: TabBarView(
                   controller: tabController,
                   children:  [
                     SCPatrolDetailCheckListView(data:list ,fun: (data,index){
                       log('巡查详情yyyyyyyy===${data.checkName}');
                       showDialog(data);
                     }),
                     SCPatrolDeriveListView(data:widget.state.dataList2,refreshController: refreshController2,onfreshFun: (){
                       widget.state.loadData2(
                           isMore: false,
                           completeHandler: (bool success,bool last) {
                             refreshController2.refreshCompleted();
                             refreshController2.loadComplete();
                           });
                     },onLoadMoreFun: (){
                       widget.state.loadData2(
                           isMore: true,
                           completeHandler: (bool success,bool last) {
                             refreshController2.loadComplete();
                           });
                     },ht: 20.0,),
                   ])
               )
             ],
           ),
         );
    }


    showDialog(CheckList data){
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: CheckPlaceDialog(title: '选择',checkList: data,f1: (value,str){
            widget.state.reportData(value,str);
          },f2: (){
            SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
              "title": '快捷报事',
              "url": SCUtils.getWebViewUrl(
                  url: SCConfig.getH5Url(SCH5.quickReportUrl),
                  title: '快捷报事',
                  needJointParams: true)
            });
          },)
      );
    }


    /// cell1
      Widget cell1(List list) {
        return SCDetailCell(
          list: list,
          leftAction: (String value, int index) {},
          rightAction: (String value, int index) {},
          imageTap: (int imageIndex, List imageList, int index) {
            // SCImagePreviewUtils.previewImage(imageList: [imageList[index]]);
          },
        );
      }

  /// 任务日志cell
  Widget logCell(List list) {
    return SCDetailCell(
      list: list,
      leftAction: (String value, int index) {},
      rightAction: (String value, int index) {},
      imageTap: (int imageIndex, List imageList, int index) {
        // SCImagePreviewUtils.previewImage(imageList: [imageList[index]]);
      },
      detailAction: (int subIndex) {
        // 任务日志
        SCRouterHelper.pathPage(SCRouterPath.taskLogPage, {'bizId': widget.state.procInstId});
      },
    );
  }

  /// 检查项cell
  Widget checkCell(List list) {
    return SCDetailCell(
      list: list,
      leftAction: (String value, int index) {},
      rightAction: (String value, int index) {},
      imageTap: (int imageIndex, List imageList, int index) {
      },
      detailAction: (int subIndex) {
        if (widget.state.model.customStatusInt! >= 40) {//已完成的任务，不能进行报事
          return;
        }
        if (widget.state.model.isScanCode == false) {// 任务扫码前，不可对检查项进行报事
          SCToast.showTip('请先扫码');
          return;
        }
        SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
          "title": '快捷报事',
          "url": SCUtils.getWebViewUrl(
              url: SCConfig.getH5Url(SCH5.quickReportUrl),
              title: '快捷报事',
              needJointParams: true)
        });
      },
    );
  }


}
