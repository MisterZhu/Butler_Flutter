import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../PropertyFrmLoss/Model/sc_property_list_model.dart';
import '../../Controller/sc_add_material_controller.dart';
import '../../Model/sc_material_list_model.dart';
import '../Detail/sc_material_cell.dart';

/// 新增物资listView

class SCAddMaterialListView extends StatelessWidget {
  SCAddMaterialListView(
      {Key? key,
      required this.state,
      required this.list,
      required this.propertyList,
      required this.refreshController,
      this.radioTap,
      this.loadMoreAction,
      this.hideNumTextField,
      this.check,
      this.isProperty
      })
      : super(key: key);

  /// SCAddMaterialController
  final SCAddMaterialController state;

  /// list
  final List<SCMaterialListModel> list;

  /// list
  final List<SCMaterialListModel> propertyList;

  /// radio点击
  final Function? radioTap;

  /// RefreshController
  final RefreshController refreshController;

  /// 加载更多
  final Function? loadMoreAction;

  /// 隐藏数量输入框
  final bool? hideNumTextField;

  /// 是否是盘点物资
  final bool? check;

  /// 是否是资产
  final bool? isProperty;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: refreshController,
        enablePullUp: check == true ? false : true,
        enablePullDown: false,
        onLoading: loadMore,
        child: ListView.separated(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 11.0, bottom: 12.0),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              if (isProperty == true) {
                SCMaterialListModel model = propertyList[index];
                return propertyCell(model);
              } else {
                SCMaterialListModel model = list[index];
                return cell(model);
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return line(index);
            },
            itemCount: isProperty == true ? propertyList.length : list.length));
  }

  Widget propertyCell(SCMaterialListModel model) {
    return SCMaterialCell(
      hideMaterialNumTextField: hideNumTextField,
      propertyModel: model,
      type: scPropertyCellTypeRadio,
      check: check,
      radioTap: (bool value) {
        model.isSelect = value;
        radioTap?.call();
      },
    );
  }

  Widget cell(SCMaterialListModel model) {
    return SCMaterialCell(
      hideMaterialNumTextField: hideNumTextField,
      model: model,
      type: scMaterialCellTypeRadio,
      check: check,
      numChangeAction: (int value) {
        model.localNum = value;
        model.checkNum = value;
      },
      radioTap: (bool value) {
        model.isSelect = value;
        radioTap?.call();
      },
    );
  }

  /// line
  Widget line(int index) {
    return const SizedBox(
      height: 10.0,
    );
  }

  /// 下拉刷新
  Future onRefresh() async {
    state.loadMaterialListData(
        isMore: false,
        completeHandler: (bool success, bool last) {
          refreshController.refreshCompleted();
          refreshController.loadComplete();
        });
  }

  /// 上拉加载
  void loadMore() async {
    loadMoreAction?.call();
  }
}
