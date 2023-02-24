import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

import '../../Model/sc_check_selectcategory_model.dart';

/// 选择分类-header

class SCCheckSelectCategoryHeaderView extends StatefulWidget {
  const SCCheckSelectCategoryHeaderView({Key? key, required this.list, this.onTap})
      : super(key: key);

  final List<SCCheckSelectCategoryModel> list;

  /// cell 点击
  final Function(int index)? onTap;

  @override
  SCCheckSelectCategoryHeaderViewState createState() =>
      SCCheckSelectCategoryHeaderViewState();
}

class SCCheckSelectCategoryHeaderViewState
    extends State<SCCheckSelectCategoryHeaderView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      alignment: Alignment.centerLeft,
      child: listView(),
    );
  }

  /// listView
  Widget listView() {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return cell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line(index);
        },
        itemCount: widget.list.length);
  }

  /// cell
  Widget cell(int index) {
    SCCheckSelectCategoryModel model = widget.list[index];
    String title = model.title ?? '';
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        widget.onTap?.call(index);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        height: 40.0,
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_1B1D33),
        ),
      ),
    );
  }

  /// line
  Widget line(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Image.asset(
        SCAsset.iconArrowRight,
        width: 16.0,
        height: 16.0,
      ),
    );
  }
}
