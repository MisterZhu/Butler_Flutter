import 'package:smartcommunity/Constants/sc_enum.dart';
import 'package:smartcommunity/Network/sc_config.dart';
import 'package:smartcommunity/sc_app.dart';

void main() async{
  /// todo 每次打包需要切换环境，研发、预发、生产
  SCConfig.env = SCEnvironment.develop;
  startApp();
}
