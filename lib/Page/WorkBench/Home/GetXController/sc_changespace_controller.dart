import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Page/WorkBench/Home/GetXController/sc_workbench_controller.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_space_model.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';

/// 修改空间Controller

class SCChangeSpaceController extends GetxController {

  /// 已选择的空间列表
  List<SCSpaceModel> selectList = [];

  /// 空间列表
  List<SCSpaceModel> dataList = [];

  /// 当前节点id，不传入就返回最顶级节点
  String currentId = '';

  /// 当前节点类型，不传入返回的是最顶级节点
  int flag = 0;

  /// 是否需要组织节点，默认为true(返回组织节点)
  bool needOrgNode = true;

  /// 选择的空间model
  SCSpaceModel? spaceModel;

  /// 是否有下一级空间
  bool hasNextSpace = false;


  @override
  onInit() {
    super.onInit();
  }

  /// 初始化默认数据
  initBase({Function(String spaceName)? success}) {
    if (SCScaffoldManager.instance.defaultConfigModel != null) {
      var jsonValue = SCScaffoldManager.instance.defaultConfigModel!.jsonValue;
      List list = jsonDecode(jsonValue!);
      for (var element in List.from(list)) {
        SCSpaceModel model = SCSpaceModel.fromJson(element);
        selectList.add(model);
      }

      if (selectList.isNotEmpty) {
        SCSpaceModel model;
        if (selectList.length > 1) {
          model = selectList[selectList.length - 2];
          spaceModel = selectList.last;
        } else {
          model = selectList.first;
        }

        currentId = model.id ?? '';
        flag = model.flag ?? 0;
        needOrgNode = true;

        SCSpaceModel lastModel = selectList.last;
        Map<String, dynamic> header = SCHttpManager.instance.headers!;
        header['spaceIds'] = lastModel.id;
        SCHttpManager.instance.updateHeaders(headers: header);
        SCScaffoldManager.instance.spaceIds = lastModel.id;
        success?.call(lastModel.title ?? '');
      }
    }
  }

  /// 更新当前空间树数据
  updateCurrentSpace(String currentIdValue, int flagValue, bool needOrgNodeValue) {
    currentId = currentIdValue;
    flag = flagValue;
    needOrgNode = needOrgNodeValue;
  }

  /// 清空数据
  clearData() {
    currentId = '';
    flag = 0;
    needOrgNode = true;
    hasNextSpace = false;
    spaceModel = null;
    selectList.clear();
    dataList.clear();
  }

  /// 更新header已选择数据
  updateSelectData(SCSpaceModel model) {
    for (SCSpaceModel subModel1 in selectList) {
      print("现有已选的数据:${subModel1.toJson()}");
    }
    print("刚选的数据:${model.toJson()}");
    spaceModel = model;
    bool containsID = false;
    bool containsPid = false;
    int idIndex = -1;
    int pidIndex = -1;
    for (int i=0; i<selectList.length; i++) {
      SCSpaceModel subModel = selectList[i];
      if (subModel.id == model.id) {
        containsID = true;
        idIndex = i;
        break;
      }
    }
    for (int i=0; i<selectList.length; i++) {
      SCSpaceModel subModel = selectList[i];
      if (subModel.pid == model.pid) {
        containsPid = true;
        pidIndex = i;
        break;
      }
    }
    if (containsID == false) {
      if (containsPid) {
        if (pidIndex > 0) {
          selectList[pidIndex] = model;
        }
      } else {
        selectList.add(model);
      }
    } else {
      if (idIndex >= 0) {
        selectList[idIndex] = model;
      }
    }
  }

  /// 获取管理空间树
  loadManageTreeData({Function(List<SCSpaceModel> list)? success}) {
    var params = {
      "currentId": currentId,
      "flag": flag,
      "needOrgNode": needOrgNode,
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kSpaceTreeUrl,
        params: params,
        success: (value) {
          if (currentId.isEmpty) {
            List<SCSpaceModel> list = List<SCSpaceModel>.from(
                value.map((e) => SCSpaceModel.fromJson(e)).toList());
            if (list.isNotEmpty) {
              SCSpaceModel model = list.first;
              dataList = model.children ?? [];
              hasNextSpace = dataList.isNotEmpty ? true : false;
              update();
              success?.call(dataList);
            } else {
              SCSpaceModel model = SCSpaceModel.fromJson({"title" : SCScaffoldManager.instance.user.tenantName});
              hasNextSpace = false;
              dataList = [model];
              update();
              success?.call(dataList);
            }
          } else {
            List<SCSpaceModel> list = List<SCSpaceModel>.from(
                value.map((e) => SCSpaceModel.fromJson(e)).toList());
            dataList = list;
            hasNextSpace = list.isNotEmpty ? true : false;
            update();
            success?.call(dataList);
          }
        });
  }

  /// 选择空间
  selectSpace(int index, {Function(List<SCSpaceModel> list)? success}) {
    int subIndex = index - 1;
    spaceModel = null;
    if (subIndex < selectList.length) {
      SCSpaceModel model = selectList[subIndex];
      if (subIndex == 0) {
        selectList = selectList.sublist(0, 1);
      } else {
        if (selectList.length > 2) {
          selectList = selectList.sublist(0, subIndex + 1);
        }
      }
      updateCurrentSpace(model.id ?? '', model.flag ?? 0, true);
      loadManageTreeData();
    }
  }

  /// 确认切换空间
  switchSpace({Function? success}) {
    var params = {
      "id" : SCScaffoldManager.instance.defaultConfigModel?.id ,
      "userId" : SCScaffoldManager.instance.user.id,
      "tenantId" : SCScaffoldManager.instance.user.tenantId,
      "type" : 1,
      "jsonValue" : jsonEncode(selectList)
    };
    SCLoadingUtils.show(text: '');
    SCHttpManager.instance.post(url: SCUrl.kUserDefaultConfigUrl, params: params, success: (value){
      SCLoadingUtils.hide();
      success?.call();
    }, failure: (value){
      SCLoadingUtils.hide();
      String message = value['message'];
      SCToast.showTip(message);
    });
  }
}
