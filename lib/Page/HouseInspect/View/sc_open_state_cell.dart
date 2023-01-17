
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../Constants/sc_asset.dart';

/// 正式验房-电表开启状态、度数cell

class SCOpenStateCell extends StatefulWidget {

  @override
  SCOpenStateCellState createState() => SCOpenStateCellState();
}

class SCOpenStateCellState extends State<SCOpenStateCell> {

  /// 电表controller
  TextEditingController electricController = TextEditingController();
  /// 电表focusNode
  FocusNode electricNode = FocusNode();
  /// 电表开启状态，默认未开启
  bool electricState = false;

  /// 水表controller
  TextEditingController waterController = TextEditingController();
  /// 水表focusNode
  FocusNode waterNode = FocusNode();
  /// 水表开启状态，默认未开启
  bool waterState = false;

  /// 气表controller
  TextEditingController gasController = TextEditingController();
  /// 气表focusNode
  FocusNode gasNode = FocusNode();
  /// 气表开启状态，默认未开启
  bool gasState = false;

  List list = [
    {'name': '电表', 'text': '电表度数', 'state': false},
    {'name': '水表', 'text': '水表读数',  'state': false},
    {'name': '气表', 'text': '气表读数',  'state': false},
  ];

  @override
  initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
      color: SCColors.color_FFFFFF,
      child: listView(),
    );
  }

  /// 活动列表
  Widget listView() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var dic = list[index];
          return cell(index, dic['name'], dic['state'], dic['text']);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line();
        },
        itemCount: list.length);
  }

  /// cell
  Widget cell(int index, String name, bool state, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topItem(index, name, state),
        bottomItem(index, text),
      ],
    );
  }

  /// topItem
  Widget topItem(int index, String name, bool state) {
    bool state = false;
    if (index == 1) {
      state = waterState;
    } else if (index == 2) {
      state = gasState;
    } else {
      state = electricState;
    }
    return Container(
        height: 48.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 114.0,
              child: Text(
                name,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: SCFonts.f16,
                  color: SCColors.color_1B1D33,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                notOpenedItem(index, state),
                openedItem(index, state),
              ],
            ),)
          ],
        )
    );
  }

  /// bottomItem
  Widget bottomItem(int index, String text) {
    return Offstage(
      offstage: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          line(),
          inputItem(index, text)
        ],
      ),
    );
  }

  /// 已开通Item
  Widget openedItem(int index, bool state) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (index == 1) {
            waterState = true;
          } else if (index == 2) {
            gasState = true;
          } else {
            electricState = true;
          }
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(state ? SCAsset.iconOpened : SCAsset.iconNotOpened, width: 24.0, height: 24.0, fit: BoxFit.cover,),
          const SizedBox(width: 6,),
          const Text(
            '已开通',
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: SCFonts.f16,
              color: SCColors.color_1B1D33,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

  /// 未开通Item
  Widget notOpenedItem(int index, bool state) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (index == 1) {
            waterState = false;
          } else if (index == 2) {
            gasState = false;
          } else {
            electricState = false;
          }
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(state ? SCAsset.iconNotOpened : SCAsset.iconOpened, width: 24.0, height: 24.0, fit: BoxFit.cover,),
          const SizedBox(width: 6,),
          const Text(
            '未开通',
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: SCFonts.f16,
              color: SCColors.color_1B1D33,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

  /// line
  Widget line() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  /// inputItem
  Widget inputItem(int index, String text) {
    return Container(
      height: 48.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 114.0,
            child: Text(
              text,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: SCFonts.f16,
                color: SCColors.color_1B1D33,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(child: textField(index),),
          unitItem(index),
        ],
      ),
    );
  }

  /// 单位item
  Widget unitItem(int index) {
    return Text(
      index == 0 ? '度' : '立方',
      textAlign: TextAlign.right,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: SCFonts.f16,
        color: SCColors.color_1B1D33,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget textField(int index) {
    if (index == 1) {
      return waterTextField();
    } else if (index == 2) {
      return gasTextField();
    } else {
      return electricTextField();
    }
  }

  /// textField
  Widget electricTextField() {
    return TextField(
      controller: electricController,
      maxLines: 1,
      cursorColor: SCColors.color_1B1C33,
      cursorWidth: 2,
      focusNode: electricNode,
      textAlign: TextAlign.left,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
      ],
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: "请填写电表度数",
        hintStyle: TextStyle(fontSize: 16, color: SCColors.color_B0B1B8),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        isCollapsed: true,
      ),
      onChanged: (value) {

      },
      keyboardType: TextInputType.text,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.done,
    );
  }

  /// waterTextField
  Widget waterTextField() {
    return TextField(
      controller: waterController,
      maxLines: 1,
      cursorColor: SCColors.color_1B1C33,
      cursorWidth: 2,
      focusNode: waterNode,
      textAlign: TextAlign.left,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
      ],
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: "请填写水表读数",
        hintStyle: TextStyle(fontSize: 16, color: SCColors.color_B0B1B8),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        isCollapsed: true,
      ),
      onChanged: (value) {

      },
      keyboardType: TextInputType.text,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.done,
    );
  }

  /// gasTextField
  Widget gasTextField() {
    return TextField(
      controller: gasController,
      maxLines: 1,
      cursorColor: SCColors.color_1B1C33,
      cursorWidth: 2,
      focusNode: gasNode,
      textAlign: TextAlign.left,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
      ],
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: "请填写气表读数",
        hintStyle: TextStyle(fontSize: 16, color: SCColors.color_B0B1B8),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        isCollapsed: true,
      ),
      onChanged: (value) {

      },
      keyboardType: TextInputType.text,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.done,
    );
  }

}