import 'package:flutter/material.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';

/// 通讯录-page

class SCAddressBookPage extends StatefulWidget {
  @override
  SCAddressBookPageState createState() => SCAddressBookPageState();
}

class SCAddressBookPageState extends State<SCAddressBookPage> {
  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
    );
  }
}