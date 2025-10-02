import 'package:get/get.dart';

import '../controllers/sensor_details_controller.dart';

class SensorDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SensorDetailsController>(
      () => SensorDetailsController(),
    );
  }
}
