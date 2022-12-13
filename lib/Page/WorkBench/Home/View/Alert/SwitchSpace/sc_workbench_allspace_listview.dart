import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 空间listView

class SCAllSpaceListView extends StatelessWidget {
  final List list = [
    '慧享雅苑1',
    '慧享雅苑2',
    '慧享雅苑3',
    '慧享雅苑4',
    '慧享雅苑5',
    '慧享雅苑6',
    '慧享雅苑7',
    '慧享雅苑8',
    '慧享雅苑9',
    '慧享雅苑10',
    '慧享雅苑11',
    '慧享雅苑12',
    '慧享雅苑13',
    '慧享雅苑14',
    '慧享雅苑15',
    '慧享雅苑16',
    '慧享雅苑17',
    '慧享雅苑18',
    '慧享雅苑19',
    '慧享雅苑20',
    '慧享雅苑21',
    '慧享雅苑22',
    '慧享雅苑23',
    '慧享雅苑24',
    '慧享雅苑25',
    '慧享雅苑26',
    '慧享雅苑27',
    '慧享雅苑28',
    '慧享雅苑29',
    '慧享雅苑30'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.only(top: 2.0, left: 16.0, right: 22.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return cell(index);
        },
        itemCount: list.length);
  }

  /// cell
  Widget cell(int index) {
    String letter = index == 0 ? 'A' : '';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0),
      child: Row(
        children: [
          SizedBox(
            width: 18.0,
            child: Text(
              letter,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_B0B1B8),
            ),
          ),
          Expanded(
              child: Text(
            list[index],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w400,
                color: SCColors.color_1B1D33),
          ))
        ],
      ),
    );
  }

  /// separator
  Widget separator(int index) {
    return const SizedBox(
      height: 18.0,
    );
  }
}
