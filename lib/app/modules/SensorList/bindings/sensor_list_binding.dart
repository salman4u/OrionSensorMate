import 'package:get/get.dart';

import '../controllers/sensor_list_controller.dart';

class SensorListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SensorListController>(
      () => SensorListController(),
    );
  }
}
