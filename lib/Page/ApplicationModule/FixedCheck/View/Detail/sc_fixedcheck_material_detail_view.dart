import 'package:flutter/widgets.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/FixedCheck/View/Detail/sc_frmLoss_reason_alert.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../MaterialEntry/View/Detail/sc_material_bottom_view.dart';
import '../../Controller/sc_fixedcheck_material_detail_controller.dart';

class SCFixedCheckMaterialDetailView extends StatefulWidget {

  /// SCFixedCheckMaterialDetailController
  final SCFixedCheckMaterialDetailController state;

  SCFixedCheckMaterialDetailView({Key? key, required this.state}) : super(key: key);

  @override
  SCFixedCheckMaterialDetailViewState createState() => SCFixedCheckMaterialDetailViewState();
}

class SCFixedCheckMaterialDetailViewState extends State<SCFixedCheckMaterialDetailView> {

  /// 报损原因index
  int reasonIndex = 0;

  List list = [];

  @override
  void initState() {
    super.initState();
    list = [
      {'name':'物资名称', 'content': widget.state.materialModel.materialName ?? ''},
      {'name':'单位', 'content': widget.state.materialModel.unitName ?? ''},
      {'name':'条形码', 'content': widget.state.materialModel.barCode ?? ''},
      {'name':'规格', 'content': widget.state.materialModel.norms},
      {'name':'账面库存', 'content': '${widget.state.materialModel.number ?? 0}'}
    ];
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
    return GestureDetector(
      onTap: () {
        SCUtils().hideKeyboard(context: context);
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          listView(),
          Expanded(child: Container()),
          bottomView(),
        ],
      ),
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
                return cell(list[index]['name'] ?? '', list[index]['content'] ?? '', list[index]['isInput'] ?? false);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10.0,);
              },
              itemCount: list.length),
        ));
  }

  /// bottomView
  Widget bottomView() {
    List list = [{"type": scMaterialBottomViewType2, "title": "确定",}];
    return SCMaterialDetailBottomView(
        list: list,
        onTap: (value) {
          SCUtils().hideKeyboard(context: context);
          SCRouterHelper.back({'model': widget.state.materialModel});
        });
  }

  Widget cell(String leftText, String rightText, bool isInput) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        leftLabel(leftText),
        rightLabel(rightText, isInput)
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
  Widget rightLabel(String text, bool isInput) {
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

}