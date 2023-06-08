import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../../Constants/sc_asset.dart';

//可进行扩展，颜色字体等的设置，
class SelectBtnView extends StatefulWidget {
  String btnValue;
  bool selectStatus; //默认值
  Function(bool status)? fuc;

  SelectBtnView({Key? key, required this.btnValue, required this.selectStatus,this.fuc})
      : super(key: key);

  @override
  State<SelectBtnView> createState() => _SelectBtnViewState();
}

class _SelectBtnViewState extends State<SelectBtnView> {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                widget.selectStatus = !widget.selectStatus;
              });
              widget.fuc?.call(widget.selectStatus);
            },
            child: Container(
              alignment: Alignment.center,
              width: 38.0,
              height: 38.0,
              child: Image.asset(
                  widget.selectStatus
                      ? SCAsset.iconMaterialSelected
                      : SCAsset.iconMaterialUnselect,
                  width: 22.0,
                  height: 22.0),
            ),
          ),
          Text(
            widget.btnValue,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style:const TextStyle(
              fontSize: 17,
              color: SCColors.color_1B1D33,
              fontWeight: FontWeight.w400,
            ),
          )
        ]);
  }
}
