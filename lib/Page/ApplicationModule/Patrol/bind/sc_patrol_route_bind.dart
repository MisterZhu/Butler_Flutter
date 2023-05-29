import 'package:get/get.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Controller/sc_patrol_route_controller.dart';

class PatrolRouteBinding extends Bindings{
  @override
  void dependencies() {
     Get.lazyPut<ScPatrolRouteController>(() => ScPatrolRouteController());
  }

}