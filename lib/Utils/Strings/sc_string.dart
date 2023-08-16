import 'package:characters/characters.dart';

class SCStrings {

  /// 防止文字自动换行
  static String autoLineString(String str) {
    if (str.isNotEmpty) {
      return str.fixAutoLines();
    }

    return "";
  }
}

extension SCFixAutoLines on String {
  String fixAutoLines() {
    return Characters(this).join('\u{200B}');
  }

  bool cnIsNumber() {
    final reg = RegExp(r'^-?[0-9]+');
    return reg.hasMatch(this);
  }

  int cnToInt() {
    if (cnIsNumber() == true) {
      var result = int.parse(this).toInt();
      return result;
    }
    return 0;
  }
}
