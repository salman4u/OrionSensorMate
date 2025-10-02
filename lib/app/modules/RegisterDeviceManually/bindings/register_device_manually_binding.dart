import 'package:get/get.dart';

import '../controllers/register_device_manually_controller.dart';

class RegisterDeviceManuallyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterDeviceManuallyController>(
      () => RegisterDeviceManuallyController(),
    );
  }
}
