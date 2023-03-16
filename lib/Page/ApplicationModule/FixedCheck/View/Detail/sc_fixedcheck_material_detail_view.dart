import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/FixedCheck/View/Detail/sc_fixedcheck_material_detail_header.dart';
import 'package:smartcommunity/Page/ApplicationModule/FixedCheck/View/Detail/sc_frmLoss_reason_alert.dart';
import '../../../../../Delegate/sc_sticky_tabbar_delegate.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../MaterialEntry/View/Detail/sc_material_bottom_view.dart';
import '../../Controller/sc_fixedcheck_material_detail_controller.dart';
import 'sc_fixed_property_listview.dart';
import 'sc_fixed_tabbar.dart';
import 'sc_fixedcheck_material_detail_cell.dart';

class SCFixedCheckMaterialDetailView extends StatefulWidget {
  /// SCFixedCheckMaterialDetailController
  final SCFixedCheckMaterialDetailController state;

  SCFixedCheckMaterialDetailView({Key? key, required this.state})
      : super(key: key);

  @override
  SCFixedCheckMaterialDetailViewState createState() =>
      SCFixedCheckMaterialDetailViewState();
}

class SCFixedCheckMaterialDetailViewState
    extends State<SCFixedCheckMaterialDetailView>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  /// 报损原因index
  int reasonIndex = 0;

  List headerList = [];

  /// tabTitle
  List<String> tabTitleList = ['使用中', '已报废'];

  /// tabView-list
  late List<Widget> tabViewList;

  /// tabController
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    headerList = [
      {'name': '物资名称', 'content': widget.state.materialModel.materialName ?? ''},
      {'name': '单位', 'content': widget.state.materialModel.unitName ?? ''},
      {'name': '规格', 'content': widget.state.materialModel.norms},
    ];
    tabViewList = [
      SCFixedPropertyListView(
        cellType: SCFixedCheckMaterialDetailCellType.using,
        tapAction: (int index) {},
      ),
      SCFixedPropertyListView(
        cellType: SCFixedCheckMaterialDetailCellType.reportedLoss,
        tapAction: (int index) {},
      )
    ];
    tabController = TabController(length: tabTitleList.length, vsync: this);
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return ExtendedNestedScrollView(
        pinnedHeaderSliverHeightBuilder: () {
          return 44.0;
        },
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            headerItem(),
            stickyTabBar(),
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: tabViewList,
        ));
  }

  /// header
  Widget headerItem() {
    return const SliverToBoxAdapter(
      child: SCFixedCheckMaterialDetailHeaderView(
          materialName: '橘子', unitName: '斤', norms: '1001'),
    );
  }

  /// bottomView
  Widget bottomView() {
    List list = [
      {
        "type": scMaterialBottomViewType2,
        "title": "确定",
      }
    ];
    return SCMaterialDetailBottomView(
        list: list,
        onTap: (value) {
          SCUtils().hideKeyboard(context: context);
          SCRouterHelper.back({'model': widget.state.materialModel});
        });
  }

  /// 吸顶tabBar
  Widget stickyTabBar() {
    return SliverPersistentHeader(
        pinned: true,
        floating: false,
        delegate: SCStickyTabBarDelegate(child: tabBarItem(), height: 44.0));
  }

  /// tabBarItem
  Widget tabBarItem() {
    return SCFixedTabBar(
      tabController: tabController,
      titleList: tabTitleList,
      height: 44.0,
    );
  }

  /// 报损原因弹窗
  showReasonAlert() {
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCFrmLossReasonAlert(
            list: widget.state.reasonList,
            selectIndex: reasonIndex,
            tapAction: (index) {
              setState(() {
                reasonIndex = index;
              });
            },
          ));
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
