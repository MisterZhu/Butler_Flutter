import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/View/Alert/sc_select_btn_view.dart';

import '../../../../../Constants/sc_asset.dart';
import '../../../../WorkBench/Home/View/Alert/sc_alert_header_view.dart';
import '../../../HouseInspect/View/sc_bottom_button_item.dart';
import '../../Model/sc_form_data_model.dart';

class CheckPlaceDialog extends StatefulWidget {

  String? title;

  CheckList checkList;

  Function(CheckList data,int str)? f1;

  Function()? f2;
  
  CheckPlaceDialog({Key? key,required this.title, required this.checkList,this.f1,this.f2}) : super(key: key);

  @override
  State<CheckPlaceDialog> createState() => _CheckPlaceDialogState();
}

class _CheckPlaceDialogState extends State<CheckPlaceDialog> {
  bool selectStatus1 = false;

  bool selectStatus2 = false;

  @override
  Widget build(BuildContext context) {
    double height = 290.0;

    return Container(
      width: double.infinity,
      height: height,
      decoration: const BoxDecoration(
          color: SCColors.color_F2F3F5,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          titleItem(context),
          Expanded(child: listView()),
          const SizedBox(
            height: 60.0,
          ),
          SCBottomButtonItem(
            list: const ['完成'],
            buttonType: 0,
            leftTapAction: () {
              Navigator.of(context).pop();
            },
            tapAction:(){
              int str = -1;
              selectStatus1?str=0:-1;
              selectStatus2?str=1:-1;
              widget.f1?.call(widget.checkList,str);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget listView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
          decoration: BoxDecoration(
              color: SCColors.color_FFFFFF,
              borderRadius: BorderRadius.circular(4.0)),
          child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return getCell(index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SCLineCell(
                  padding: EdgeInsets.only(left: 16),
                );
              },
              itemCount: 3)),
    );
  }

  Widget getCell(int index) {
    if (index == 0) {
      return contentItem();
    } else if (index == 1) {
      return typeItem();
    } else if (index == 2) {
      return isLinkItem();
    } else {
      return const SizedBox(
        height: 10,
      );
    }
  }

  Widget contentItem() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Text(widget.checkList.checkName ?? '',
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w500,
              color: SCColors.color_1B1D33,
            )));
  }

  Widget typeItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
            padding: EdgeInsets.only(left: 10, right: 110),
            child: Text("类型",
                style: TextStyle(
                  fontSize: 17,
                  color: SCColors.color_1B1D33,
                  fontWeight: FontWeight.w400,
                ))),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectBtnView(
                btnValue: "正常", selectStatus: selectStatus1, fuc: (status) {
              setState(() {
                selectStatus1 = status;
                selectStatus2 = false;
              });
            }),
            const SizedBox(width: 10),
            SelectBtnView(
                btnValue: "异常", selectStatus: selectStatus2, fuc: (status) {
              setState(() {
                selectStatus1 = false;
                selectStatus2 = status;
              });
            })
          ],
        ),
      ],
    );
  }


  Widget isLinkItem() {
    return Padding(padding:const EdgeInsets.only(left: 10,right: 10) ,child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          const Text("异常报事", style:  TextStyle(
              fontSize: 17,
              color: SCColors.color_1B1D33,
              fontWeight: FontWeight.w400)),

          ElevatedButton(
              onPressed: (){
                  widget.f2?.call();
                  Navigator.of(context).pop();
              },
              child:const Text("报事",style:  TextStyle(
                  fontSize: 17,
                  color: SCColors.color_1B1D33,
                  fontWeight: FontWeight.w400)))

        ],
      ));



  }


  
  /// title
  Widget titleItem(BuildContext context) {
    return SCAlertHeaderView(
      title: widget.title,
      closeTap: () {
        Navigator.of(context).pop();
      },
    );
  }
  
  
  
}





