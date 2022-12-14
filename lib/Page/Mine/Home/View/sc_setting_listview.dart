
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Mine/Home/View/sc_setting_cell.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';

/// 设置listview

class SCSettingListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          bool isLine = true;
          if (index == 6 || index == 10) {
            isLine = false;
          }
          return getLine(isLine);
        },
        itemCount: 12);
  }
  
  Widget getCell(int index) {
    if (index == 0) {
      return SCSettingCell(title: '账户安全', onTap: (){
      },);
    } else if (index == 1) {
      return SCSettingCell(
        title: '清除缓存',
        content: '12.0KB',
        cellType: SCSettingCellType.contentType,
        onTap: (){

      },);
    } else if (index == 2) {
      return SCSettingCell(title: '检查更新', onTap: (){

      },);
    } else if (index == 3) {
      return SCSettingCell(title: '意见反馈', onTap: (){

      },);
    } else if (index == 4) {
      return SCSettingCell(title: '关于', onTap: (){

      },);
    } else if (index == 5) {
      return SCSettingCell(title: '用户协议', onTap: (){

      },);
    } else if (index == 6) {
      return SCSettingCell(title: '隐私政策', onTap: (){

      },);
    } else if (index == 7) {
      return SCSettingCell(title: '更换皮肤', onTap: (){

      },);
    } else if (index == 8) {
      return SCSettingCell(title: '消息设置', onTap: (){

      },);
    } else if (index == 9) {
      return SCSettingCell(title: '待办事项设置', onTap: (){

      },);
    } else if (index == 10) {
      return SCSettingCell(title: '底部导航栏设置', onTap: (){

      },);
    } else if (index == 11) {
      return logoutCell();
    } else {
      return const SizedBox(height: 100.0,);
    }
  }

  /// 退出登录
  Widget logoutCell() {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        color: SCColors.color_FFFFFF,
        borderRadius: BorderRadius.circular(0.0),
        child: const Text(
          "退出登录",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SCFonts.f16,
            fontWeight: FontWeight.w500,
            color: SCColors.color_1B1C33),
        ),
        onPressed: () {
          SCScaffoldManager.instance.logout();
        }),
    );
  }

  /// 分隔线
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
      color: SCColors.color_F2F3F5,
    );
  }
}
