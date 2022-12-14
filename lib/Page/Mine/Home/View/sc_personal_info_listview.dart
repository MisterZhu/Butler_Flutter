import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Mine/Home/View/sc_setting_cell.dart';
import 'package:smartcommunity/skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/utils/Permission/sc_permission_utils.dart';
import 'package:smartcommunity/utils/Upload/sc_upload_utils.dart';
import '../../../../constants/sc_asset.dart';

/// 个人资料listview

class SCPersonalInfoListView extends StatelessWidget {
  const SCPersonalInfoListView(
      {Key? key, this.userHeadPicUrl = SCAsset.iconUserDefault})
      : super(key: key);

  /// 用户头像
  final String? userHeadPicUrl;

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index, context);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line();
        },
        itemCount: 5);
  }

  /// cell
  Widget getCell(int index, BuildContext context) {
    /// 头像
    String userPicUrl = userHeadPicUrl ?? SCAsset.iconUserDefault;

    if (index == 0) {
      return SCSettingCell(
        title: '头像',
        cellType: SCSettingCellType.imageArrowType,
        rightImage: userPicUrl,
        onTap: () {
          selectHeadPicAction();
        },
      );
    } else if (index == 1) {
      return SCSettingCell(
        title: '姓名',
        content: SCScaffoldManager.instance.user.nickName,
        cellType: SCSettingCellType.contentType,
      );
    } else if (index == 2) {
      String? phone = SCScaffoldManager.instance.user.mobileNum;
      String phoneText = phone?.replaceRange(3, 7, '****') ?? '';
      return SCSettingCell(
        title: '手机号',
        content: phoneText,
        cellType: SCSettingCellType.contentType,
        onTap: () {},
      );
    } else if (index == 3) {
      return SCSettingCell(
        title: '出生日期',
        content: '请选择',
        cellType: SCSettingCellType.contentArrowType,
        onTap: () {
          selectBirthdayAction();
        },
      );
    } else if (index == 4) {
      return roleItem();
    } else {
      return const SizedBox(
        height: 100.0,
      );
    }
  }

  /// 角色item
  Widget roleItem() {
    return Container(
      width: double.infinity,
      height: 68.0,
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: Text(
            '角色',
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w400,
                color: SCColors.color_1B1C33
            ),)),
          const SizedBox(width: 30.0,),
          gridView(),
        ],
      ),
    );
  }

  /// gridView
  Widget gridView() {
    return SizedBox(
      width: 170.0,
      child: StaggeredGridView.countBuilder(
          padding: EdgeInsets.zero,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          crossAxisCount: 2,
          shrinkWrap: true,
          itemCount: 4,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return cell();
          },
          staggeredTileBuilder: (int index) {
            return const StaggeredTile.fit(1);
          }),
    );
  }

  Widget cell() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      width: 72.0,
      height: 22.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0),
          color: SCColors.color_FFFFFF,
          border: Border.all(color: SCColors.color_8D8E99, width: 0.5)
      ),
      child: const Text(
        '集团管理员',
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: SCFonts.f12,
            fontWeight: FontWeight.w400,
            color: SCColors.color_5E5F66
        ),),
    );
  }

  Widget getLine(bool isLine) {
    if (isLine) {
      return line();
    } else {
      return line10();
    }
  }

  /// line
  Widget line() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.only(left: 12.0),
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  Widget line10() {
    return Container(
      height: 10.0,
      width: double.infinity,
      color: SCColors.color_F5F5F5,
    );
  }

  /// 选择头像
  selectHeadPicAction() {
    SCPermissionUtils.showImagePicker(completionHandler: (imagePath){
      print("图片路径:$imagePath");
      SCUploadUtils.uploadHeadPic(imagePath: imagePath);
    });
    // SCPermissionUtils.photoPicker(
    //     maxLength: 1,
    //     requestType: RequestType.image,
    //     completionHandler: (value) {
    //       List<AssetEntity> imageList = value;
    //       if (imageList.isNotEmpty) {
    //         AssetEntity assetEntity = imageList.first;
    //         String path = assetEntity.relativePath ?? SCAsset.iconMineUserHead;
    //         SCMineController controller = Get.find<SCMineController>();
    //         controller.changeUserHeadPic(url: path);
    //       }
    //     });
  }



  /// 选择出生日期
  selectBirthdayAction() {
    // SCPickerUtils pickerUtils = SCPickerUtils();
    // pickerUtils.completionHandler = (selectedValues, selecteds) {
    //   print('数据11:${selectedValues}');
    //   print('数据22:${selecteds}');
    // };
    //pickerUtils.showDatePicker(dateType: PickerDateTimeType.kYMD, columnFlex: [1, 1, 1]);
  }
}
