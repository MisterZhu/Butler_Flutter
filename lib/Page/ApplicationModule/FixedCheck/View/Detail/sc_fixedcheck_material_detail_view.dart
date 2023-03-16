import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/FixedCheck/View/Detail/sc_fixedcheck_material_detail_header.dart';
import 'package:smartcommunity/Page/ApplicationModule/FixedCheck/View/Detail/sc_frmLoss_reason_alert.dart';
import '../../../../../Delegate/sc_sticky_tabbar_delegate.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../MaterialEntry/Model/sc_entry_type_model.dart';
import '../../../MaterialEntry/Model/sc_material_list_model.dart';
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

  /// tabTitle
  List<String> tabTitleList = ['使用中', '已报废'];

  /// tabController
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
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
    return Column(
      children: [
        contentView(),
        bottomView(),
      ],
    );
  }

  /// contentView
  Widget contentView() {
    return Expanded(
        child: ExtendedNestedScrollView(
            pinnedHeaderSliverHeightBuilder: () {
              return 44.0;
            },
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                headerItem(),
                stickyTabBar(),
              ];
            },
            body: TabBarView(
              controller: tabController,
              children: getTabViewList(),
            )));
  }

  /// header
  Widget headerItem() {
    String materialName = widget.state.detailModel.materialInfo?.name ?? '';
    String unitName = widget.state.detailModel.materialInfo?.unitName ?? '';
    String norms = widget.state.detailModel.materialInfo?.norms ?? '';
    return SliverToBoxAdapter(
      child: SCFixedCheckMaterialDetailHeaderView(
          materialName: materialName, unitName: unitName, norms: norms),
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
          widget.state.submit();
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
  showReasonAlert(int index) {
    SCMaterialListModel model = widget.state.normalList[index];
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCFrmLossReasonAlert(
            list: widget.state.reasonList,
            selectIndex: -1,
            tapAction: (subIndex) {
              SCEntryTypeModel typeModel = widget.state.typeList[subIndex];
              model.reportReason = typeModel.code;
              model.reportReasonDesc = typeModel.name ?? '';
              model.isFixedCheckFormLssDone = true;
              widget.state.initData();
              widget.state.update();
            },
          ));
    });
  }

  /// tabViewList
  List<Widget> getTabViewList() {
    return [
      SCFixedPropertyListView(
        list: widget.state.normalList,
        cellType: SCFixedCheckMaterialDetailCellType.using,
        tapAction: (int index) {
          print("111111");
          showReasonAlert(index);
        },
      ),
      SCFixedPropertyListView(
        list: widget.state.doneList,
        cellType: SCFixedCheckMaterialDetailCellType.reportedLoss,
        tapAction: (int index) {
          print("222222");
          SCMaterialListModel model = widget.state.doneList[index];
          model.isFixedCheckFormLssDone = false;
          widget.state.initData();
          widget.state.update();
        },
      )
    ];
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
