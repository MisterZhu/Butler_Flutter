import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Mine/Home/View/sc_setting_cell.dart';
import 'package:smartcommunity/Utils/Date/sc_date_utils.dart';
import 'package:smartcommunity/utils/Permission/sc_permission_utils.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';

/// 个人资料listview

class SCPersonalInfoListView extends StatelessWidget {
  const SCPersonalInfoListView(
      {Key? key,
      required this.userHeadPicUrl,
      this.birthday,
      this.updateUserHeadPicAction,
      this.updateBirthdayAction})
      : super(key: key);

  /// 用户头像
  final String userHeadPicUrl;

  /// 出生日期
  final String? birthday;

  /// 更新用户头像
  final Function(String path)? updateUserHeadPicAction;

  /// 更新出生日期
  final Function(String path)? updateBirthdayAction;

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
    if (index == 0) {
      return SCSettingCell(
        title: '头像',
        cellType: SCSettingCellType.imageArrowType,
        rightImage: userHeadPicUrl,
        onTap: () {
          selectHeadPicAction();
        },
      );
    } else if (index == 1) {
      return SCSettingCell(
        title: '姓名',
        content: SCScaffoldManager.instance.user.userName,
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
      String value;
      if (birthday == null || birthday == '') {
        value = '请选择';
      } else {
        value = birthday!;
      }
      return SCSettingCell(
        title: '出生日期',
        content: value,
        cellType: SCSettingCellType.contentArrowType,
        onTap: () {
          selectBirthdayAction(context);
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
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
            height: 48.0,
            child: const Text(
              '角色',
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: SCFonts.f16,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_1B1C33),
            ),
          )),
          const SizedBox(
            width: 30.0,
          ),
          gridView(),
        ],
      ),
    );
  }

  /// gridView
  Widget gridView() {
    List<String> list = SCScaffoldManager.instance.user.roleNames ?? [];
    if (list.length == 1) {
      return cell(list.first);
    } else {
      return SizedBox(
        width: 160.0,
        child: StaggeredGridView.countBuilder(
            padding: const EdgeInsets.only(top: 4.0),
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            crossAxisCount: 2,
            shrinkWrap: true,
            itemCount: list.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return cell(list[index]);
            },
            staggeredTileBuilder: (int index) {
              return const StaggeredTile.fit(1);
            }),
      );
    }
  }

  Widget cell(String name) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      width: 70.0,
      height: 22.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0),
          color: SCColors.color_FFFFFF,
          border: Border.all(color: SCColors.color_8D8E99, width: 0.5)),
      child: Text(
        name,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            fontSize: SCFonts.f12,
            fontWeight: FontWeight.w400,
            color: SCColors.color_5E5F66),
      ),
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
    SCPermissionUtils.showImagePicker(
        maxLength: 1,
        completionHandler: (imageList) {
          updateUserHeadPicAction?.call(imageList.first);
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
  selectBirthdayAction(BuildContext context) {
    SCPickerUtils pickerUtils = SCPickerUtils();
    pickerUtils.title = '出生日期';
    pickerUtils.pickerType = SCPickerType.date;
    pickerUtils.completionHandler = (selectedValues, selecteds) {
      String dateString = SCDateUtils.transformDate(
          dateTime: selectedValues.first,
          formats: ['yyyy', '-', 'mm', '-', 'dd']);
      updateBirthdayAction?.call(dateString);
    };
    pickerUtils.showDatePicker(
        context: context, dateType: PickerDateTimeType.kYMD);
  }
}
