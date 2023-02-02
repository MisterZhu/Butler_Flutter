import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../Constants/sc_asset.dart';
import '../../../../Utils/Permission/sc_permission_utils.dart';
import '../../../../Utils/sc_utils.dart';

/// 交付凭证cell
class SCDeliverEvidenceCell extends StatefulWidget {

  SCDeliverEvidenceCell({ Key? key,}) : super(key: key);

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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          titleItem(),
          const SizedBox(height: 12.0,),
          photosItem(),
        ],
      ),
    );
  }

  /// title
  Widget titleItem() {
    return const Text(
        '交付凭证',
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
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
        itemCount: photosList.length >= 9 ? 9 : photosList.length + 1,
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
    return GestureDetector(
      onTap: () {
        SCUtils().hideKeyboard(context: context);
        if (index == photosList.length) {
          SCPermissionUtils.takePhoto((String path){
            setState(() {
              photosList.add(path);
            });
          });
        }
      },
      child: SizedBox(
          width: 79.0,
          height:  79.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child:Image.asset(
              index == photosList.length ? SCAsset.iconInspectProblemAddPhoto : photosList[index],
              width: 79.0,
              height: 79.0,
              fit: BoxFit.fill,),
          )
      ),
    );
  }
}
