import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import '../../../../Constants/sc_asset.dart';
import '../../../../Constants/sc_enum.dart';
import '../../../../Utils/Permission/sc_permission_utils.dart';
import '../../../../Utils/sc_utils.dart';

/// 标题+添加图片cell

class SCDeliverEvidenceCell extends StatefulWidget {
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

  SCDeliverEvidenceCell({ Key? key,
    required this.title,
    this.addIcon = SCAsset.iconInspectProblemAddPhoto,
    this.addPhotoType = SCAddPhotoType.all,
    this.maxCount = 8,
    this.updatePhoto}) : super(key: key);

  @override
  SCDeliverEvidenceCellState createState() => SCDeliverEvidenceCellState();
}

class SCDeliverEvidenceCellState extends State<SCDeliverEvidenceCell> {

  List photosList = [];

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
        const SizedBox(height: 12.0,),
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
          fontWeight: FontWeight.w500,
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
        itemCount: photosList.length >= widget.maxCount ? widget.maxCount : photosList.length + 1,
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
    if (index == photosList.length) {
      return GestureDetector(
        onTap: () {
          addPhotoAction(index);
        },
        child: SizedBox(
          width: 79.0,
          height:  79.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(index == photosList.length ? 0.0 : 4.0),
            child: Image.asset(
              widget.addIcon,
              width: 79.0,
              height: 79.0,
              fit: BoxFit.fill,),)
        ),
      );
    } else {
      return SizedBox(
        width: 79.0,
        height:  79.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(index == photosList.length ? 0.0 : 4.0),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Image.asset(
                photosList[index],
                width: 79.0,
                height: 79.0,
                fit: BoxFit.fill,),
              GestureDetector(
                onTap: () {
                  setState(() {
                    photosList.removeAt(index);
                    widget.updatePhoto?.call(photosList);
                  });
                },
                child: Image.asset(
                  SCAsset.iconDeletePhoto,
                    width: 22.0,
                    height: 22.0,
                    fit: BoxFit.fill,),
              ),
            ],
          )
        )
      );
    }
  }

  /// 添加图片
  addPhotoAction(int index) {
    SCUtils().hideKeyboard(context: context);
    if (index == photosList.length) {
      if (widget.addPhotoType == SCAddPhotoType.photoPicker) {//只能从相册选择图片
        SCPermissionUtils.photoPicker(
            maxLength: widget.maxCount - photosList.length,
            requestType: RequestType.image,
            completionHandler: (imageList) {
              setState(() {
                photosList.addAll(imageList);
                widget.updatePhoto?.call(photosList);
              });
            });
      } else if (widget.addPhotoType == SCAddPhotoType.takePhoto) {//只能拍照
        SCPermissionUtils.takePhoto((String path){
          setState(() {
            photosList.add(path);
            widget.updatePhoto?.call(photosList);
          });
        });
      } else {
        //从相册选择+拍照
        SCPermissionUtils.showImagePicker(
            maxLength: widget.maxCount - photosList.length,
            requestType: RequestType.image,
            completionHandler: (imageList) {
              setState(() {
                photosList.addAll(imageList);
                widget.updatePhoto?.call(photosList);
              });
            });
      }
    }
  }

  upLoadPhotos() {

  }
}
