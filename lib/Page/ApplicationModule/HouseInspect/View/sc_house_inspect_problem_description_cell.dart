
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Constants/sc_asset.dart';
import '../../../../Utils/Permission/sc_permission_utils.dart';
import '../../../../Utils/sc_utils.dart';

/// 验房-问题-问题说明
class SCHouseInspectProblemDescriptionCell extends StatefulWidget {

  SCHouseInspectProblemDescriptionCell({ Key? key,}) : super(key: key);

  @override
  SCHouseInspectProblemDescriptionState createState() => SCHouseInspectProblemDescriptionState();
}

class SCHouseInspectProblemDescriptionState extends State<SCHouseInspectProblemDescriptionCell> {

  TextEditingController controller = TextEditingController();
  FocusNode node = FocusNode();

  List photosList = [];
  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
        color: SCColors.color_FFFFFF,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '问题说明：',
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: SCFonts.f16,
                  color: SCColors.color_1B1D33,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 12.0,),
              bottomItem(),
            ]
        )
    );
  }

  /// bottomItem
  Widget bottomItem() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: SCColors.color_F7F8FA,
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0, bottom: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          inputItem(),
          const SizedBox(height: 14.0,),
          photosItem(),
          const SizedBox(height: 6.0,),
          tipsItem(),
        ],
      ),
    );
  }

  /// inputItem
  Widget inputItem() {
    return SizedBox(
      width: double.infinity,
      height: 66.0,
      child: roomTextField(),
    );
  }

  /// textField
  Widget roomTextField() {
    return TextField(
      controller: controller,
      maxLines: null,
      style: const TextStyle(fontSize: SCFonts.f14, fontWeight:  FontWeight.w400, color: SCColors.color_1B1D33),
      cursorColor: SCColors.color_1B1C33,
      cursorWidth: 2,
      focusNode: node,
      inputFormatters: [
        LengthLimitingTextInputFormatter(200),
      ],
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: "请输入详细内容(非必填)",
        hintStyle: TextStyle(fontSize: 14, color: SCColors.color_B0B1B8),
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

  /// photosItem
  Widget photosItem() {
    return StaggeredGridView.countBuilder(
        padding: EdgeInsets.zero,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 4,
        shrinkWrap: true,
        itemCount: photosList.length + 1,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return photoItem(index);
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

  /// 图片
  Widget photoItem(int index) {
    return GestureDetector(
      onTap: () {
        SCUtils().hideKeyboard(context: context);
        if (index == photosList.length) {
          SCPermissionUtils.showImagePicker(
            maxLength: 1,
            completionHandler: (imageList) {
              setState(() {
                photosList.add(imageList.first);
              });
            });
        }
      },
      child: SizedBox(
        width: 79.0,
        height:  79.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child:Image.asset(
            index == photosList.length ? SCAsset.iconInspectProblemAddPhoto : photosList[index],
            width: 79.0,
            height:  79.0,
            fit: BoxFit.fill,),
        )
      ),
    );
  }

  /// tipsItem
  Widget tipsItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(SCAsset.iconInspectProblemTips, width: 22.0, height:  22.0,),
        const SizedBox(width: 4.0,),
        const Expanded(child: Text(
          '请拍摄清晰的照片，并标记问题的部位',
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: SCFonts.f12,
            color: SCColors.color_8D8E99,
            fontWeight: FontWeight.w400,
          ),
        ))
      ],
    );
  }

}