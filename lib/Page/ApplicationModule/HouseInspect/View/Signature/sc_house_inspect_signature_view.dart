import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

import 'sc_signature.dart';

/// 签名view

class SCSignatureView extends StatefulWidget {
  const SCSignatureView({Key? key, required this.controller}) : super(key: key);

  final SignatureController controller;

  @override
  SCSignatureViewState createState() => SCSignatureViewState();
}

class SCSignatureViewState extends State<SCSignatureView> {
  /// 是否隐藏"签署区"
  bool isEmpty = false;

  @override
  initState() {
    super.initState();
    if (widget.controller.value.isNotEmpty) {
      isEmpty = false;
    } else {
      isEmpty = true;
    }

    // 监听画板
    widget.controller.addListener(() {
      bool tmpIsEmpty = true;
      if (widget.controller.value.isNotEmpty) {
        tmpIsEmpty = false;
      } else {
        tmpIsEmpty = true;
      }
      if (isEmpty != tmpIsEmpty) {
        if (mounted) {
          setState(() {
            isEmpty = tmpIsEmpty;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Padding(
        padding: EdgeInsets.only(
            left: SCUtils().getTopSafeArea(),
            top: 16.0,
            right: SCUtils().getBottomSafeArea()),
        child: Column(
          children: [
            topView(),
            bottomView(context),
          ],
        ),
      ),
    );
  }

  /// top-签名区
  Widget topView() {
    return Expanded(
        child: Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          alignment: Alignment.center,
          children: [
            signatureTipView(),
            signatureView(
                width: constraints.maxWidth, height: constraints.maxHeight),
            backBtn()
          ],
        );
      }),
    ));
  }

  /// bottom-按钮
  Widget bottomView(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          rewriteBtn(context),
          const SizedBox(
            width: 16.0,
          ),
          sureBtn()
        ],
      ),
    );
  }

  /// 返回按钮
  Widget backBtn() {
    return Positioned(
        left: 26.0,
        top: 24.0,
        child: SizedBox(
          width: 40.0,
          height: 40.0,
          child: CupertinoButton(
              minSize: 40.0,
              padding: EdgeInsets.zero,
              child: Image.asset(
                SCAsset.iconInspectBack,
                width: 40.0,
                height: 40.0,
              ),
              onPressed: () {
                backAction();
              }),
        ));
  }

  /// 签名view
  Widget signatureView({required double width, required double height}) {
    return Signature(
      key: const Key('signature'),
      controller: widget.controller,
      backgroundColor: Colors.transparent,
      height: width,
      width: width,
    );
  }

  /// 提示"签署区"
  Widget signatureTipView() {
    return Offstage(
      offstage: isEmpty ? false : true,
      child: const Text(
        '签 署 区',
        style: TextStyle(
            fontSize: 140,
            color: SCColors.color_E3E3E6,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  /// 重写按钮
  Widget rewriteBtn(BuildContext context) {
    return Container(
      width: 96.0,
      height: 40.0,
      decoration: BoxDecoration(
          border: Border.all(color: SCColors.color_4285F4, width: 1.0)),
      child: CupertinoButton(
          minSize: 40.0,
          padding: EdgeInsets.zero,
          child: const Text(
            '重写',
            style: TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w400,
                color: SCColors.color_4285F4),
          ),
          onPressed: () {
            rewriteAction();
          }),
    );
  }

  /// 确定按钮
  Widget sureBtn() {
    return Container(
      width: 96.0,
      height: 40.0,
      decoration: BoxDecoration(
          color: SCColors.color_4285F4,
          borderRadius: BorderRadius.circular(4.0)),
      child: CupertinoButton(
          minSize: 40.0,
          padding: EdgeInsets.zero,
          child: const Text(
            '确定',
            style: TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w400,
                color: SCColors.color_FFFFFF),
          ),
          onPressed: () {
            sureAction(context);
          }),
    );
  }

  /// 返回
  backAction() {
    SCRouterHelper.back(null);
  }

  /// 重写
  rewriteAction() {
    widget.controller.clear();
  }

  /// 确定
  sureAction(BuildContext context) {
    exportImage(context);
  }

  Future<void> exportImage(BuildContext context) async {
    if (widget.controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          key: Key('snackbarPNG'),
          content: Text('No content'),
        ),
      );
      return;
    }

    final Uint8List? data = await widget.controller.toPngBytes();
    if (data == null) {
      return;
    }

    if (!mounted) return;

    await push(
      context,
      Scaffold(
        appBar: AppBar(
          title: const Text('PNG Image'),
        ),
        body: Center(
          child: Container(
            color: Colors.grey[300],
            child: Image.memory(data),
          ),
        ),
      ),
    );
  }
}

Future push(context, widget) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
        return widget;
      },
    ),
  );
}
