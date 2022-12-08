import 'package:flutter/cupertino.dart';

/// 工作台-header

class SCWorkBenchHeader extends StatelessWidget {

  const SCWorkBenchHeader({
    Key? key,
    required this.height
  }) : super(key: key);

  /// 组件高度
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: body(context),
    );
  }

  /// body
  Widget body(BuildContext context) {
    return Column();
  }
}