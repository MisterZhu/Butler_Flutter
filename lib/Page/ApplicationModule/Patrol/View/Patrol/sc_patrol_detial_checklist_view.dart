import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

import '../../Model/sc_form_data_model.dart';

/// 消息listview
class SCPatrolDetailCheckListView extends StatelessWidget {



  List?  data;

  Function(CheckList list,int index)? fun;

  SCPatrolDetailCheckListView({Key? key,this.data, required this.fun}) : super(key: key);

  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: refreshController,
        enablePullUp: false,
        enablePullDown: false,
        header: const SCCustomHeader(
          style: SCCustomHeaderStyle.noNavigation,
        ),
        onRefresh: null,
        onLoading: null,
        child: data!=null && data!.isNotEmpty ? listView() : emptyView()
    );
  }

  Widget listView() {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return body(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SCLineCell(
            padding: EdgeInsets.only(left: 16),
          );
        },
        itemCount: data!=null ? data!.length: 0);
  }


  Widget body(int index) {
    return GestureDetector(
      onTap: () {
       // SCRouterHelper.pathPage(SCRouterPath.patrolDetailPage, {"procInstId": model?.procInstId ?? '',"nodeId":model?.nodeId??""});
        //fuc?.call();
        fun?.call(data![index],index);
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          decoration: BoxDecoration(
              color: SCColors.color_FFFFFF,
              borderRadius: BorderRadius.circular(4.0)
          ),
          child: SCTextCell(
            title:data!=null? data![index].checkName:"",
            titleColor: SCColors.color_1B1D33,
            titleFontSize:SCFonts.f16,
            rightIcon:"images/common/icon_arrow_right.png",
            content: setContent(index),
            contentColor: getStatus(index) ,
          )
      ),
    );
  }

  Color getStatus(int index){
    if(data!=null){
      if(data![index].evaluateResult == "QUALIFIED"){
        return SCColors.color_1B1D33;
      }else if(data![index].evaluateResult == "UNQUALIFIED"){
        return SCColors.color_FF1D32;
      }else{
        return SCColors.color_9B9B9B;
      }
    }
    return SCColors.color_9B9B9B;
  }


  String setContent(int index){
    String  str = '';
     if(data!=null){
      if(data![index].evaluateResult == "QUALIFIED"){
         str = "正常";
         return str;
       }else if(data![index].evaluateResult == "UNQUALIFIED"){
        str = "异常";
        return str;
       }else{
         str = "未查";
         return str;
       }
     }
     return str;
  }



  /// emptyView
  Widget emptyView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        Image.asset(SCAsset.iconMessageEmpty, width: 120.0, height: 120.0,),
        const SizedBox(
          height: 2.0,
        ),
        const Text("暂无内容", style: TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: SCColors.color_8D8E99
        ),)
      ],
    );
  }


}