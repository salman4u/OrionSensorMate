import 'package:get/get.dart';

import '../controllers/pair_sensor_device_controller.dart';

class PairSensorDeviceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PairSensorDeviceController>(
      () => PairSensorDeviceController(),
    );
  }
}
