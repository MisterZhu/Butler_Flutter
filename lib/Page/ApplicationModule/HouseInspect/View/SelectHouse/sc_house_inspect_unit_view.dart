import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 选择房号-单元view

class SCSelectHouseUnitView extends StatefulWidget {
  @override
  SCSelectHouseUnitViewState createState() => SCSelectHouseUnitViewState();
}

class SCSelectHouseUnitViewState extends State<SCSelectHouseUnitView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 82.0,
      color: SCColors.color_F7F8FA,
      child: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return cell(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox();
          },
          itemCount: 19),
    );
  }

  /// cell
  Widget cell(int index) {
    Color textColor =
        currentIndex == index ? SCColors.color_1B1D33 : SCColors.color_5E5F66;
    Color bgColor =
        currentIndex == index ? SCColors.color_FFFFFF : Colors.transparent;
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(color: bgColor),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80.0,
              height: 60.0,
              alignment: Alignment.center,
              child: Text(
                '$index单元',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w500,
                    color: textColor),
              ),
            ),
            Offstage(
              offstage: currentIndex == index ? false : true,
              child: Container(
                width: 2.0,
                height: 24.0,
                color: SCColors.color_4285F4,
              ),
            )
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
