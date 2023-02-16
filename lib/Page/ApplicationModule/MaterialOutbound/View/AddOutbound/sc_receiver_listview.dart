
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../../Constants/sc_asset.dart';
import '../../Controller/sc_select_receiver_controller.dart';
import '../../Model/sc_receiver_model.dart';

/// 选择领用人listview
class SCReceiverListView extends StatefulWidget {

  /// 当前领用人model
  final SCReceiverModel? currentModel;

  /// 点击
  final Function(SCReceiverModel model)? tapAction;

  /// 打电话
  final Function(String mobile)? callAction;

  /// SCSelectReceiverController
  final SCSelectReceiverController state;

  SCReceiverListView({Key? key, required this.state, this.currentModel, this.tapAction, this.callAction}) : super(key: key);

  @override
  SCReceiverListViewState createState() => SCReceiverListViewState();
}

class SCReceiverListViewState extends State<SCReceiverListView> {

  /// RefreshController
  RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return listView();
  }

  @override
  dispose() {
    refreshController.dispose();
    super.dispose();
  }

  /// listView
  Widget listView() {
    return SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: true,
        header: const SCCustomHeader(
          style: SCCustomHeaderStyle.noNavigation,
        ),
        onRefresh: onRefresh, onLoading: loadMore, child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return cell(widget.state.dataList[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10.0,);
            },
            itemCount: widget.state.dataList.length));
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

  /// 下拉刷新
  Future onRefresh() async {
    widget.state.loadDataList(isMore: false, completeHandler: (bool success, bool last){
      refreshController.refreshCompleted();
      refreshController.loadComplete();
    });
  }

  /// 上拉加载
  void loadMore() async{
    widget.state.loadDataList(isMore: true, completeHandler: (bool success, bool last){
      if (last) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    });
  }

}
