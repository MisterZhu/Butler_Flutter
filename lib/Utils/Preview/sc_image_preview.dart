/// 图片预览
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../Constants/sc_asset.dart';
import '../../Network/sc_config.dart';

class SCPhotoView extends StatefulWidget {
  SCPhotoView({Key? key,
    required this.imageList,
    this.defaultIndex = 0,
    this.pageChanged,
    this.direction = Axis.horizontal,
    this.needPerfix = false,
    required this.decoration})
      : super(key: key);

  /*图片列表*/
  final List<String> imageList;

  /*默认第几张*/
  final int defaultIndex;

  /*切换图片回调*/
  final Function(int index)? pageChanged;

  /*图片查看方向*/
  final Axis direction;

  /*背景设计*/
  final BoxDecoration decoration;

  final bool needPerfix;

  @override
  SCPhotoViewState createState() => SCPhotoViewState();
}

class SCPhotoViewState extends State<SCPhotoView> {
  String title = '';
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
        color: SCColors.color_000000,
        child: Stack(
          children: [
            contentWidget(),
            Positioned(
              left: 0,
              right: 0,
              top: MediaQuery
                  .of(context)
                  .padding
                  .top,
              height: 44.0,
              child: titleWidget(),
            ),
            Positioned(
                top: MediaQuery
                    .of(context)
                    .padding
                    .top + 10.0,
                right: 16.0,
                child: closeWidget())
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    currentIndex = widget.defaultIndex;
    title = '${currentIndex + 1}/${widget.imageList.length}';
  }

  Widget contentWidget() {
    BoxDecoration decoration = widget.decoration;
    return PhotoViewGallery.builder(
      backgroundDecoration: decoration,
      scrollDirection: widget.direction,
      itemCount: widget.imageList.length,
      pageController: PageController(initialPage: widget.defaultIndex),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(imageProvider: imageProvider(index));
      },
      onPageChanged: (int index) {
        setState(() {
          currentIndex = index;
          title = '${currentIndex + 1}/${widget.imageList.length}';
        });
        if (widget.pageChanged != null) {
          widget.pageChanged?.call(index);
        }
      },
    );
  }

  /// image
  ImageProvider imageProvider(int index) {
    String url = widget.needPerfix ? SCConfig.getImageUrl(
        widget.imageList[index]) : widget.imageList[index];
    if (url.contains('http')) {
      return CachedNetworkImageProvider(url);
    } else {
      return AssetImage(url);
    }
  }

  /// close按钮
  Widget closeWidget() {
    return SizedBox(
      width: 24.0,
      height: 24.0,
      child: InkWell(
        onTap: () {
          closeAction();
        },
        child: Image.asset(
          SCAsset.iconWhiteClose,
          width: 25.0,
          height: 25.0,
        ),
      ),
    );
  }

  /*title*/
  Widget titleWidget() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        title,
        style: const TextStyle(color: SCColors.color_FFFFFF, fontSize: 14.0),
      ),
    );
  }

  /*关闭*/
  void closeAction() {
    Navigator.of(context).pop();
  }
}
