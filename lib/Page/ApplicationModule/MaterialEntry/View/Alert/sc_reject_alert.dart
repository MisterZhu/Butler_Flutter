import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Alert/sc_reject_node_alert.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../../WorkBench/Home/View/Alert/sc_alert_header_view.dart';
import '../../../HouseInspect/View/sc_bottom_button_item.dart';
import '../../../HouseInspect/View/sc_deliver_evidence_cell.dart';
import '../../../HouseInspect/View/sc_deliver_explain_cell.dart';
import '../AddEntry/sc_material_select_item.dart';

/// 驳回弹窗

class SCRejectAlert extends StatefulWidget {
  /// 标题
  final String title;

  final String reason;

  final List tagList;

  final bool showNode;

  SCRejectAlert({Key? key,
    required this.title,
    required this.reason,
    required this.tagList,
    required this.showNode}) : super(key: key);

  @override
  SCRejectAlertState createState() => SCRejectAlertState();
}

class SCRejectAlertState extends State<SCRejectAlert> {

  /// 节点
  String node = '';

  /// 输入的内容
  String input = '';

  /// 图片数组
  List photosList = [];

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SCUtils().hideKeyboard(context: context);
      },
      child: Container(
        width: double.infinity,
        height: 395.0 + 54.0 + SCUtils().getBottomSafeArea(),
        decoration: const BoxDecoration(
          color: SCColors.color_F2F3F5,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            titleItem(context),
            Expanded(child: listView()),
            const SizedBox(height: 20.0,),
            SCBottomButtonItem(list: const ['取消', '确定'], buttonType: 1, leftTapAction: () {
              Navigator.of(context).pop();
            }, rightTapAction: () {
              Navigator.of(context).pop();
            },),
          ],
        ),
      )
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
            return const SizedBox(height: 10,);
          },
          itemCount: 2)),
    );
  }

  Widget getCell(int index) {
    if (index == 0) {
      return contentItem();
    } else if (index == 1) {
      return photosItem();
    } else {
      return const SizedBox(height: 10,);
    }
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

  /// contentItem
  Widget contentItem() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        nodeItem(),
        const SizedBox(height: 12.0,),
        inputItem(),
        tagsView(),
      ]
    );
  }

  /// 节点item
  Widget nodeItem() {
    return Offstage(
      offstage: !widget.showNode,
      child: Column(
        children: [
          SCMaterialSelectItem(isRequired: true, title: '驳回节点', content: node, selectAction: () {
            showNodeAlert();
          },),
          line(),
        ],
      ),
    );
  }

  /// 输入框
  Widget inputItem() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: SCDeliverExplainCell(title: widget.reason, content: input, inputHeight: 92.0, inputAction: (String content) {
          input = content;
        },)
    );
  }

  /// 图片
  Widget photosItem() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: SCDeliverEvidenceCell(
          title: '上传照片',
          addIcon: SCAsset.iconMaterialAddPhoto,
          addPhotoType: SCAddPhotoType.all,
          files: photosList,
          updatePhoto: (List list) {
            photosList = list;
        },)
    );
  }

  /// tagsView
  Widget tagsView() {
    if (widget.tagList.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 7.0,
          runSpacing: 10.0,
          children: widget.tagList.asMap().keys.map((index) => cell(widget.tagList[index])).toList(),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  /// cell
  Widget cell(String name) {
    return GestureDetector(
      onTap: () {
        setState(() {
          input = input + name;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 24.0,
        decoration: BoxDecoration(
          color: SCColors.color_F7F8FA,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
        child: Text(
          name,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: SCFonts.f12,
            color: SCColors.color_8D8E99,
            fontWeight: FontWeight.w400,
          ),),
      ),
    );
  }

  /// 节点弹窗
  showNodeAlert() {
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCRejectNodeAlert(
            list: ['审批节点名称5', '审批节点名称4', '审批节点名称3', '审批节点名称2', '审批节点名称1', '发起人'],
            currentNode: node,
            tapAction: (value) {
              setState(() {
                node = value;
              });
            },
          ));
    });
  }

  /// line
  Widget line() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.only(left: 12.0),
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

}