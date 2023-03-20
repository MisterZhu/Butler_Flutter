import 'package:flutter/material.dart';
import 'package:smartcommunity/Page/Message/View/sc_message_cell.dart';

/// 消息listview
class SCMessageListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return SCMessageCell(type: index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10.0,);
        },
        itemCount: 5);
  }

}