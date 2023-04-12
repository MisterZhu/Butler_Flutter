/// 预警处理结果model
class SCWarningDealResultModel {
  SCWarningDealResultModel(
      {this.id, this.name, this.code, this.nameFull, this.pdictionary});

  SCWarningDealResultModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    nameFull = json['nameFull'];
    if (json['pdictionary'] != null) {
      pdictionary = [];
      json['pdictionary'].forEach((v) {
        pdictionary?.add(SCWarningDealResultModel.fromJson(v));
      });
    }
  }
  String? id;
  String? name;
  String? code;
  String? nameFull;
  List<SCWarningDealResultModel>? pdictionary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['code'] = code;
    map['nameFull'] = nameFull;
    map['pdictionary'] = pdictionary;
    return map;
  }
}
