import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Mine/Home/Model/sc_community_common_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_space_model.dart';

/// 项目listView

class SCCommunityListView extends StatelessWidget {

  const SCCommunityListView({
    Key? key,
    required this.list,
    this.onTap,
  }) : super(key: key);

  /// 数据源-项目列表
  final List<SCCommunityCommonModel> list;

  /// 选择项目
  final Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.only(top: 2.0, left: 16.0, right: 22.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return cell(index);
        },
        itemCount: list.length);
  }

  /// cell
  Widget cell(int index) {
    SCCommunityCommonModel model = list[index];
    String title = model.title ?? '';
    Color color = SCColors.color_1B1D33;

    return GestureDetector(
      onTap: (){
        selectCommunity(index);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9.0),
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w400,
              color: color),
        ),
      ),
    );
  }

  /// separator
  Widget separator(int index) {
    return const SizedBox(
      height: 18.0,
    );
  }

  /// 选择项目
  selectCommunity(int index) {
    onTap?.call(index);
  }
}
