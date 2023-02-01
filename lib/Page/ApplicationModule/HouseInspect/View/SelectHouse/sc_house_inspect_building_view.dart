import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 选择房号-幢

class SCSelectHouseBuildingView extends StatefulWidget {
  @override
  SCSelectHouseBuildingViewState createState() =>
      SCSelectHouseBuildingViewState();
}

class SCSelectHouseBuildingViewState extends State {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16.0,),
        listView(),
        moreBtn()
      ],
    );
  }

  /// 更多按钮
  Widget moreBtn() {
    return SizedBox(
      width: 48.0,
      height: 51.0,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        minSize: 51.0,
          child: const Text('更 多\n楼 幢', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(
        fontSize: SCFonts.f12,
        fontWeight: FontWeight.w400,
        color: SCColors.color_1B1D33
      ),), onPressed: (){}),
    );
  }

  /// listView
  Widget listView() {
    return Expanded(child: Column(
      children: [
        const Divider(
          height: 1.0,
          color: SCColors.color_E5E6EB,
        ),
        SizedBox(
          height: 51.0,
          child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return cell(index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox();
              },
              itemCount: 19),
        ),
        const Divider(
          height: 1.0,
          color: SCColors.color_E5E6EB,
        ),
      ],
    ));
  }

  /// cell
  Widget cell(int index) {
    String title = "$index";
    Color textColor =
        currentIndex == index ? SCColors.color_FFFFFF : SCColors.color_1B1D33;
    Color buildingTextColor =
    currentIndex == index ? SCColors.color_FFFFFF : SCColors.color_8D8E99;
    Color bgColor =
        currentIndex == index ? SCColors.color_4285F4 : SCColors.color_FFFFFF;
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: Container(
        width: 36.0,
        height: 51.0,
        color: bgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w500,
                  color: textColor),
            ),
            const SizedBox(
              height: 3.0,
            ),
            Text(
              "幢",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: SCFonts.f12,
                  fontWeight: FontWeight.w400,
                  color: buildingTextColor),
            ),
          ],
        ),
      ),
    );
  }

  /// cell 点击
  onTap(int index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }
}
