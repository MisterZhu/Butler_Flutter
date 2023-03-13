import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/AddEntry/sc_material_select_item.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../HouseInspect/View/sc_deliver_evidence_cell.dart';
import '../../../HouseInspect/View/sc_deliver_explain_cell.dart';

/// 基础信息cell

class SCBasicInfoCell extends StatefulWidget {
  /// 数据源
  final List list;

  /// 备注
  String? remark;

  /// 需要备注
  final bool requiredRemark;

  /// 需要添加图片
  final bool requiredPhotos;

  /// 图片数组
  final List? files;

  /// 盘点范围数组
  final List? rangeList;

  /// 点击选择
  final Function(int index, String title)? selectAction;

  /// 输入任务名称
  final Function(String content)? inputNameAction;

  /// 点击选择盘点范围
  final Function(int index)? selectRangeAction;

  /// 输入内容
  final Function(String content)? inputAction;

  /// 添加/删除图片
  final Function(List list)? updatePhoto;

  /// 范围
  final int? rangeValue;

  /// 是否可以编辑范围
  final bool? disableEditRange;

  SCBasicInfoCell({
    Key? key,
    required this.list,
    this.remark,
    this.files,
    this.selectAction,
    this.inputNameAction,
    this.inputAction,
    this.updatePhoto,
    this.selectRangeAction,
    required this.requiredRemark,
    required this.requiredPhotos,
    this.rangeList,
    this.rangeValue,
    this.disableEditRange
  }) : super(key: key);

  @override
  SCBasicInfoCellState createState() => SCBasicInfoCellState();
}

class SCBasicInfoCellState extends State<SCBasicInfoCell> {
  int selectRangeIndex = 0;

  @override
  Widget build(BuildContext context) {
    selectRangeIndex = (widget.rangeValue ?? 1) - 1;
    return body();
  }

  /// body
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleItem(),
        contentItem(),
      ],
    );
  }

  /// titleItem
  Widget titleItem() {
    return const Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 11.0),
      child: Text('基础信息',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w500,
              color: SCColors.color_1B1D33)),
    );
  }

  /// contentItem
  Widget contentItem() {
    return Container(
        decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(4.0)),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              selectListView(),
              line(),
              checkRangeItem(),
              inputItem(),
              photosItem(),
              const SizedBox(
                height: 12.0,
              ),
            ]));
  }

  /// selectListView
  Widget selectListView() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var dic = widget.list[index];
          bool disable = false;
          bool hideArrow = false;
          if (dic.containsKey('disable')) {
            disable = dic['disable'];
          }
          bool isInput = false;
          if (dic.containsKey('isInput')) {
            isInput = dic['isInput'];
          }
          if (dic.containsKey('hideArrow')) {
            hideArrow = dic['hideArrow'];
          }
          return SCMaterialSelectItem(
            isRequired: dic['isRequired'],
            title: dic['title'],
            isInput: isInput,
            content: dic['content'],
            disable: disable,
            hideArrow: hideArrow,
            selectAction: () {
              SCUtils().hideKeyboard(context: context);
              widget.selectAction?.call(index, dic['title']);
            },
            inputNameAction: (value) {
              widget.inputNameAction?.call(value);
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return line();
        },
        itemCount: widget.list.length);
  }

  /// 输入框
  Widget inputItem() {
    return Offstage(
      offstage: !widget.requiredRemark,
      child: Container(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
          child: SCDeliverExplainCell(
            title: '备注信息',
            content: widget.remark,
            inputHeight: 92.0,
            inputAction: (String content) {
              widget.inputAction?.call(content);
            },
          )),
    );
  }

  /// 图片
  Widget photosItem() {
    return Offstage(
      offstage: !widget.requiredPhotos,
      child: Container(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
          child: SCDeliverEvidenceCell(
            title: '上传照片',
            addIcon: SCAsset.iconMaterialAddPhoto,
            addPhotoType: SCAddPhotoType.all,
            files: widget.files ?? [],
            updatePhoto: (List list) {
              widget.updatePhoto?.call(list);
            },
          )),
    );
  }

  /// line
  Widget line() {
    return Offstage(
        offstage: widget.rangeList == null ? false : true,
        child: Container(
          color: SCColors.color_FFFFFF,
          padding: const EdgeInsets.only(left: 12.0),
          child: Container(
            height: 0.5,
            width: double.infinity,
            color: SCColors.color_EDEDF0,
          ),
        ));
  }

  /// 盘点范围
  Widget checkRangeItem() {
    return Offstage(
      offstage: widget.rangeList == null ? true : false,
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 12.0,
              alignment: Alignment.centerRight,
              child: const Text('*',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: SCFonts.f16,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_FF4040)),
            ),
            const SizedBox(
              width: 100.0,
              child: Text('盘点范围',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: SCFonts.f16,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_1B1D33)),
            ),
            const SizedBox(
              width: 12.0,
            ),
            Expanded(child: selectRangeItem()),
            const SizedBox(
              width: 12.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget selectRangeItem() {
    if (widget.rangeList != null) {
      return Wrap(
        alignment: WrapAlignment.start,
        spacing: 16.0,
        runSpacing: 10.0,
        children: widget.rangeList!
            .asMap()
            .keys
            .map((index) => rangeCell(index))
            .toList(),
      );
    } else {
      return const SizedBox();
    }
  }

  /// rangeCell
  Widget rangeCell(int index) {
    bool disableEditRange = widget.disableEditRange ?? false;
    return GestureDetector(
      onTap: () {
        if (!disableEditRange) {
          setState(() {
            selectRangeIndex = index;
            widget.selectRangeAction?.call(index);
          });
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            selectRangeIndex == index
                ? SCAsset.iconOpened
                : SCAsset.iconNotOpened,
            width: 18.0,
            height: 18.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            widget.rangeList?[index],
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: SCFonts.f16,
              color: disableEditRange ? SCColors.color_B0B1B8 : SCColors.color_1B1D33,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
