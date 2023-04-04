import 'package:smartcommunity/Network/sc_http_manager.dart';

/// 网络请求类型
enum SCRequestMethod { get, post, put, delete }

/// 基础网络请求
class SCBaseRequest {
  int pageNum = 1;
  int pageSize = 20;
  Map<String, dynamic> params = {};
  bool isQuery = false;
  SCRequestMethod method = SCRequestMethod.get;
  String url = '';

  /// 网络请求
  Future? startRequest(
      Function(dynamic value)? success, Function(dynamic value)? failure) {
    params['pageNum'] = pageNum;
    params['pageSize'] = pageSize;
    if (method == SCRequestMethod.get) {
      return SCHttpManager.instance
          .get(url: url, params: params, success: success, failure: failure);
    } else if (method == SCRequestMethod.post) {
      return SCHttpManager.instance.post(
          url: url,
          isQuery: isQuery,
          params: params,
          success: success,
          failure: failure);
    } else if (method == SCRequestMethod.put) {
      return SCHttpManager.instance
          .put(url: url, params: params, success: success, failure: failure);
    } else if (method == SCRequestMethod.delete) {
      return SCHttpManager.instance
          .delete(url: url, params: params, success: success, failure: failure);
    } else {
      return Future(() => false);
    }
  }

  /// 下一页
  Future? startNextRequest(
      Function(dynamic value)? success, Function(dynamic value)? failure) {
    pageNum++;
    params['pageNum'] = pageNum;
    params['pageSize'] = pageSize;
    if (method == SCRequestMethod.get) {
      return SCHttpManager.instance.get(
          url: url,
          params: params,
          success: (value) {
            success?.call(value);
          },
          failure: (value) {
            pageNum--;
            failure?.call(value);
          });
    } else if (method == SCRequestMethod.post) {
      return SCHttpManager.instance.post(
          url: url,
          isQuery: isQuery,
          params: params,
          success: (value) {
            success?.call(value);
          },
          failure: (value) {
            pageNum--;
            failure?.call(value);
          });
    } else if (method == SCRequestMethod.put) {
      return SCHttpManager.instance.put(
          url: url,
          params: params,
          success: (value) {
            success?.call(value);
          },
          failure: (value) {
            pageNum--;
            failure?.call(value);
          });
    } else if (method == SCRequestMethod.delete) {
      return SCHttpManager.instance.delete(
          url: url,
          params: params,
          success: (value) {
            success?.call(value);
          },
          failure: (value) {
            pageNum--;
            failure?.call(value);
          });
    } else {
      return Future(() => false);
    }
  }
}
