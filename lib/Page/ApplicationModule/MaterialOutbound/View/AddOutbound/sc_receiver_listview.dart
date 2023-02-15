
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../../Constants/sc_asset.dart';
import '../../Model/sc_receiver_model.dart';

/// 选择领用人listview
class SCReceiverListView extends StatefulWidget {

  /// 领用人数组
  final List<SCReceiverModel>? list;

  /// 当前领用人model
  final SCReceiverModel? currentModel;

  /// 点击
  final Function(SCReceiverModel model)? tapAction;

  /// 打电话
  final Function(String mobile)? callAction;

  SCReceiverListView({Key? key, required this.list, this.currentModel, this.tapAction, this.callAction}) : super(key: key);

  @override
  SCReceiverListViewState createState() => SCReceiverListViewState();
}

class SCReceiverListViewState extends State<SCReceiverListView> {

  @override
  Widget build(BuildContext context) {
    return listView();
  }

  /// listView
  Widget listView() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              if (widget.list != null) {
                return cell(widget.list![index]);
              } else {
                return const SizedBox();
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10.0,);
            },
            itemCount: widget.list?.length ?? 0));
  }

  /// cell
  Widget cell(SCReceiverModel model) {
    return GestureDetector(
      onTap: () {
        widget.tapAction?.call(model);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 70.0,
        padding: const EdgeInsets.only(left: 12.0, right: 13.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: SCColors.color_FFFFFF,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(model.personId == widget.currentModel?.personId ? SCAsset.iconReceiverSelected : SCAsset.iconReceiverUnselect, width: 18.0, height: 18.0),
            const SizedBox(width: 10.0,),
            Expanded(child: middleItem(name: model.personName ?? '')),
            const SizedBox(width: 16.0,),
            line(),
            const SizedBox(width: 16.0,),
            callItem(model.phone ?? ''),
          ],
        ),
      ),
    );
  }

  /// 姓名、身份
  Widget middleItem({required String name, String? identity}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: SCFonts.f14,
            color: SCColors.color_1B1D33,
            fontWeight: FontWeight.w400,
          ),),
        Offstage(
          offstage: identity == null,
          child: Text(
            identity ?? '',
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: SCFonts.f14,
              color: SCColors.color_5E5F66,
              fontWeight: FontWeight.w400,
            ),),
        )
      ],
    );
  }

  /// line
  Widget line() {
    return Container(
      width: 0.5,
      height: 40.0,
      color: SCColors.color_EDEDF0,
    );
  }

  /// 联系他
  Widget callItem(String mobile) {
    return GestureDetector(
      onTap: () {
        if (mobile.isNotEmpty) {
          widget.callAction?.call(mobile);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(SCAsset.iconReceiverCall, width: 20.0, height: 20.0,),
          const SizedBox(width: 8.0,),
          const Text(
            '联系他',
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: SCFonts.f14,
              color: SCColors.color_4285F4,
              fontWeight: FontWeight.w400,
            ),),
        ],
      ),
    );
  }

}
