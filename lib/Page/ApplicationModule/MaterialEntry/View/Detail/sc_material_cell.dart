import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

import '../AddMaterial/sc_material_stepper.dart';

/// 物资cell

/// 详情cell
const int scMaterialCellTypeNormal = 0;

/// Radio cell
const int scMaterialCellTypeRadio = 1;

/// 删除cell
const int scMaterialCellTypeDelete = 2;

class SCMaterialCell extends StatefulWidget {
  const SCMaterialCell({Key? key, required this.type, this.onTap})
      : super(key: key);

  /// cell点击
  final Function? onTap;

  /// type
  final int type;

  @override
  SCMaterialCellState createState() => SCMaterialCellState();
}

class SCMaterialCellState extends State<SCMaterialCell> {
  /// 是否选中
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap?.call();
      },
      child: getCell(),
    );
  }

  /// 根据类型获取cell
  Widget getCell() {
    if (widget.type == scMaterialCellTypeRadio) {
      return radioCell();
    } else if (widget.type == scMaterialCellTypeDelete) {
      return deleteCell();
    } else {
      return normalCell();
    }
  }

  /// 详情cell
  Widget normalCell() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageView(),
          const SizedBox(
            width: 8.0,
          ),
          detailInfolView(),
          const SizedBox(
            width: 10.0,
          ),
          numView()
        ],
      ),
    );
  }

  /// 选择cell
  Widget radioCell() {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            radioView(),
            const SizedBox(
              width: 8.0,
            ),
            imageView(),
            const SizedBox(
              width: 8.0,
            ),
            selectInfoView(),
          ],
        ),
      ),
    );
  }

  /// 删除cell
  Widget deleteCell() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageView(),
          const SizedBox(
            width: 8.0,
          ),
          deleteInfoView(),
          const SizedBox(
            width: 10.0,
          ),
          numView()
        ],
      ),
    );
  }

  /// 物资图片
  Widget imageView() {
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0),
          color: SCColors.color_D9D9D9),
      child: Image.asset(
        SCAsset.iconTestMaterial,
        width: 80.0,
        height: 80.0,
      ),
    );
  }

  /// 物资信息-详情
  Widget detailInfolView() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [nameLabel(), infoLabel(10)],
    ));
  }

  /// 物资信息-选择
  Widget selectInfoView() {
    return Expanded(
        child: SizedBox(
          height: 80.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              nameLabel(),
              Expanded(
                  child: Row(
                    children: [
                      Expanded(child: infoLabel(2)),
                      Column(
                        children: [
                          Expanded(child: Container(color: Colors.orange,),),
                          SCStepper()
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  /// 物资信息-删除
  Widget deleteInfoView() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [nameLabel(), infoLabel(10)],
    ));
  }

  /// 物资名称label
  Widget nameLabel() {
    return const Text(
      '物资名称物资名称物资名称物资名称物资名称物资名称物资名称物资名称物资名称',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1D33),
    );
  }

  /// 物资信息label
  Widget infoLabel(int maxLength) {
    return Text(
      '型号:TG368 单位:个\n条码:87974389787',
      maxLines: maxLength,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
          fontSize: SCFonts.f12,
          fontWeight: FontWeight.w400,
          color: SCColors.color_8D8E99),
    );
  }

  /// 物资数量
  Widget numView() {
    return const Padding(
      padding: EdgeInsets.only(top: 22.0),
      child: Text(
        'x200',
        style: TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: SCColors.color_8D8E99),
      ),
    );
  }

  /// radio
  Widget radioView() {
    String path =
        isSelect ? SCAsset.iconMaterialSelected : SCAsset.iconMaterialUnselect;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          isSelect = !isSelect;
        });
      },
      child: Container(
        alignment: Alignment.center,
        width: 22.0,
        height: 80.0,
        child: Image.asset(
          path,
          width: 22.0,
          height: 22.0,
        ),
      ),
    );
  }
}
