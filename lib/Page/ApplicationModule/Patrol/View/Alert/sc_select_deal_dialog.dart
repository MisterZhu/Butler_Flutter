import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/View/Alert/sc_select_btn_view.dart';

import '../../../../../Constants/sc_asset.dart';
import '../../../../WorkBench/Home/View/Alert/sc_alert_header_view.dart';
import '../../../HouseInspect/View/sc_bottom_button_item.dart';
import '../../Model/sc_patrol_detail_model.dart';

class SelectDealDialog extends StatefulWidget {
   String? title;

   CheckList checkList;


  SelectDealDialog({Key? key, required this.title, required this.checkList})
      : super(key: key);

  @override
  State<SelectDealDialog> createState() => _SelectDealDialogState();
}

class _SelectDealDialogState extends State<SelectDealDialog> {
  bool selectStatus1 = false;

  bool selectStatus2 = false;

  @override
  Widget build(BuildContext context) {
    double height = 395.0;

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
            height: 40.0,
          ),
          SCBottomButtonItem(
            list: const ['确定'],
            buttonType: 0,
            leftTapAction: () {
              Navigator.of(context).pop();
            },
            rightTapAction: () {},
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
              color: SCColors.color_1B1D33,
              fontWeight: FontWeight.w400,
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
                  fontSize: SCFonts.f16,
                  color: SCColors.color_1B1D33,
                  fontWeight: FontWeight.w400,
                ))),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectBtnView(
                btnValue: "检查", selectStatus: selectStatus1, fuc: (status) {
              setState(() {
                selectStatus1 = status;
                selectStatus2 = false;
              });
            }),
            const SizedBox(width: 10),
            SelectBtnView(
                btnValue: "整改任务", selectStatus: selectStatus2, fuc: (status) {
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
    return Column(
      children: [
      Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
            padding: EdgeInsets.only(left: 10, right: 60),
            child: Text("是否涉及项",
                style: TextStyle(
                  fontSize: SCFonts.f16,
                  color: SCColors.color_1B1D33,
                  fontWeight: FontWeight.w400,
                ))),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectBtnView(
                btnValue: "是", selectStatus: selectStatus1, fuc: (status) {
              setState(() {
                selectStatus1 = status;
                selectStatus2 = false;
              });
            }),
            const SizedBox(width: 10),
            SelectBtnView(
                btnValue: "否", selectStatus: selectStatus2, fuc: (status) {
              setState(() {
                selectStatus1 = false;
                selectStatus2 = status;
              });
            })
          ],
        ),
      ],),
      const SizedBox(height: 10,),
      showTipTxt()
      ],
    );

  }


  Widget showTipTxt() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
          width: double.infinity,
          height: 55,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: SCColors.color_F7F8FA,
              borderRadius: BorderRadius.circular(4.0)),
          child:const Text("若该检查项为当前项目不涉及的内容，则勾选该选项，勾选后不计算该项得分",style: TextStyle(
            fontSize: SCFonts.f14,
            color: SCColors.color_8D8E99,
            fontWeight: FontWeight.w400,
          ),)),
    );
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
