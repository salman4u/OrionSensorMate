import 'package:get/get.dart';

import '../controllers/sensor_settings_controller.dart';

class SensorSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SensorSettingsController>(
      () => SensorSettingsController(),
    );
  }
}
