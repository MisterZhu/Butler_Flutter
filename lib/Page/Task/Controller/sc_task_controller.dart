
import 'dart:async';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../Utils/Date/sc_date_utils.dart';

class SCTaskController extends GetxController {

  List testTimeList = ['2023-3-22 10:00:00', '2023-2-30 10:00:00', '2023-3-25 10:00:50', '2023-4-10 12:10:33', '2023-4-5 01:12:36'];

  List timeList = [];
  /// 定时器
  Timer? timer;

  /// 剩余时间
  int remainingTime = 0;

  @override
  onInit() {
    super.onInit();
    for (String time in testTimeList) {
      DateTime endDate = SCDateUtils.stringToDateTime(dateString: time, formateString: 'yyyy-MM-dd HH:mm:ss');
      print('endDate=====$endDate');
      int remainingTime = (endDate.millisecondsSinceEpoch - SCDateUtils.timestamp()) ~/ 1000;
      print('remainingTime=====$remainingTime');
      timeList.add(remainingTime);
    }

  }

  @override
  onClose() {
    super.onClose();
    closeTimer();
  }

  /// 定时器
  // startTimer() {
  //   timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     if (remainingTime > 0) {
  //       remainingTime--;
  //       update();
  //     } else {
  //       closeTimer();
  //       update();
  //     }
  //   });
  // }


  /// 定时器
  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        for (int i = 0; i < timeList.length; i++) {
            int subTime = timeList[i] ?? 0;
            if (subTime > 0) {
              timeList[i] = subTime - 1;
            } else if (subTime == 0) {
              timeList[i] = 0;
            } else {}
        }
        update();
    });
  }

  /// 关闭定时器
  closeTimer() {
    timer?.cancel();
  }

}