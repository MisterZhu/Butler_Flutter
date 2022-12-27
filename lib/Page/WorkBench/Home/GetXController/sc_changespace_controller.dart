import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_space_model.dart';

/// 修改空间Controller

class SCChangeSpaceController extends GetxController {
  List<SCSpaceModel> dataList = [];

  /// 当前节点id，不传入就返回最顶级节点
  String currentId = '';

  /// 当前节点类型，不传入返回的是最顶级节点
  int flag = 0;

  /// 是否需要组织节点，默认为true(返回组织节点)
  bool needOrgNode = true;

  /// 当前title
  String title = '';

  /// 是否有下一级空间
  bool hasNextSpace = true;

  /// 没有下一级空间时，最后选择的index
  int lastIndex = 0;

  @override
  onInit() {
    super.onInit();
  }

  /// 更新当前空间树数据
  updateCurrentSpace(String currentIdValue, int flagValue, bool needOrgNodeValue, String titleValue) {
    currentId = currentIdValue;
    flag = flagValue;
    needOrgNode = needOrgNodeValue;
    title = titleValue;
  }

  /// 清空数据
  clearData() {
    currentId = '';
    flag = 0;
    needOrgNode = true;
    hasNextSpace = true;
    lastIndex = 0;
    dataList.clear();
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
          print('空间树==========$value');
          if (currentId.isEmpty) {
            List<SCSpaceModel> list = List<SCSpaceModel>.from(
                value.map((e) => SCSpaceModel.fromJson(e)).toList());
            SCSpaceModel model = list.first;
            hasNextSpace = model.children?.isNotEmpty ?? true;
            dataList.add(model);
            update();
            success?.call(dataList);
          } else {
            var data = [{
              "id" : currentId,
              "flag" : flag,
              "needOrgNode" : needOrgNode,
              "title" : title,
              "children" : value
            }];
            List<SCSpaceModel> list = List<SCSpaceModel>.from(
                data.map((e) => SCSpaceModel.fromJson(e)).toList());
            SCSpaceModel model = list.first;
            hasNextSpace = model.children?.isNotEmpty ?? false;
            if (hasNextSpace) {
              dataList.add(model);
            }
            update();
            success?.call(dataList);
          }
        });
  }

  /// 切换空间
  switchSpace(int index, {Function(List<SCSpaceModel> list)? success}) {
    SCSpaceModel model = dataList[index];
    if (hasNextSpace) {
      if (index == 0) {
        updateCurrentSpace('', 0, true, '');
      } else {
        updateCurrentSpace(model.id ?? '', model.flag ?? 0, true, model.title ?? '');
      }
    } else {
      if (index == 0) {
        updateCurrentSpace('', 0, true, '');
      } else if (index == dataList.length) {
        updateCurrentSpace(currentId, flag, true, title);
      } else {
        updateCurrentSpace(model.id ?? '', model.flag ?? 0, true, model.title ?? '');
      }
    }
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
          print('空间树==========$value');
          if (index == 0) {
            List<SCSpaceModel> list = List<SCSpaceModel>.from(
                value.map((e) => SCSpaceModel.fromJson(e)).toList());
            SCSpaceModel model = list.first;
            hasNextSpace = model.children?.isNotEmpty ?? true;
            dataList[index] = model;
            dataList = dataList.sublist(0, index > 0 ? index : 1);
            update();
            success?.call(dataList);
          } else {
            var data = [{
              "id" : currentId,
              "flag" : flag,
              "needOrgNode" : needOrgNode,
              "title" : title,
              "children" : value
            }];
            List<SCSpaceModel> list = List<SCSpaceModel>.from(
                data.map((e) => SCSpaceModel.fromJson(e)).toList());
            SCSpaceModel model = list.first;
            hasNextSpace = model.children?.isNotEmpty ?? false;
            if (hasNextSpace) {
              dataList[index] = model;
              dataList = dataList.sublist(0, index > 0 ? index : 1);
            }
            update();
            success?.call(dataList);
          }
        });
  }
}
