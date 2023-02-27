import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import '../../../../../Network/sc_config.dart';
import '../../Model/sc_material_list_model.dart';
import '../AddMaterial/sc_material_stepper.dart';

/// 详情cell
const int scMaterialCellTypeNormal = 0;

/// Radio cell
const int scMaterialCellTypeRadio = 1;

/// 删除cell
const int scMaterialCellTypeDelete = 2;

/// 盘点cell
const int scMaterialCellTypeInventory = 3;

/// 物资cell
class SCMaterialCell extends StatefulWidget {
  const SCMaterialCell(
      {Key? key,
      required this.type,
      this.model,
      this.onTap,
      this.numChangeAction,
      this.radioTap,
      this.deleteAction,
      this.hideMaterialNumTextField,
      this.status
      })
      : super(key: key);

  final SCMaterialListModel? model;

  /// cell点击
  final Function? onTap;

  /// radio点击
  final Function? radioTap;

  /// 数量改变回调
  final Function(int num)? numChangeAction;

  /// type
  final int type;

  /// 删除物资
  final Function? deleteAction;

  /// 隐藏物资数量输入框
  final bool? hideMaterialNumTextField;

  /// 盘点状态
  final int? status;

  @override
  SCMaterialCellState createState() => SCMaterialCellState();
}

class SCMaterialCellState extends State<SCMaterialCell> {
  /// 是否选中
  bool isSelect = false;

  @override
  initState() {
    super.initState();
  }

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
    } else if (widget.type == scMaterialCellTypeInventory) {
      return inventoryCell();
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
          detailInfoView(),
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
    return DecoratedBox(
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            deleteView(),
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

  /// 盘点cell
  Widget inventoryCell() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          inventoryImageView(),
          const SizedBox(
            width: 8.0,
          ),
          detailInfoView(),
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
    String url = SCConfig.getImageUrl(widget.model?.pic ?? '');
    return Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: SCColors.color_D9D9D9),
        child: SCImage(
          url: url,
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ));
  }

  /// 盘点的物资图片
  Widget inventoryImageView() {
    String url = SCConfig.getImageUrl(widget.model?.pic ?? '');
    bool isShow = true;
    if ((widget.status ?? 0) == 2 || (widget.status ?? 0) == 4) {
      isShow = true;
    } else {
      isShow = false;
    }
    return Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: SCColors.color_D9D9D9),
        child: Stack(
          children: [
            SCImage(
              url: url,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: isShow ? inventoryNumberView() : const SizedBox(height: 1,),
            )
          ],
        ));
  }

  /// 盘点数量view
  Widget inventoryNumberView() {
    int number = widget.model?.number ?? 0; // 账存
    int checkNum = widget.model?.checkNum ?? 0; // 盘点数量
    int? resultNum = widget.model?.resultNum ?? 0; // 盘盈或盘平数量
    Color bgColor = SCColors.color_F7F8FA;// 背景颜色
    Color textColor = SCColors.color_5E5F66;// 文字颜色
    String text = '';
    if (number < checkNum) {// 盘赢
      bgColor = SCColors.color_E3FFF1.withOpacity(0.9);
      textColor = SCColors.color_00B42A;
      text = "盘赢$resultNum";
    } else if (number > checkNum) {// 盘亏
      bgColor = SCColors.color_FFF1F0;
      textColor = SCColors.color_FF4040;
      text = "盘亏$resultNum";
    } else {// 盘平
      bgColor = SCColors.color_F7F8FA;
      textColor = SCColors.color_5E5F66;
      text = "盘平";
    }
    return Container(
      width: 80.0,
      height: 20.0,
      alignment: Alignment.center,
      color: bgColor,
      child: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: SCFonts.f12,
            fontWeight: FontWeight.w400,
            color: textColor),
      ),
    );
  }

  /// 物资信息-详情
  Widget detailInfoView() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [nameLabel(), infoLabel(10)],
    ));
  }

  /// 物资信息-选择
  Widget selectInfoView() {
    bool hidenNumTextField = widget.hideMaterialNumTextField ?? false;
    Widget stepper;
    if (hidenNumTextField) {
      stepper = const SizedBox(
        height: 1,
      );
    } else {
      stepper = SCStepper(
        num: widget.model?.localNum,
        numChangeAction: (int value) {
          widget.numChangeAction?.call(value);
        },
      );
    }
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
                  Expanded(
                    child: Container(color: Colors.transparent),
                  ),
                  stepper
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
                  Expanded(
                    child: Container(),
                  ),
                  SCStepper(
                    num: widget.model?.localNum,
                    numChangeAction: (int value) {
                      widget.numChangeAction?.call(value);
                    },
                  )
                ],
              )
            ],
          ))
        ],
      ),
    ));
  }

  /// 物资名称label
  Widget nameLabel() {
    String name = '';
    if (widget.model?.materialName != null) {
      name = widget.model?.materialName ?? '';
    }
    if (widget.model?.name != null) {
      name = widget.model?.name ?? '';
    }
    return Text(
      name,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1D33),
    );
  }

  /// 物资信息label
  Widget infoLabel(int maxLength) {
    String text = '';
    if (widget.type == scMaterialCellTypeInventory) {
      text =
          '单位:${widget.model?.unitName} 条形码:${widget.model?.barCode}\n规格:${widget.model?.norms}\n账面库存:${widget.model?.number}';
    } else {
      text =
          '单位:${widget.model?.unitName} 条形码:${widget.model?.barCode}\n规格:${widget.model?.norms}';
    }
    return Text(
      text,
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
    String text = '';
    if (widget.type == scMaterialCellTypeInventory) {// 盘点
      int checkNum = widget.model?.checkNum ?? 0;
      text = 'x$checkNum';
    } else {// 其他
      int num = widget.model?.number ?? 0;
      text = 'x$num';
    }
    return Padding(
      padding: const EdgeInsets.only(top: 22.0),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: SCColors.color_8D8E99),
      ),
    );
  }

  /// radio
  Widget radioView() {
    isSelect = widget.model?.isSelect ?? false;
    String path =
        isSelect ? SCAsset.iconMaterialSelected : SCAsset.iconMaterialUnselect;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          isSelect = !isSelect;
          widget.radioTap?.call(isSelect);
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

  /// 删除view
  Widget deleteView() {
    String path = SCAsset.iconDeleteMaterial;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.deleteAction?.call();
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
