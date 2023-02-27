
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../MaterialEntry/View/Detail/sc_material_bottom_view.dart';
import '../../Controller/sc_check_material_detail_controller.dart';

/// 盘点-物资详情view

class SCCheckMaterialDetailView extends StatefulWidget {

  /// SCMaterialCheckController
  final SCCheckMaterialDetailController state;

  SCCheckMaterialDetailView({Key? key, required this.state}) : super(key: key);

  @override
  SCCheckMaterialDetailViewState createState() => SCCheckMaterialDetailViewState();
}

class SCCheckMaterialDetailViewState extends State<SCCheckMaterialDetailView> {

  List list = [];

  @override
  void initState() {
    super.initState();
    list = [
      {'name':'物资名称', 'content': widget.state.materialModel.materialName ?? ''},
      {'name':'单位', 'content': widget.state.materialModel.unitName ?? ''},
      {'name':'条形码', 'content': widget.state.materialModel.barCode ?? ''},
      {'name':'规格', 'content': widget.state.materialModel.norms},
      {'name':'账面库存', 'content': '${widget.state.materialModel.number ?? 0}'},
      {'name':'盘点数量', 'content': '${widget.state.materialModel.checkNum ?? 0}'},];
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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          listView(),
          Expanded(child: Container()),
          bottomView(),
        ],
    );
  }

  Widget listView() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
        color: SCColors.color_FFFFFF,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return cell(list[index]['name'] ?? '', list[index]['content'] ?? '');
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10.0,);
          },
          itemCount: list.length),
    ));
  }

  /// bottomView
  Widget bottomView() {
    List list = [{"type": scMaterialBottomViewType2, "title": "提交",}];
    return SCMaterialDetailBottomView(
        list: list,
        onTap: (value) {
          SCRouterHelper.back({'model': widget.state.materialModel});
        });
  }

  Widget cell(String leftText, String rightText) {
    return Row(
      children: [
        leftLabel(leftText),
        rightLabel(rightText)
      ],
    );
  }

  /// leftLabel
  Widget leftLabel(String text) {
    return SizedBox(
      width: 100.0,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        strutStyle: const StrutStyle(
          fontSize: SCFonts.f14,
          height: 1.25,
          forceStrutHeight: true,
        ),
        style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_5E5F66,
        ),
      ),
    );
  }

  /// rightLabel
  Widget rightLabel(String text) {
    return Expanded(
        child: Text(
          text,
          textAlign: TextAlign.right,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          strutStyle: const StrutStyle(
            fontSize: SCFonts.f14,
            height: 1.25,
            forceStrutHeight: true,
          ),
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_1B1D33),
        ));
  }
}