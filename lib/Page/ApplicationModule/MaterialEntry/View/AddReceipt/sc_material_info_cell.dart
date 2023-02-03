
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../../Constants/sc_asset.dart';

/// 物资信息cell

class SCMaterialInfoCell extends StatelessWidget {

  /// 选择仓库名称
  final Function? selectNameAction;

  /// 选择类型
  final Function? selectTypeAction;

  /// 点击新增
  final Function? addAction;

  SCMaterialInfoCell({Key? key,
    this.selectNameAction,
    this.selectTypeAction,
    this.addAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleItem(),
        numItem(),
        const SizedBox(height: 6.0,),
        listview(),
      ],
    );
  }

  /// titleItem
  Widget titleItem() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: Text(
            '物资信息',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w500,
              color: SCColors.color_1B1D33)),
          ),
          topRightItem(),
        ],
      )
    );
  }

  /// 新增
  Widget topRightItem() {
    return GestureDetector(
      onTap: () {
        addAction?.call();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            SCAsset.iconMaterialAdd,
            width: 18.0,
            height: 18.0,
          ),
          const SizedBox(width: 6.0,),
          const Text(
              '新增',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_4285F4)),
        ],
      ),
    );
  }

  /// 数量
  Widget numItem() {
    return Text(
        '共 2 种物资  总数量 10共 2 种物资  总数量 20共 3 种物资  总数量 30共 4 种物资  总数量 40共 5 种物资  总数量 50',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: SCColors.color_5E5F66));
  }

  Widget listview() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return cell();
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10.0,);
        },
        itemCount: 4);
  }

  Widget cell() {
    return Container(height: 100, color: SCColors.color_FFFFFF,);
  }
}