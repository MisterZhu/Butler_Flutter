import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Other/sc_patrol_utils.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/Controller/sc_warning_search_controller.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/Model/sc_warningcenter_model.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../MaterialEntry/View/Alert/sc_reject_alert.dart';
import '../../../WarningCenter/Model/sc_warning_dealresult_model.dart';
import '../../../WarningCenter/Other/sc_warning_utils.dart';
import '../../Controller/sc_patrol_search_controller.dart';
import '../../Model/sc_patrol_task_model.dart';

/// 搜索view

class SCSearchPatrolView extends StatefulWidget {
  final SCSearchPatrolController state;

  const SCSearchPatrolView({Key? key, required this.state}) : super(key: key);

  @override
  SCSearchPatrolViewState createState() => SCSearchPatrolViewState();
}

class SCSearchPatrolViewState extends State<SCSearchPatrolView> {
  final TextEditingController controller = TextEditingController();

  final FocusNode node = FocusNode();

  bool showCancel = true;

  /// RefreshController
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

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
    Future.delayed(const Duration(milliseconds: 100), () {
      node.requestFocus();
    });
  }

  /// body
  Widget body() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [headerItem(), Expanded(child: contentView())]);
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
    String hintText = "搜索任务";
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
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
        hintText: hintText,
        hintStyle: const TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: SCColors.color_B0B1B8),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        border: const OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        isCollapsed: true,
      ),
      onChanged: (value) {},
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
    if (widget.state.dataList.isNotEmpty) {
      return listview();
    } else {
      return emptyItem();
    }
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return cell(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10.0,
            );
          },
          itemCount: widget.state.dataList.length),
    );
  }

  /// cell
  Widget cell(int index) {
    SCPatrolTaskModel model = widget.state.dataList[index];
    String btnText = '处理';
    if ((model.actionVo ?? []).isNotEmpty) {
      btnText = model.actionVo!.first;
    }
    return SCTaskCardCell(
      timeType: 0,
      remainingTime: 0,
      tagList: [],
      time: model.endTime,
      title: model.categoryName ?? '',
      titleIcon: SCAsset.iconPatrolTask,
      statusTitle: model.customStatus ?? '',
      statusTitleColor: SCWarningCenterUtils.getStatusColor(model.customStatusInt ?? -1),
      content: model.procInstName ?? '',
      contentMaxLines: 30,
      address: '',
      btnText: btnText,
      hideBtn: false,
      hideAddressRow: true,
      hideCallIcon: true,
      detailTapAction: () {
        SCRouterHelper.pathPage(SCRouterPath.patrolDetailPage, {"procInstId": model.procInstId ?? '', "taskId": model.taskId ?? ''});
      },
      btnTapAction: () {
        dealAction(btnText, model.taskId ?? '', model.procInstId ?? '');
      },
    );
  }

  /// 无搜索结果
  Widget emptyItem() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 104.0),
      child: Text(widget.state.tips,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_8D8E99)),
    );
  }

  /// 下拉刷新
  Future onRefresh() async {
    widget.state.searchData(
        isMore: false,
        completeHandler: (bool success, bool last) {
          refreshController.refreshCompleted();
          refreshController.loadComplete();
        });
  }

  /// 上拉加载
  void loadMore() async {
    widget.state.searchData(
        isMore: true,
        completeHandler: (bool success, bool last) {
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

  /// 打电话
  call(String phone) {
    SCUtils.call(phone);
  }

  /// 处理
  dealAction(String name, String taskId, String procInstId) {
    SCPatrolUtils patrolUtils = SCPatrolUtils();
    patrolUtils.taskId = taskId;
    patrolUtils.procInstId = procInstId;
    patrolUtils.taskAction(name: name);
  }

}
