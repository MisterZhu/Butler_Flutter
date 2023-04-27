import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import '../../../../../Constants/sc_default_value.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../MaterialEntry/Model/sc_selectcategory_model.dart';
import '../../../MaterialEntry/Model/sc_selectcategory_tree_model.dart';
import '../../../MaterialEntry/View/SelectCategoryAlert/sc_add_material_selectcategory_alert.dart';
import '../../../MaterialOutbound/Controller/sc_select_department_controller.dart';
import '../../../MaterialOutbound/Model/sc_receiver_model.dart';
import '../../Controller/sc_patrol_transfer_controller.dart';
import '../../Model/sc_tenant_user_model.dart';

/// 转派view

class SCPatrolTransferView extends StatefulWidget {
  /// SCPatrolTransferController
  final SCPatrolTransferController state;

  const SCPatrolTransferView(
      {Key? key,
      required this.state,}) : super(key: key);

  @override
  SCPatrolTransferViewState createState() => SCPatrolTransferViewState();
}

class SCPatrolTransferViewState extends State<SCPatrolTransferView> {

  /// RefreshController
  RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return listView();
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
        onRefresh: onRefresh,
        onLoading: loadMore,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return cell(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10.0,);
          },
          itemCount: widget.state.dataList.length));
  }

  /// cell
  Widget cell(int index) {
    SCTenantUserModel model = widget.state.dataList[index];
    return GestureDetector(
      onTap: () {
        setState(() {
          if (model.id == widget.state.userId) {
            widget.state.userId = '';
          } else {
            widget.state.userId = model.id ?? '';
          }
        });
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
            Image.asset(model.id == widget.state.userId ? SCAsset.iconMaterialSelected : SCAsset.iconMaterialUnselect, width: 22.0, height: 22.0),
            const SizedBox(width: 12.0,),
            Expanded(child: middleItem(name: model.userName ?? '', mobile: model.mobileNum ?? '')),
          ],
        ),
      ),
    );
  }

  /// 姓名、手机号
  Widget middleItem({required String name, String? mobile}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: SCFonts.f16,
            color: SCColors.color_1B1D33,
            fontWeight: FontWeight.w400,
          ),),
        const SizedBox(height: 2.0,),
        Text(
          mobile ?? '',
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: SCFonts.f14,
            color: SCColors.color_4285F4,
            fontWeight: FontWeight.w400,
          ),)
      ],
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
