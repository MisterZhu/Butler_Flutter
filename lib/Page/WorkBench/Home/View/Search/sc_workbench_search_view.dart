import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Search/sc_search_history_view.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Search/sc_workbench_search_result_cell.dart';
import '../../../../../Constants/sc_key.dart';
import '../../../../../Utils/sc_sp_utils.dart';
import '../../GetXController/sc_workbench_search_controller.dart';


/// 工作台-搜索view
class SCWorkBenchSearchView extends StatefulWidget {

  /// SCWorkBenchSearchController
  final SCWorkBenchSearchController state;

  SCWorkBenchSearchView({Key? key, required this.state,}) : super(key: key);


  @override
  SCWorkBenchSearchViewState createState() => SCWorkBenchSearchViewState();
}

class SCWorkBenchSearchViewState extends State<SCWorkBenchSearchView> {

  /// RefreshController
  RefreshController refreshController = RefreshController(initialRefresh: false);

  final TextEditingController controller = TextEditingController();

  final FocusNode node = FocusNode();

  bool showCancel = true;

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

  updateSearchView(String keywords) {
    controller.value = TextEditingValue(
        text: keywords,
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: keywords.length)));

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
            hintText: '输入关键字进行查询',
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
            if (value.isNotEmpty) {
              widget.state.saveHistoryData(value);
              widget.state.updateSearchString(value);
              widget.state.searchData(isMore: false);
              node.unfocus();
            } else {
              SCToast.showTip('搜索内容不能为空');
            }
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
        child: widget.state.showSearchResult == true ? listView() : historyView()
    );
  }

  /// 历史记录view
  Widget historyView() {
    return SCSearchHistoryView(
      list: widget.state.historyDataList,
      tapAction: (value) {
        updateSearchView(value);
        widget.state.saveHistoryData(value);
        widget.state.updateSearchString(value);
        widget.state.searchData(isMore: false);
        node.unfocus();
      },
      clearAction: () {
        widget.state.clearHistoryData();
      },
    );
  }

  /// listView
  Widget listView() {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return SCWorkBenchSearchCell(
            type: index,
            detailTapAction: () {

            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10.0,);
        },
        itemCount: 5);
  }

  /// emptyView
  Widget emptyView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 124.0,
        ),
        Image.asset(SCAsset.iconWorkBenchEmpty, width: 120.0, height: 120.0,),
        const SizedBox(
          height: 2.0,
        ),
        const Text("暂无搜索结果", style: TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: SCColors.color_8D8E99
        ),)
      ],
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

}