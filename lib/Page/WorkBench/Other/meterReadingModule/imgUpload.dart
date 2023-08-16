import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Utils/Upload/sc_upload_utils.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import '../../../../Constants/sc_asset.dart';
import '../../../../Constants/sc_enum.dart';
import '../../../../Network/sc_config.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/Permission/sc_permission_utils.dart';
import '../../../../Utils/Preview/sc_image_preview_utils.dart';
import '../../../../Utils/sc_utils.dart';

/// 标题+添加图片cell

class ImgUpload extends StatefulWidget {
  /// 标题
  final String title;

  /// 添加图片icon
  final String addIcon;

  /// 添加图片的类型
  final SCAddPhotoType addPhotoType;

  /// 最多可添加图片的数量，默认8张
  final int maxCount;

  /// 添加/删除图片
  final Function(List list)? updatePhoto;

  /// 图片数组
  final List files;

  final bool isNew;

  const ImgUpload(
      {Key? key,
        required this.title,
        this.addIcon = SCAsset.iconInspectProblemAddPhoto,
        this.addPhotoType = SCAddPhotoType.all,
        this.maxCount = 8,
        required this.files,
        this.updatePhoto,
        this.isNew = true})
      : super(key: key);

  @override
  ImgUploadState createState() => ImgUploadState();
}

class ImgUploadState extends State<ImgUpload> {
  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        titleItem(),
        const SizedBox(
          height: 12.0,
        ),
        photosItem(),
      ],
    );
  }

  /// title
  Widget titleItem() {
    return Text(
      widget.title,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: SCFonts.f16,
        color: SCColors.color_1B1D33,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  /// photosItem
  Widget photosItem() {
    return StaggeredGridView.countBuilder(
        padding: EdgeInsets.zero,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        crossAxisCount: 4,
        shrinkWrap: true,
        itemCount: widget.files.length >= widget.maxCount
            ? widget.maxCount
            : widget.files.length + 1,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return photoItem(index);
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

  /// 图片
  Widget photoItem(int index) {
    if (index == widget.files.length) {
      //加号图案
      return GestureDetector(
        onTap: () {
          addPhotoAction(index);
        },
        child: AspectRatio(
            aspectRatio: 1.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  index == widget.files.length ? 0.0 : 4.0),
              child: SCImage(
                url: widget.addIcon,
                fit: BoxFit.cover,
              ),
            )),
      );
    } else {
      var file = widget.files[index];
      String fileKey = '';
      log("file-->${file}");
      try{
        if (file.isNotEmpty) {
          fileKey = file['fileKey'] ?? '';
        }
      }catch(e){
        e.toString();
        fileKey = file.toString();
      }
      log("fileKey-->${fileKey}");
      return Stack(
        alignment: Alignment.topRight,
        children: [
          GestureDetector(
              onTap: () {
                previewImage(SCConfig.getImageUrl(fileKey));
              },
              child: AspectRatio(
                  aspectRatio: 1.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        index == widget.files.length ? 0.0 : 4.0),
                    child: SCImage(
                      url: SCConfig.getImageUrl(fileKey),
                      fit: BoxFit.cover,
                    ),
                  ))),
          GestureDetector(
            onTap: () {
              setState(() {
                widget.files.removeAt(index);
                widget.updatePhoto?.call(widget.files);
              });
            },
            child: Image.asset(
              SCAsset.iconDeletePhoto,
              width: 22.0,
              height: 22.0,
              fit: BoxFit.fill,
            ),
          ),
        ],
      );
    }
  }

  /// 添加图片
  addPhotoAction(int index) {
    SCUtils().hideKeyboard(context: context);
    if (index == widget.files.length) {
      if (widget.addPhotoType == SCAddPhotoType.photoPicker) {
        //只能从相册选择图片
        SCPermissionUtils.photoPicker(
            maxLength: widget.maxCount - widget.files.length,
            requestType: RequestType.image,
            completionHandler: (imageList) {
              setState(() {
                upLoadPhotos(imageList);
              });
            });
      } else if (widget.addPhotoType == SCAddPhotoType.takePhoto) {
        //只能拍照
        SCPermissionUtils.takePhoto((String path) {
          setState(() {
            upLoadPhotos([path]);
          });
        });
      } else {
        //从相册选择+拍照
        SCPermissionUtils.showImagePicker(
            maxLength: widget.maxCount - widget.files.length,
            requestType: RequestType.image,
            completionHandler: (imageList) {
              setState(() {
                upLoadPhotos(imageList);
              });
            });
      }
    }
  }

  /// 上传照片到服务器
  upLoadPhotos(List photoList) {
    SCUploadUtils.uploadMoreImage(
        imagePathList: photoList,
        url: SCUrl.handleUploadProductImg,
        successHandler: (list) {
          widget.files.addAll(list);
          widget.updatePhoto?.call(widget.files);
        });
  }

  /// 图片预览
  previewImage(String url) {
    SCImagePreviewUtils.previewImage(imageList: [url]);
  }
}
