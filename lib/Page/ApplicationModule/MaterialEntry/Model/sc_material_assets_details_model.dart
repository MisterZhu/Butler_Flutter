import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_list_model.dart';
/// 资产详情列表model
class SCMaterialAssetsDetailsModel {
  SCMaterialAssetsDetailsModel({
      this.assetsDetails,
      this.materialInfo,
      this.num, 
      this.result,});

  SCMaterialAssetsDetailsModel.fromJson(dynamic json) {
    if (json['assetsDetails'] != null) {
      assetsDetails = [];
      json['assetsDetails'].forEach((v) {
        assetsDetails?.add(SCMaterialListModel.fromJson(v));
      });
    }
    if (json['materialInfo'] != null) {
      materialInfo = SCMaterialListModel.fromJson(json['materialInfo']);
    }
    num = json['num'];
    result = json['result'];
  }
  List<SCMaterialListModel>? assetsDetails;
  SCMaterialListModel? materialInfo;
  int? num;
  String? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (assetsDetails != null) {
      map['assetsDetails'] = assetsDetails?.map((v) => v.toJson()).toList();
    }
    // if (materialInfo != null) {
    //   map['materialInfo'] = materialInfo?.map((v) => v.toJson()).toList();
    // }
    map['num'] = num;
    map['result'] = result;
    return map;
  }

}