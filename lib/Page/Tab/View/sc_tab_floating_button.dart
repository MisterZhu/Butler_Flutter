import 'package:flutter/material.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

/// tab-floating

class SCTabFloatingButton extends StatelessWidget {

  const SCTabFloatingButton({
    Key? key,
    this.onPressed
  }) : super(key: key);

  /// 点击
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        onPressed?.call();
      },
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.only(top: 2.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF76AAFF),
                Color(0xFF0959DE),
              ],
            )
        ),
        child: Image.asset(SCAsset.iconTabFloating, width: 22.0, height: 21.0,),
      ),
    );
  }
}
