
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/OnlineMonitor/View/sc_monitor_cell.dart';
import '../../../../../Constants/sc_asset.dart';
import '../Controller/sc_monitor_search_controller.dart';

/// 监控搜索view

class SCMonitorSearchView extends StatefulWidget {

  /// SCMonitorSearchController
  final SCMonitorSearchController state;

  SCMonitorSearchView({Key? key, required this.state}) : super(key: key);

  @override
  SCMonitorSearchViewState createState() => SCMonitorSearchViewState();
}

class SCMonitorSearchViewState extends State<SCMonitorSearchView> {

  final TextEditingController controller = TextEditingController();

  final FocusNode node = FocusNode();

  bool showCancel = true;

  /// RefreshController
  RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  initState() {
    super.initState();
    showKeyboard(context);
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// 弹出键盘
  showKeyboard(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100),(){
      node.requestFocus();
    });
  }

  /// body
  Widget body() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerItem(),
          Expanded(child: contentView())
        ]
    );
  }

  /// 搜索
  Widget headerItem() {
    return Container(
      color: SCColors.color_FFFFFF,
      height: 44.0,
      padding: EdgeInsets.only(left: 16.0, right: showCancel ? 0 : 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: searchItem()),
          cancelBtn(),
        ],
      ),
    );
  }

  /// 搜索框
  Widget searchItem() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 30.0,
      decoration: BoxDecoration(
          color: SCColors.color_F2F3F5,
          borderRadius: BorderRadius.circular(15.0)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            SCAsset.iconGreySearch,
            width: 16.0,
            height: 16.0,
          ),
          const SizedBox(
            width: 8.0,
          ),
          textField(),
        ],
      ),
    );
  }

  /// 输入框
  Widget textField() {
    return Expanded(
        child: TextField(
          controller: controller,
          maxLines: 1,
          cursorColor: SCColors.color_1B1C33,
          cursorWidth: 2,
          focusNode: node,
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_1B1C33),
          keyboardType: TextInputType.text,
          keyboardAppearance: Brightness.light,
          textInputAction: TextInputAction.search,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 4),
            hintText: '搜索摄像头名称',
            hintStyle: TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w400,
                color: SCColors.color_B0B1B8),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent)),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent)),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent)),
            isCollapsed: true,
          ),
          onChanged: (value) {

          },
          onSubmitted: (value) {
            widget.state.updateSearchString(value);
            widget.state.searchData(isMore: false);
            node.unfocus();
          },
          onTap: () {
            if (!showCancel) {
              setState(() {
                showCancel = true;
              });
            }
          },
        ));
  }

  /// 取消按钮
  Widget cancelBtn() {
    return Offstage(
      offstage: !showCancel,
      child: CupertinoButton(
          minSize: 64.0,
          padding: EdgeInsets.zero,
          child: const Text(
            '取消',
            style: TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w400,
                color: SCColors.color_1B1D33),
          ),
          onPressed: () {
            node.unfocus();
            setState(() {
              showCancel = false;
            });
          }),
    );
  }

  /// contentView
  Widget contentView() {
    return SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: true,
        header: const SCCustomHeader(
          style: SCCustomHeaderStyle.noNavigation,
        ),
        onRefresh: onRefresh,
        onLoading: loadMore,
        child: widget.state.dataList.isNotEmpty ? gridView() : emptyView()
    );
  }

  /// gridView
  Widget gridView() {
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        crossAxisCount: 2,
        shrinkWrap: true,
        itemCount: 10,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return SCMonitorCell(
            pic: SCAsset.iconMonitorLoadingDefault,
            title: '设备名称',
            onTapAction: () {

            },
          );
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

  /// 空白列表占位图
  Widget emptyView() {
    return Padding(
      padding: const EdgeInsets.only(top: 124.0),
      child: Text(
          widget.state.tips,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_8D8E99)),);
  }


  /// 下拉刷新
  Future onRefresh() async {
    widget.state.searchData(isMore: false, completeHandler: (bool success, bool last){
      refreshController.refreshCompleted();
      refreshController.loadComplete();
    });
  }

  /// 上拉加载
  void loadMore() async{
    widget.state.searchData(isMore: true, completeHandler: (bool success, bool last){
      if (last) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    });
  }

  @override
  dispose() {
    super.dispose();
    controller.dispose();
    node.dispose();
  }

}