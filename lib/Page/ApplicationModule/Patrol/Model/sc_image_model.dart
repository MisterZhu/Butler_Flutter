class Attachment {
  String? id;
  bool? isImage;
  String? name;
  String? suffix;
  String? url;
  String? fileKey;
  String? size;
  String? type;

  Attachment({this.id, this.isImage, this.name, this.suffix, this.url,
    this.fileKey, this.size, this.type});

  Attachment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isImage = json['isImage'];
    name = json['name'];
    suffix = json['suffix'];
    url = json['url'];
    fileKey = json['fileKey'];
    size = json['size'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isImage'] = isImage;
    data['name'] = name;
    data['suffix'] = suffix;
    data['url'] = url;
    data['fileKey'] = fileKey;
    data['size'] = size;
    data['type'] = type;
    return data;
  }
}
