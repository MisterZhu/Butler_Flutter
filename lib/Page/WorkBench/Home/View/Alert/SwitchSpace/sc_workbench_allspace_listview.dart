import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_space_model.dart';

/// 空间listView

class SCAllSpaceListView extends StatelessWidget {

  const SCAllSpaceListView({
    Key? key,
    required this.list,
    required this.hasNextSpace,
    required this.lastIndex,
    this.onTap
  }) : super(key: key);

  /// 数据源-空间列表
  final List<SCSubSpaceModel> list;

  /// 选择空间
  final Function(int index, SCSubSpaceModel model)? onTap;

  /// 是否有下一级空间
  final bool hasNextSpace;

  /// 没有下一级空间时，最后选择的index
  final int lastIndex;

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
    SCSubSpaceModel model = list[index];
    String title = model.title ?? '';
    Color color;
    if (hasNextSpace) {
      color = SCColors.color_1B1D33;
    } else {
      if (index == lastIndex) {
        color = SCColors.color_4285F4;
      } else {
        color = SCColors.color_1B1D33;
      }
    }
    return GestureDetector(
      onTap: (){
        selectSpace(index, model);
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

  /// 选择空间
  selectSpace(int index, SCSubSpaceModel model) {
    onTap?.call(index, model);
  }
}
