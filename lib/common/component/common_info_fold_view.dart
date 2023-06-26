import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../Constants/sc_asset.dart';

class ComInfoFloldView extends StatefulWidget {

  String title;
  String content;

  ComInfoFloldView({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  State<ComInfoFloldView> createState() => _ComInfoFloldViewState();
}

class _ComInfoFloldViewState extends State<ComInfoFloldView> {
  String data = "";
  bool isShowFold = false;
  bool isFold = false;

  @override
  void initState() {
    super.initState();
    if (widget.content.length > 20) {
      data = widget.content.substring(0, 18);
      isShowFold = true;
    } else {
      data = widget.content;
      isShowFold = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [body(context)],
      ),
    );
  }

  /// body
  Widget body(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleCell(),
        const SizedBox(
          height: 10.0,
        ),
        contentCell(),
        getCell()
      ],
    );
  }

  Widget getCell() {
    if (isShowFold) {
      return showFoldView();
    }
    return Container();
  }

  /// 标题
  Widget titleCell() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        widget.title ?? '',
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            fontSize: SCFonts.f16,
            fontWeight: FontWeight.w500,
            color: SCColors.color_1B1D33),
      ),
    );
  }

  /// 内容
  Widget contentCell() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
        child: Text(
          data ?? '',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: SCFonts.f15,
              fontWeight: FontWeight.w500,
              color: SCColors.color_8D8E99),
        ));
  }

  Widget showFoldView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isFold = !isFold;
            });
          },
          child: Text(isFold ? "收起" : "展开",
              style: const TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                  color: Color(0xFF8D8E99))),
        ),
        Image.asset(
          isFold ? SCAsset.iconArrowTop : SCAsset.iconArrowBottom,
          width: 15.0,
          height: 15.0,
        )
      ],
    );
  }


  @override
  void dispose() {
    super.dispose();
  }
}
