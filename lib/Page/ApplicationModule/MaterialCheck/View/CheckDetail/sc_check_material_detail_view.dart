
import 'package:flutter/material.dart';
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


  @override
  void initState() {
    super.initState();
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
    return Container();
  }
}