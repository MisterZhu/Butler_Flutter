import 'package:flutter/material.dart';

/// 详情cell-model
class SCUIDetailCellModel {
  SCUIDetailCellModel({
    this.type,
    this.title,
    this.titleColor,
    this.titleFontSize,
    this.subTitle,
    this.content,
    this.contentColor,
    this.contentFontSize,
    this.maxLength,
    this.subContent,
    this.time,
    this.leftIcon,
    this.rightIcon,
    this.fold,
    this.enableDetailTap,
    this.enableRightIconTap,
    this.tags,
    this.images,
  });

  SCUIDetailCellModel.fromJson(dynamic json) {
    type = json['type'];
    title = json['title'];
    titleColor = json['titleColor'];
    titleFontSize = json['titleFontSize'];
    subTitle = json['subTitle'];
    content = json['content'];
    contentColor = json['contentColor'];
    contentFontSize = json['contentFontSize'];
    maxLength = json['maxLength'];
    subContent = json['subContent'];
    time = json['time'];
    leftIcon = json['leftIcon'];
    rightIcon = json['rightIcon'];
    fold = json['fold'];
    enableDetailTap = json['enableDetailTap'];
    enableRightIconTap = json['enableRightIconTap'];
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) {
        tags?.add(SCTagsModel.fromJson(v));
      });
    }
    images = json['images'] != null ? json['images'].cast<String>() : [];
  }
  int? type; // cell类型：sc_cell_type.dart
  String? title; // 标题
  String? subTitle; // 子标题
  Color? titleColor; // 标题颜色
  double? titleFontSize; // 标题字体大小
  String? content; // 内容
  Color? contentColor; // 内容颜色
  double? contentFontSize; // 内容字体大小
  String? subContent;// 子内容
  int? maxLength; // 内容最大行数
  int? time; // 时间
  String? leftIcon; // 左侧icon
  String? rightIcon; // 右侧icon
  bool? fold; // 是否折叠
  bool? enableDetailTap; // 详情是否可以点击
  bool? enableRightIconTap; // 右侧icon是否可以点击
  List<SCTagsModel>? tags; // 标签
  List<String>? images; // 图片

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['title'] = title;
    map['titleColor'] = titleColor;
    map['titleFontSize'] = titleFontSize;
    map['subTitle'] = subTitle;
    map['content'] = content;
    map['contentColor'] = contentColor;
    map['contentFontSize'] = contentFontSize;
    map['maxLength'] = maxLength;
    map['subContent'] = subContent;
    map['time'] = time;
    map['leftIcon'] = leftIcon;
    map['rightIcon'] = rightIcon;
    map['fold'] = fold;
    map['enableDetailTap'] = enableDetailTap;
    map['enableRightIconTap'] = enableRightIconTap;
    if (tags != null) {
      map['tags'] = tags?.map((v) => v.toJson()).toList();
    }
    map['images'] = images;
    return map;
  }
}

class SCTagsModel {
  SCTagsModel({
    this.title,
    this.textColor,
    this.bgColor,
    this.borderColor,
  });

  SCTagsModel.fromJson(dynamic json) {
    title = json['title'];
    textColor = json['textColor'];
    bgColor = json['bgColor'];
    borderColor = json['borderColor'];
  }
  String? title;// title
  Color? textColor;// 文字颜色
  Color? bgColor;// 背景颜色
  Color? borderColor;// 边框颜色

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['textColor'] = textColor;
    map['bgColor'] = bgColor;
    map['borderColor'] = borderColor;
    return map;
  }
}
