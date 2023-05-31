class ScanResultModel {
  String? code;
  String? url;

  ScanResultModel({this.code, this.url});

  ScanResultModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['url'] = url;
    return data;
  }
}
